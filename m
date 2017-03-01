From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Tue, 28 Feb 2017 16:20:07 -0800
Subject: [PATCH v4 15/36] platform: add video-multiplexer subdevice driver
In-Reply-To: <20170227144153.g4jzzbrcb7oyddyj@rob-hp-laptop>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-16-git-send-email-steve_longerbeam@mentor.com>
 <20170227144153.g4jzzbrcb7oyddyj@rob-hp-laptop>
Message-ID: <6262f5bd-08e0-20b0-9e41-a01db75587dd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/27/2017 06:41 AM, Rob Herring wrote:
> On Wed, Feb 15, 2017 at 06:19:17PM -0800, Steve Longerbeam wrote:
>> From: Philipp Zabel <p.zabel@pengutronix.de>
>>
>> This driver can handle SoC internal and external video bus multiplexers,
>> controlled either by register bit fields or by a GPIO. The subdevice
>> passes through frame interval and mbus configuration of the active input
>> to the output side.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>>
>> --
>>
>> - fixed a cut&paste error in vidsw_remove(): v4l2_async_register_subdev()
>>    should be unregister.
>>
>> - added media_entity_cleanup() and v4l2_device_unregister_subdev()
>>    to vidsw_remove().
>>
>> - added missing MODULE_DEVICE_TABLE().
>>    Suggested-by: Javier Martinez Canillas <javier@dowhile0.org>
>>
>> - there was a line left over from a previous iteration that negated
>>    the new way of determining the pad count just before it which
>>    has been removed (num_pads = of_get_child_count(np)).
>>
>> - Philipp Zabel has developed a set of patches that allow adding
>>    to the subdev async notifier waiting list using a chaining method
>>    from the async registered callbacks (v4l2_of_subdev_registered()
>>    and the prep patches for that). For now, I've removed the use of
>>    v4l2_of_subdev_registered() for the vidmux driver's registered
>>    callback. This doesn't affect the functionality of this driver,
>>    but allows for it to be merged now, before adding the chaining
>>    support.
>>
>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>> ---
>>   .../bindings/media/video-multiplexer.txt           |  59 +++
> Please make this a separate commit.

Done.

Steve
