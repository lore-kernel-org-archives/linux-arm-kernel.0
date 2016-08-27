From: randy.li@rock-chips.com (Randy Li)
Date: Sat, 27 Aug 2016 17:55:40 +0800
Subject: MFC: different h264 profile and level output the same size encoded
 result
Message-ID: <3c01aadb-259f-0f38-47be-8170a87a7d7b@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:

   I have been reported that the setting the profile, level and bitrate 
through the v4l2 extra controls would not make the encoded result 
different. I tried it recently, it is true. Although the h264 parser 
would tell me the result have been applied as different h264 profile and 
level, but size is the same.

You may try this in Gstreamer.

gst-launch-1.0 -v \
videotestsrc num-buffers=500 ! video/x-raw, width=1920,height=1080 ! \
videoconvert ! \
v4l2video4h264enc 
extra-controls="controls,h264_profile=1,video_bitrate=100;" ! \
h264parse ! matroskamux ! filesink location=/tmp/1.mkv

Is there any way to reduce the size of MFC encoded data?
