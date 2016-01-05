From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 5 Jan 2016 11:31:00 +0900
Subject: [PATCH] drivers/bus: make uniphier-system-bus.c explicitly
 non-modular
In-Reply-To: <CAK7LNASU3OMhhPTQvEUKEX_5RNiCeaF-QUBgvuSVpEvd4awWww@mail.gmail.com>
References: <1451935379-14107-1-git-send-email-paul.gortmaker@windriver.com>
 <CAK7LNASK5GCQ-Jk7ApmSinnW2PAaSmD-k2X9BbGg66-_b5kASg@mail.gmail.com>
 <CAK7LNASDdpt0zVHUe=EMdKCH6N25CwBLtR0A4jXP=P8zAaaqRA@mail.gmail.com>
 <CAK7LNASU3OMhhPTQvEUKEX_5RNiCeaF-QUBgvuSVpEvd4awWww@mail.gmail.com>
Message-ID: <CAK7LNARdg5UCU99mL6Jhz_rHgyOkQ=pugdSMz_BmFRxH-eYSsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-01-05 11:26 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Paul,
>
>
> 2016-01-05 8:24 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> Hi Olof,
>>
>> Sorry my misunderstanding.
>>
>>
>> 2016-01-05 8:15 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>>> Hi Paul, Olof,
>>>
>>> 2016-01-05 4:22 GMT+09:00 Paul Gortmaker <paul.gortmaker@windriver.com>:
>>>> The Kconfig currently controlling compilation of this code is:
>>>>
>>>> drivers/bus/Kconfig:config UNIPHIER_SYSTEM_BUS
>>>> drivers/bus/Kconfig:    bool "UniPhier System Bus driver"
>>>>
>>>> ...meaning that it currently is not being built as a module by anyone.
>>>>
>>>> Lets remove the modular code that is essentially orphaned, so that
>>>> when reading the driver there is no doubt it is builtin-only.
>>>>
>>>> Since module_platform_driver() uses the same init level priority as
>>>> builtin_platform_driver() the init ordering remains unchanged with
>>>> this commit.
>>>>
>>>> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>>>>
>>>> We also delete the MODULE_LICENSE tag etc. since all that information
>>>> is already contained at the top of the file in the comments.
>>>>
>>>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> Cc: Rob Herring <robh@kernel.org>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>> Cc: Olof Johansson <olof@lixom.net>
>>>> Cc: linux-arm-kernel at lists.infradead.org
>>>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>
>
>
> I assume commit 326ea45aa827 ("bus: uniphier: allow only built-in driver")
> is a temporary fix.
>
> I'd like to revive the tristate for this driver
> by hook or by crook.
>
>
> I've sent the following to fix the build error.
> http://www.thefreedictionary.com/

Sorry, I mean this one:
https://patchwork.kernel.org/patch/7952361/



-- 
Best Regards
Masahiro Yamada
