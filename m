From: khilman@ti.com (Kevin Hilman)
Date: Thu, 04 Aug 2011 08:05:20 -0700
Subject: [PATCHv5 1/3] OMAP: I2C: Reset support
In-Reply-To: <4E3A3B48.2050108@ti.com> (shubhrajyoti@ti.com's message of "Thu,
	04 Aug 2011 11:55:12 +0530")
References: <1311935813-8481-1-git-send-email-shubhrajyoti@ti.com>
	<1311935813-8481-2-git-send-email-shubhrajyoti@ti.com>
	<87sjpj75yq.fsf@ti.com> <4E3A3B48.2050108@ti.com>
Message-ID: <87d3gl43pr.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti <shubhrajyoti@ti.com> writes:

> On Wednesday 03 August 2011 04:53 AM, Kevin Hilman wrote:
>> Shubhrajyoti D<shubhrajyoti@ti.com>  writes:
>>
>>>   Under some error conditions the i2c  driver may do a reset.
>>    ^                                    ^
>> minor: extra whitespace
>>
>>>   Adding a reset field and support in the platform.
>> s/platform/device-specific code/
>>
> Yes will fix these.
>>> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
>> That being said, omap_device_shutdown() should already do a clean
>> shutdown + reset for you, and i2c-omap.h already has a pointer for
>> ->device_shutdown() so a new device_reset() should not be needed.
>>
>> IOW, simply adding pdata->device_shutdown = omap_device_shutdown()
>> should work.
> i2C has a special reset sequence ie Disable -> reset -> enable -> Poll
> on reset done.
> This function is implemented in omap_i2c_reset. The
>
> omap_hwmod_reset calls ->  _reset
>
> which calls ocp_softrest  or custom reset if it is present.The latter
> is true for I2C.
>
> However I see that
>
> omap_device_shutdown ->  _assert_hardreset However for I2c there doesnt seem to be a HW reset line.
>
>
> Am I missing something?
>

No, my fault.

I thought omap_device_shutdown() also did soft reset, but I see that's
not the case.  You can ignore my comments about using
omap_device_shutdown.

Kevin
