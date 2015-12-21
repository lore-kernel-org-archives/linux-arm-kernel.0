From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 21 Dec 2015 11:37:34 -0300
Subject: [PATCH 2/2] [media] media-device: split media initialization and
 registration
In-Reply-To: <20151215091342.2f825d91@recife.lan>
References: <1441890195-11650-1-git-send-email-javier@osg.samsung.com>
 <1441890195-11650-3-git-send-email-javier@osg.samsung.com>
 <55F1BA5C.50508@linux.intel.com> <20151215091342.2f825d91@recife.lan>
Message-ID: <56780EAE.7090909@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mauro,

On 12/15/2015 08:13 AM, Mauro Carvalho Chehab wrote:

[snip]

>>>  
>>>  /**
>>> - * media_device_register - register a media device
>>> + * media_device_init() - initialize a media device
>>>   * @mdev:	The media device
>>>   *
>>>   * The caller is responsible for initializing the media device before
>>> @@ -534,12 +534,11 @@ static void media_device_release(struct media_devnode *mdev)
>>>   *
>>>   * - dev must point to the parent device
>>>   * - model must be filled with the device model name
>>> + *
>>> + * returns zero on success or a negative error code.
>>>   */
>>> -int __must_check __media_device_register(struct media_device *mdev,
>>> -					 struct module *owner)
>>> +int __must_check media_device_init(struct media_device *mdev)
>>
>> I think I suggested making media_device_init() return void as the only
>> remaining source of errors would be driver bugs.
>>
>> I'd simply replace the WARN_ON() below with BUG().
> 
> That sounds like bad idea to me, and it is against the current
> Kernel policy of using BUG() only when there's no other way, e. g. on
> event so severe that the Kernel has no other thing to do except to
> stop running.
>

I agree with you, that was exactly my point and what I told Sakari [0] but
he had a strong opinion about it and I didn't mind too much so I decided at
the end to just change it to a BUG_ON() so I could get his ack for this set.
 
> For sure, this is not the case here. Also, all drivers have already
> a logic that checks if the device init happened. So, they should already
> be doing the right thing.
>
> Regards,
> Mauro

[0]: https://lkml.org/lkml/2015/9/10/483

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
