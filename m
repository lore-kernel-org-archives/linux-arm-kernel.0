From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri, 18 Mar 2016 08:17:29 -0600
Subject: [PATCH] [media] media: rename media unregister function
In-Reply-To: <56EC0CC4.1070309@osg.samsung.com>
References: <2ffc02c944068b2c8655727238d1542f8328385d.1458306276.git.mchehab@osg.samsung.com>
 <56EC0A55.3010803@osg.samsung.com> <56EC0CC4.1070309@osg.samsung.com>
Message-ID: <56EC0DF9.4050601@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2016 08:12 AM, Javier Martinez Canillas wrote:
> Hello Shuah,
> 
> On 03/18/2016 11:01 AM, Shuah Khan wrote:
>> On 03/18/2016 07:05 AM, Mauro Carvalho Chehab wrote:
>>> Now that media_device_unregister() also does a cleanup, rename it
>>> to media_device_unregister_cleanup().
>>>
>>> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
>>
>> I think adding cleanup is redundant. media_device_unregister()
>> would imply that there has to be some cleanup releasing resources.
>> I wouldn't make this change.
>>
> 
> Problem is that there is a media_device_init() and media_device_register(),
> so having both unregister and cleanup in this function will make very clear
> that a single function is the counter part of the previous two operations.
>  

Yes. I realized that this change is motivated by the fact that there is
the media_device_init() and we had the counterpart media_device_cleanup()
as an exported function. I still think there is no need to make the change
to add _cleanup() at the end of media_device_unregister(). It can be handled
in API documentation that it does both.

thanks,
-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh at osg.samsung.com | (970) 217-8978
