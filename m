From: randy.li@rock-chips.com (Randy Li)
Date: Mon, 29 Aug 2016 13:58:59 +0800
Subject: MFC: different h264 profile and level output the same size
 encoded result
In-Reply-To: <75aa1b3d-9270-3af1-f74b-dba4ceeb41a0@samsung.com>
References: <3c01aadb-259f-0f38-47be-8170a87a7d7b@rock-chips.com>
 <75aa1b3d-9270-3af1-f74b-dba4ceeb41a0@samsung.com>
Message-ID: <75350f97-2d82-9a3d-1611-1bac55933f32@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/29/2016 01:49 PM, Andrzej Hajda wrote:
> Hi,
>
> On 08/27/2016 11:55 AM, Randy Li wrote:
>> Hi:
>>
>>    I have been reported that the setting the profile, level and bitrate
>> through the v4l2 extra controls would not make the encoded result
>> different. I tried it recently, it is true. Although the h264 parser
>> would tell me the result have been applied as different h264 profile and
>> level, but size is the same.
>>
>> You may try this in Gstreamer.
>>
>> gst-launch-1.0 -v \
>> videotestsrc num-buffers=500 ! video/x-raw, width=1920,height=1080 ! \
>> videoconvert ! \
>> v4l2video4h264enc
>> extra-controls="controls,h264_profile=1,video_bitrate=100;" ! \
>> h264parse ! matroskamux ! filesink location=/tmp/1.mkv
>>
>> Is there any way to reduce the size of MFC encoded data?
>>
>
> There is control called rc_enable (rate control enable), it must be set
> to one if you want to control bitrate.
> This control confuses many users, I guess it cannot be removed as it
> is already part of UAPI, but enabling it internally by the driver
> if user sets bitrate, profille, etc, would make it more saner.
I see, thank you so much.
A guy told me that the "frame_level_rate_control_enable=1" in _ 
extra-controls="encode,h264_level=10,h264_profile=4,frame_level_rate_control_enable=1,video_bitrate=2097152"
would also make it works.
But I really know there is a switch need to turn on.

>
> Regards
> Andrzej
>
>

-- 
Randy Li
The third produce department
