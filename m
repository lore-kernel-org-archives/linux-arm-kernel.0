From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 5 Jan 2016 08:24:12 +0900
Subject: [PATCH] drivers/bus: make uniphier-system-bus.c explicitly
 non-modular
In-Reply-To: <CAK7LNASK5GCQ-Jk7ApmSinnW2PAaSmD-k2X9BbGg66-_b5kASg@mail.gmail.com>
References: <1451935379-14107-1-git-send-email-paul.gortmaker@windriver.com>
 <CAK7LNASK5GCQ-Jk7ApmSinnW2PAaSmD-k2X9BbGg66-_b5kASg@mail.gmail.com>
Message-ID: <CAK7LNASDdpt0zVHUe=EMdKCH6N25CwBLtR0A4jXP=P8zAaaqRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Sorry my misunderstanding.


2016-01-05 8:15 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Paul, Olof,
>
> 2016-01-05 4:22 GMT+09:00 Paul Gortmaker <paul.gortmaker@windriver.com>:
>> The Kconfig currently controlling compilation of this code is:
>>
>> drivers/bus/Kconfig:config UNIPHIER_SYSTEM_BUS
>> drivers/bus/Kconfig:    bool "UniPhier System Bus driver"
>>
>> ...meaning that it currently is not being built as a module by anyone.
>>
>> Lets remove the modular code that is essentially orphaned, so that
>> when reading the driver there is no doubt it is builtin-only.
>>
>> Since module_platform_driver() uses the same init level priority as
>> builtin_platform_driver() the init ordering remains unchanged with
>> this commit.
>>
>> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>>
>> We also delete the MODULE_LICENSE tag etc. since all that information
>> is already contained at the top of the file in the comments.
>>
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>
>
> This driver can be modular.
>
> I wrote "tristate" in my original patch.
>
> See this one:
> https://patchwork.kernel.org/patch/7805091/
>
>
>
> But when I look at linux-next, it is "bool".
>
>
>
> Now, I realized what happened.
>
> Olof Johansson only said "Thanks, applied to next/drivers."
> But, he silently modified my patch,
> changing "tristate" into "bool".
>
>
> Olof,
>
> Why did you do that?
>
>
> I want this driver tristate.


My bad - Olof had applied it as it is.

It was changed from "tristate" to "bool" by

commit 326ea45aa827da6686c78b5907f9839f91ef5782
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Mon Dec 28 11:05:18 2015 +0100

    bus: uniphier: allow only built-in driver



I did not notice this.





-- 
Best Regards
Masahiro Yamada
