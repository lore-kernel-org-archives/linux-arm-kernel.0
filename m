From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 11 Jan 2017 13:53:59 +0530
Subject: [PATCH v2 3/5] ARM: davinci_all_defconfig: enable iio and ADS7950
In-Reply-To: <01ec2c94-46e0-3534-94e8-bd92f78b70ec@lechnology.com>
References: <1483677228-2325-1-git-send-email-david@lechnology.com>
 <1483677228-2325-4-git-send-email-david@lechnology.com>
 <cb9455bc-2658-9826-823b-2aa845237fed@ti.com>
 <01ec2c94-46e0-3534-94e8-bd92f78b70ec@lechnology.com>
Message-ID: <b29c37b2-382c-dbab-966b-4463e3127676@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 January 2017 09:13 PM, David Lechner wrote:
> On 01/09/2017 06:29 AM, Sekhar Nori wrote:
>> On Friday 06 January 2017 10:03 AM, David Lechner wrote:
>>> This enables the iio subsystem and the TI ADS7950 driver. This is
>>> used by
>>> LEGO MINDSTORMS EV3, which has an ADS7957 chip.
>>
>> Can you add your sign-off?
>>
>>> ---
>>>
>>> The CONFIG_TI_ADS7950 driver is currently in iio/testing, so some
>>> coordination
>>> may be needed before picking up this patch.
>>>
>>>  arch/arm/configs/davinci_all_defconfig | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm/configs/davinci_all_defconfig
>>> b/arch/arm/configs/davinci_all_defconfig
>>> index 2b1967a..a899876 100644
>>> --- a/arch/arm/configs/davinci_all_defconfig
>>> +++ b/arch/arm/configs/davinci_all_defconfig
>>> @@ -200,6 +200,13 @@ CONFIG_TI_EDMA=y
>>>  CONFIG_MEMORY=y
>>>  CONFIG_TI_AEMIF=m
>>>  CONFIG_DA8XX_DDRCTL=y
>>> +CONFIG_IIO=m
>>> +CONFIG_IIO_BUFFER_CB=m
>>> +CONFIG_IIO_SW_DEVICE=m
>>> +CONFIG_IIO_SW_TRIGGER=m
>>
>>> +CONFIG_TI_ADS7950=m
>>
>> Can you separate this from rest of the patch. I would like to enable
>> this option only after I can find the symbol in linux-next.
> 
> Will resend without CONFIG_TI_ADS7950
> 
>>
>>> +CONFIG_IIO_HRTIMER_TRIGGER=m
>>> +CONFIG_IIO_SYSFS_TRIGGER=m
>>
>> Need CONFIG_IIO_TRIGGER=y also for these two options to take effect.
> 
> CONFIG_IIO_TRIGGER is selected by IIO_TRIGGERED_BUFFER [=m] && IIO [=m]
> && IIO_BUFFER [=y], so save_defconfig does not pick it up.

I do remember I did not see these two modules did not get enabled in
.config after 'make davinci_all_defconfig'. Will check what I may have
missed.

Thanks,
Sekhar
