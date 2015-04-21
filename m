From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Apr 2015 13:38:12 -0700
Subject: [PATCH 7/9] ARM: Add Kconfig support for bcm2836.
In-Reply-To: <13864545.foFMzEn7Xk@wuerfel>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <1429639796-2169-8-git-send-email-eric@anholt.net>
 <13864545.foFMzEn7Xk@wuerfel>
Message-ID: <87lhhl9pzf.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Tuesday 21 April 2015 11:09:54 Eric Anholt wrote:
>> @@ -116,17 +122,19 @@ config ARCH_BCM283X
>>  config ARCH_BCM2835
>>         bool "Broadcom BCM2835 family" if ARCH_MULTI_V6
>>         select ARCH_BCM283X
>> -       select ARCH_REQUIRE_GPIOLIB
>> -       select ARM_AMBA
>>         select ARM_ERRATA_411920
>>         select ARM_TIMER_SP804
>> -       select CLKSRC_OF
>> -       select PINCTRL
>> -       select PINCTRL_BCM2835
>>         help
>>           This enables support for the Broadcom BCM2835 SoC. This SoC is
>>           used in the Raspberry Pi and Roku 2 devices.
>>  
>> +config ARCH_BCM2836
>> +       bool "Broadcom BCM2836 family" if ARCH_MULTI_V7
>> +       select ARCH_BCM283X
>> +       help
>> +         This enables support for the Broadcom BCM2836 SoC. This SoC is
>> +         used in the Raspberry Pi 2
>> +
>
> The description for the first one says "Broadcom BCM2835 family", and I
> guess they are both in the same family. How about leaving the
> CONFIG_BCM2835 symbol to mean one of them, and just duplicating the
> DEBUG_LL symbols?
>
> You could do something like
>
> config ARCH_BCM2835
>         bool "Broadcom BCM2835 family" if ARCH_MULTI_V6 || ARCH_MULTI_V7
>         select ARCH_BCM283X
>         select ARCH_REQUIRE_GPIOLIB
>         select ARM_AMBA
>         select ARM_ERRATA_411920 if ARCH_MULTI_V6
>         select ARM_TIMER_SP804 if ARCH_MULTI_V6
>         select CLKSRC_OF
>         select PINCTRL
>         select PINCTRL_BCM2835
>         help
>           This enables support for the Broadcom BCM2835 and BCM2836 SoCs.
> 	  These SoCs is used in the Raspberry Pi and Roku 2 devices.
>
> That should make it less confusing to the user, because they don't have
> to know which specific SoC they are building for, other than enabling
> the right architecture level.

Seems reasonable to me.  What do the 2835 maintainers think?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150421/aaf0eb6e/attachment.sig>
