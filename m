From: joelf@ti.com (Joel Fernandes)
Date: Wed, 11 Sep 2013 01:00:08 -0500
Subject: [PATCH 0/3] ARM: dts: Enable EDMA, MMC and SPI on AM33XX for v3.13
In-Reply-To: <88E4C15C-B1AA-4A39-A5E1-CF9E8420C2BE@dominion.thruhere.net>
References: <1378841079-15796-1-git-send-email-joelf@ti.com>
 <5EB8AE91-A996-4CF1-86B7-C8FDEC177E89@dominion.thruhere.net>
 <522F7DC0.7030603@ti.com>
 <88E4C15C-B1AA-4A39-A5E1-CF9E8420C2BE@dominion.thruhere.net>
Message-ID: <523006E8.5080104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2013 12:18 AM, Koen Kooi wrote:
> 
> Op 10 sep. 2013, om 22:14 heeft Joel Fernandes <joelf@ti.com> het volgende geschreven:
> 
>> On 09/10/2013 02:39 PM, Koen Kooi wrote:
>>>
>>> Op 10 sep. 2013, om 21:24 heeft Joel Fernandes <joelf@ti.com> het volgende geschreven:
>>>
>>>> Here are last few patches required to add EDMA and MMC/SPI support for AM33xx.
>>>>
>>>> Now that all dependent DMA patches and fixes are in linux next or mainline, except
>>>> for [1] which should go in for 3.12 -rc cycle, it is safe to enable MMC and SPI support
>>>> and this patch series enables it. These are originally Matt Porter's patches with
>>>> changes to make it work with recent kernels, addition of irq, memory resources and
>>>> enable other extra properties.
>>>>
>>>> These patches should cleanly apply on master branch after Koen's patch [2] for basic
>>>> BBB DT support is applied.
>>>>
>>>> MMC support is enabled for: Beaglebone, AM335x EVM and EVM-SK boards. MMC support
>>>> for BBB is intentionally not added due to custom fixes and other patches that are
>>>> in Koen's tree and which will be separately submitted by him.
>>>
>>> Correct, but your patches for MMC support on BBW are missing the card detect entries to make it hotplug work.
>>
>> I thought it was determined that this would be submitted by you separately after
>> rebasing as we discussed [1] and [2].
> 
> I have no problem submitting that, I just think it's weird that the patch you submitted contains a known broken version for BBW.

There's nothing "broken" about $subject series. Please don't confuse maintainers
by using wrong words like that. This series is perfectly OK as such to be merged.

Further, I am puzzled by all this noise because card-detect additions were
initially agreed to be posted separately by you along with other custom DTS for
BBW MMC. Its obvious I wouldn't squash patches that we _agreed_ you would send
out- and that are especially additions than any real fixes. Hopefully this makes
it clear, if you need any help please let me know.

Thanks!

-Joel


>>
>> [1] https://lkml.org/lkml/2013/9/6/183
>> [2] http://marc.info/?l=linux-omap&m=137879246709612&w=2
>>
>>
>> Regards,
>>
>> -Joel
> 
