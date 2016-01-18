# sudo yum install git
# sudo yum install jq
# sudo pip install tweepy
# aws s3 cp s3://twit-candi-2016/dist/creds.json .

export app_dir=~/generic-tweet-collector
export data_dir=${app_dir}/data
export script_dir=${app_dir}/dist
export log_dir=${app_dir}/log
export old_dir=${app_dir}/old

# mkdir -p ${app_dir}/data
mkdir -p ${app_dir}/log

# to add other volume
# lsblk 
# check if there is a filesystem already
# sudo file -s /dev/xvdf
# make a mount point
# sudo mkdir ${app_dir}/data
# mount it
# sudo mount /dev/xvdf ${app_dir}/data/
# chown -R ec2-user:ec2-user data

cp tc_application.py ${data_dir}/
cp config.json ${data_dir}/
cp creds.json ${data_dir}/

echo "** [ TC-SETUP ] : Setting up filesystem in $data_dir."
fd=`cat ${data_dir}/config.json | jq -r '.folders[]'`
echo "** Data folders are $fd"

for f in $fd; do
  mkdir -p ${data_dir}/$f
done  
echo "** [ TC-SETUP ] : Data folders created."

echo "** [ TC-SETUP ] : Making scripts executable."
chmod 777 ${data_dir}/tc_application.py
