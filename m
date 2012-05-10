From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 May 2012 13:25:48 +0200
Subject: [PATCH 04/15] ARM: ux500: CONFIG: Compile in support for leds-gpio
In-Reply-To: <4FAA45B5.2030000@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-5-git-send-email-lee.jones@linaro.org>
 <CACRpkdbv780oUaDL1-m4kj5iRr5=1U6QhE975Z4gNADoTNk8YA@mail.gmail.com>
 <4FAA45B5.2030000@linaro.org>
Message-ID: <CACRpkdaqh7ewHezwTHJ2NRwhVduPi2Ur6N_i8R+_Ynk7HS6pwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 12:23 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On 09/05/12 09:49, Linus Walleij wrote:
>> On Fri, May 4, 2012 at 8:23 PM, Lee Jones<lee.jones@linaro.org> ?wrote:
>>
>>> Code exists in the mop500 board file (used for HREF and
>>> Snowball) to initialise Snowball's user LED via the
>>> leds-gpio driver. However, the driver isn't currently
>>> built when using the default configuration file. This
>>> patch aims to change that behavior.
>>>
>>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>>
>> (...)
>>>
>>> +CONFIG_LEDS_GPIO=y
>>> ?CONFIG_RTC_CLASS=y
>>> ?CONFIG_RTC_DRV_AB8500=y
>>> ?CONFIG_RTC_DRV_PL031=y
>>
>>
>> Why not just edit arch/arm/mach-ux500/Kconfig like this:
>>
>> config MACH_SNOWBALL
>> ? ? ? ? bool "U8500 Snowball platform"
>> ? ? ? ? select MACH_MOP500
>> + ? ? ? ?select LEDS_GPIO
>
>
> I can do that. Is it not useful for any of the other platforms?

Thanks and oo, the others have dedicated LED controllers and does not use
GPIO for this.

Yours,
Linus Walleij
