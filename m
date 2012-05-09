From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 09 May 2012 11:23:49 +0100
Subject: [PATCH 04/15] ARM: ux500: CONFIG: Compile in support for leds-gpio
In-Reply-To: <CACRpkdbv780oUaDL1-m4kj5iRr5=1U6QhE975Z4gNADoTNk8YA@mail.gmail.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-5-git-send-email-lee.jones@linaro.org>
 <CACRpkdbv780oUaDL1-m4kj5iRr5=1U6QhE975Z4gNADoTNk8YA@mail.gmail.com>
Message-ID: <4FAA45B5.2030000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/12 09:49, Linus Walleij wrote:
> On Fri, May 4, 2012 at 8:23 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> Code exists in the mop500 board file (used for HREF and
>> Snowball) to initialise Snowball's user LED via the
>> leds-gpio driver. However, the driver isn't currently
>> built when using the default configuration file. This
>> patch aims to change that behavior.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
> (...)
>> +CONFIG_LEDS_GPIO=y
>>   CONFIG_RTC_CLASS=y
>>   CONFIG_RTC_DRV_AB8500=y
>>   CONFIG_RTC_DRV_PL031=y
>
> Why not just edit arch/arm/mach-ux500/Kconfig like this:
>
> config MACH_SNOWBALL
>          bool "U8500 Snowball platform"
>          select MACH_MOP500
> +        select LEDS_GPIO

I can do that. Is it not useful for any of the other platforms?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
