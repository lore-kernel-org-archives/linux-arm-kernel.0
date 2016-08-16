From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 16 Aug 2016 18:41:09 +0900
Subject: Why do we need reset_control_get_optional() ?
In-Reply-To: <1793038.JVifRUCe28@wuerfel>
References: <CAK7LNAQnitMMp5wMXXvVeS-UFF=Fo9m=M1hL=5f4=RF8JYCnGg@mail.gmail.com>
 <3400649.NoVKUzu81R@wuerfel> <1470387358.3141.17.camel@pengutronix.de>
 <1793038.JVifRUCe28@wuerfel>
Message-ID: <CAK7LNARCJ0HoyUj-urFxvn2BJMjs5M1YxxEjUCRPWB9XwvvRdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,



2016-08-06 0:35 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:

>
> config RESET_FOO
>         bool "FOO reset controller" if COMPILE_TEST && !ARCH_FOO
>         default ARCH_FOO
>
> then I think we get both: you won't be able to turn it off
> but also get the build testing.


This looks good to me, too.
I do not know if we need "&& !ARCH_FOO", though.

When we are compile-testing, we do not care if it works on run-time,
so perhaps it makes sense to allow to enable/disable RESET_FOO
regardless ARCH_FOO.


Philipp also agreed, so I guess the permission for this rework
is granted.
Would you do it?



-- 
Best Regards
Masahiro Yamada
