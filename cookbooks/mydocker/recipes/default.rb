
# Cookbook:: mydocker
# Recipe:: default

# Copyright:: 2022, The Authors, All Rights Reserved.
docker_service 'default' do
    action [:create, :start]
end


docker_image 'nginx' do
    tag 'latest'
    action :pull
end


     # Run container exposing ports
docker_container 'my_nginx' do
    repo 'nginx'
    tag 'latest'
    port '80:80'
    volumes "/home/docker/default.conf:/etc/nginx/conf.d/default.conf:ro"
    volumes "/home/docker/html:/usr/share/nginx/html"
end

       # create file default.conf for volumes doccker
template "/home/docker/default.conf" do
    source "default.conf.erb"
   #notifies :reload, "service[default]"
end

   # create file index.html for volumes docker
template '/home/docker/html/index.html' do
    source 'index.html.erb'
    variables(
       :ambiente => node.chef_environment
    )
    action :create
             #notifies :restart, 'service[httpd]', :immediately
end
             
