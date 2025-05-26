#!/bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on
echo 'guff and stuff v4' > /var/www/html/index.html

wget https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz
tar xvfz node_exporter-1.9.1.linux-amd64.tar.gz
cd node_exporter-1.9.1.linux-amd64
cp node_exporter /usr/local/bin/
#./node_exporter
cd /etc/systemd/system/
useradd node_exporter
cat > node_exporter.service <<- "EOF"
#Node Exporter service file — /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter