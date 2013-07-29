From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 29 Jul 2013 11:23:01 -0400
Subject: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping
 for every GPIO on DT"
In-Reply-To: <51F687B3.7030902@ahsoftware.de>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com>
 <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com>
 <51F633AE.8090308@collabora.co.uk> <51F63864.9000601@collabora.co.uk>
 <51F666B7.7020209@ti.com> <51F681C4.3000400@ahsoftware.de>
 <51F684F2.5050308@ti.com> <51F687B3.7030902@ahsoftware.de>
Message-ID: <51F688D5.4050501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 July 2013 11:18 AM, Alexander Holler wrote:
> Am 29.07.2013 17:06, schrieb Santosh Shilimkar:
>> On Monday 29 July 2013 10:52 AM, Alexander Holler wrote:
>>> Am 29.07.2013 14:57, schrieb Santosh Shilimkar:
>>>
>>>> With some helps from MMC and other guys, we validated the Linus's tip which includes
>>>> your patches. It actually doesn't break anything and as OMAP hsmmc maintainer
>>>> clarified, the cd-gpios isn't supported yet for DT. While supporting that it
>>>> can use appropriate binding whichever works.
>>>>
>>>> But with OMAP1 breakage reported by Paul, I think we are not left with choice
>>>> but to revert those commits. We *must* respect rc rules for the fixes.
>>>> *No regression*
>>>>
>>>> Thanks for your hardwork to cook up those patches but now Linus's W proposal
>>>> is going to be generic, hopefully the issue can be address better. Till
>>>> then we can't get the ethernet support.
>>>
>>> The problem never was just the omap_hsmmc driver. I rather would say all drivers which do use GPIOs as IRQs were affected.
>>>
>>> I've only used the omap_hsmmc driver as example, because that was the driver I've tried to actually use with sd-cards, which is rather impossible without having a working CD-signal. And all code was already there and seems to work (at least during my few tests), so I've just added an entry to the dts to be able to use a mmc-slot as one would expect a mmc-slot does work.
>>>
>>> If someone wants to test a new feature at the same front, I would suggest to try it out using gpio-keys. That driver should work on almost any architecture/platform/hardware which supports gpios and is small enough to be a good test candidate. Having had a short look at gpio-keys.c, I think the same problems as with omap_hsmmc would have been occured when someone had tried to use that driver with 3.11-rc2.
>>>
>> The 3 OMAP platforms which supports DT are AM33XX, OMAP4 and OMAP5.
>> OMAP3 based boards are getting converted but they are bit far from being
>> DT only. So my statement was again from what we support on mainline today
>> and those platform don't use gpio-keys. But for testing perspective,
>> I guess its good idea.
>>
> 
> I wonder how you do know that no board with OMAP chips does use gpio-keys?
> 
> Does TI restrict their users/customers to only certified drivers? ;)
> 
I just grep on kernel.org tree and my comment was restricted to what
is current state in mainline for DT. I never said it can't be used or
no board is using it. Sorry if i was not clear enough.

Regards,
Santosh
