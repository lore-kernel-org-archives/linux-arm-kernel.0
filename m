From: songjun.wu@atmel.com (Wu, Songjun)
Date: Tue, 19 Apr 2016 16:29:04 +0800
Subject: [PATCH 1/2] [media] atmel-isc: add the Image Sensor Controller
 code
In-Reply-To: <57148B9E.2000609@xs4all.nl>
References: <1460533460-32336-1-git-send-email-songjun.wu@atmel.com>
 <1460533460-32336-2-git-send-email-songjun.wu@atmel.com>
 <57148B9E.2000609@xs4all.nl>
Message-ID: <5715EC50.5050500@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/18/2016 15:24, Hans Verkuil wrote:
> On 04/13/2016 09:44 AM, Songjun Wu wrote:
>> Add driver for the Image Sensor Controller. It manages
>> incoming data from a parallel based CMOS/CCD sensor.
>> It has an internal image processor, also integrates a
>> triple channel direct memory access controller master
>> interface.
>>
>> Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
>
> Hi Songjun,
>
> Before this driver can be accepted it has to pass the v4l2-compliance test.
> The v4l2-compliance utility is here:
>
> git://linuxtv.org/v4l-utils.git
>
> Compile the utility straight from this repository so you're up to date.
>
> First fix any failures you get when running 'v4l2-compliance', then do the
> same when running 'v4l2-compliance -s' (now it is streaming as well) and
> finally when running 'v4l2-compliance -f' (streaming and testing all available
> formats).
>
> I would like to see the output of 'v4l2-compliance -f' as part of the cover
> letter of the next patch series.
>
> Looking at the code I see that it will definitely fail a few tests :-)
>
> Certainly the VIDIOC_CREATE_BUFS support in the queue_setup function is missing.
> Read the comments for queue_setup in videobuf2-core.h for more information.
>
Thank you very much, I will pass the v4l2-compliance test before I send 
the version 2 patch.

> Regards,
>
> 	Hans
>
