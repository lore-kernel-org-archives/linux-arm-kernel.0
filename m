From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 5 Jan 2016 08:15:52 +0900
Subject: [PATCH] drivers/bus: make uniphier-system-bus.c explicitly
 non-modular
In-Reply-To: <1451935379-14107-1-git-send-email-paul.gortmaker@windriver.com>
References: <1451935379-14107-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <CAK7LNASK5GCQ-Jk7ApmSinnW2PAaSmD-k2X9BbGg66-_b5kASg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul, Olof,

2016-01-05 4:22 GMT+09:00 Paul Gortmaker <paul.gortmaker@windriver.com>:
> The Kconfig currently controlling compilation of this code is:
>
> drivers/bus/Kconfig:config UNIPHIER_SYSTEM_BUS
> drivers/bus/Kconfig:    bool "UniPhier System Bus driver"
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
>
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>


This driver can be modular.

I wrote "tristate" in my original patch.

See this one:
https://patchwork.kernel.org/patch/7805091/



But when I look at linux-next, it is "bool".



Now, I realized what happened.

Olof Johansson only said "Thanks, applied to next/drivers."
But, he silently modified my patch,
changing "tristate" into "bool".


Olof,

Why did you do that?


I want this driver tristate.



-- 
Best Regards
Masahiro Yamada
