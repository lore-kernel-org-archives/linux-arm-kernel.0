From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 3 Sep 2015 12:29:46 +0200
Subject: [PATCHv6] ARM: exynos_defconfig: Enable LEDS for Odroid-XU3/XU4
In-Reply-To: <CANAwSgT0u9iC9MSsbGz5L6n7XgB-fLLYhrN7sUPrn9GyN-2bGA@mail.gmail.com>
References: <1441258696-3699-1-git-send-email-linux.amoon@gmail.com>
 <55E810E3.6080709@osg.samsung.com>
 <CANAwSgT0u9iC9MSsbGz5L6n7XgB-fLLYhrN7sUPrn9GyN-2bGA@mail.gmail.com>
Message-ID: <55E8211A.1000806@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Anand,

On 09/03/2015 11:47 AM, Anand Moon wrote:
> Hi Javier,
> 
> On 3 September 2015 at 14:50, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
>> Hello Anand,
>>
>> On 09/03/2015 07:38 AM, Anand Moon wrote:
>>> Enable config option NEW_LEDS, LEDS_CLASS, LEDS_GPIO, LEDS_PWM,
>>> LEDS_TRIGGERS, LEDS_TRIGGER_TIMER, LEDS_TRIGGER_HEARTBEAT for
>>> Odroid-XU3/XU4 board.
>>>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>
>>> ---
>>
>> I think Krzysztof already mentioned but a commit message shouln't
>> describe what the change is (one can look to the patch for that)
>> but why the change is needed.
>>
>> So I would had expect something along these lines:
>>
>> Many Exynos boards (i.e: the Exynos5422 Odroid XU3/XU4) have GPIO
>> and PWM based LEDs, so enable the needed Kconfig options to have
>> support for these. Also, some boards use the heartbeat LED trigger
>> so enable support for this as well.
>>
>>> Changes from last version
>>> dropped following option.
>>>   CONFIG_LEDS_CLASS_FLASH
>>>   CONFIG_TRIGGER_ONESHOT
>>>   CONFIG_TRIGGER_GPIO
>>> fixed the From address
>>> ---
>>>  arch/arm/configs/exynos_defconfig | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
>>> index 9504e77..aaf7aa4 100644
>>> --- a/arch/arm/configs/exynos_defconfig
>>> +++ b/arch/arm/configs/exynos_defconfig
>>> @@ -163,6 +163,13 @@ CONFIG_MMC_SDHCI_S3C_DMA=y
>>>  CONFIG_MMC_DW=y
>>>  CONFIG_MMC_DW_IDMAC=y
>>>  CONFIG_MMC_DW_EXYNOS=y
>>> +CONFIG_NEW_LEDS=y
>>> +CONFIG_LEDS_CLASS=y
>>> +CONFIG_LEDS_GPIO=y
>>> +CONFIG_LEDS_PWM=y
>>> +CONFIG_LEDS_TRIGGERS=y
>>> +CONFIG_LEDS_TRIGGER_TIMER=y
>>
> 
>> I don't see an Exynos board using the timer trigger. Do you need it for
>> some user-space application that uses the sysfs interface? I'm OK with
>> enabling it but again this should be mentioned in the commit message.
>>

You haven't answered this question.

>>> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>>>  CONFIG_RTC_CLASS=y
>>>  CONFIG_RTC_DRV_MAX77686=y
>>>  CONFIG_RTC_DRV_MAX77802=y
>>>
>>
> 
> Earlier design of the LED for Odroid XU3 was using gpio-leds
> Now It was change to using both pwm-leds and gpio-leds.
>

I know that Odroid XU3 have both LEDs connected to GPIO and
PWM lines but that should be mentioned in the commit message.
 
> Earlier I kept them as loadable module and now build-in.
>

Yes, because exynos_defconfig as everything as built-in to
make it easier for developers to test by only copying the
kernel image and not the modules.
 
> Should I resend this again. Or some body will update the commit message.
>

If a patch has a typo, an extra blank line or something
very easy to fix then it may be possible that the maintainer
will do the fix when applying but changing the commit message
I think is too much so in this case is better to resend IMHO.
 
> -Anand Moon
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
