#
# Cookbook Name:: htpasswd
# Provider:: htpasswd
# Author:: Guilhem Lettron <guilhem.lettron@youscribe.com>
#
# Copyright 20012, Societe Publica.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

def initialize(*args)
  super
  @action = :add
end

action :add do
  if ::File.exists?(new_resource.file)
    add
  else
    create
  end
end

action :overwrite do
  create
end

action :delete do
  delete
end

private

def create
  execute "create htpasswd" do
    command "htpasswd -c -b #{new_resource.file} #{new_resource.user} #{new_resource.password}"
  end
  new_resource.updated_by_last_action(true)
end

def add
  execute "add to htpasswd" do
    command "htpasswd -b #{new_resource.file} #{new_resource.user} #{new_resource.password}"
  end
  new_resource.updated_by_last_action(true)
end

def delete
  execute "delete from htpasswd" do
    command "htpasswd -D #{new_resource.file} #{new_resource.user}"
  end
  new_resource.updated_by_last_action(true)
end
