From: noralf@tronnes.org (=?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?=)
Date: Wed, 17 Jun 2015 12:58:47 +0200
Subject: [PATCH v2 2/3] watchdog: bcm2835: Add poweroff code for the
 Raspberry Pi
In-Reply-To: <5580CD4B.70003@wwwdotorg.org>
References: <1434195541-28368-1-git-send-email-noralf@tronnes.org>
 <1434195541-28368-2-git-send-email-noralf@tronnes.org>
 <557F930E.8010002@wwwdotorg.org> <557FEECE.9060909@tronnes.org>
 <5580CD4B.70003@wwwdotorg.org>
Message-ID: <558152E7.9020606@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 17.06.2015 03:28, skrev Stephen Warren:
> On 06/16/2015 03:39 AM, Noralf Tr?nnes wrote:
>> Den 16.06.2015 05:07, skrev Stephen Warren:
>>> On 06/13/2015 05:39 AM, Noralf Tr?nnes wrote:
>>>> This adds a new poweroff function to the watchdog driver for the
>>>> Raspberry Pi. Currently poweroff/halt results in a reboot.
>>>>
>>>> The Raspberry Pi firmware uses the RSTS register to know which
>>>> partiton to boot from. The partiton value is spread into bits
>>>> 0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
>>>> the firmware to indicate halt.
>>>>
>>>> The firmware made this change in 19 Aug 2013 and was matched
>>>> by the downstream commit:
>>>> Changes for new NOOBS multi partition booting from gsh
>>> I don't understand why we need a new compatible value here; why not
>>> simply modify the existing bcm2835_power_off() function. That is written
>>> to do something that's interpreted by the RPi firmware, not something
>>> that the bcm2835 HW does.
>>>
>>> Admittedly the current name is a bit misleading, but fixing that should
>>> be a separate change to fixing the implementation to do what the current
>>> firmware expects.
>> There are other boards that use the BCM2835 and I didn't want to break the
>> behaviour for those that use the reference firmware.
> We don't support those other board in mainline Linux AFAIK. In other
> discussions, Eric Anholt stated that the Roku 2 for example doesn't use
> the same firmware (albeit they were derived from the same base a long
> way back apparently) so I have no good reason to believe this logic is a
> standard across difference bcm2835 devices. Do you know more specific
> details?

I didn't know that only Raspberry Pi was supported and I have no details 
about
the other boards. I'll send a new patch. Thanks.
