From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2016 14:52:34 +0200
Subject: [PATCH 2/5] ARM: realview: reduce the RealView Kconfig
In-Reply-To: <1470832830-10274-3-git-send-email-linus.walleij@linaro.org>
References: <1470832830-10274-1-git-send-email-linus.walleij@linaro.org>
 <1470832830-10274-3-git-send-email-linus.walleij@linaro.org>
Message-ID: <3301256.KAUbhPjxbH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 10, 2016 2:40:27 PM CEST Linus Walleij wrote:
> -
> -config REALVIEW_EB_ARM1136
> -       bool "Support ARM1136J(F)-S Tile"
> -       depends on MACH_REALVIEW_EB && ARCH_MULTI_V6
> -       select CPU_V6
> -       help
> -         Enable support for the ARM1136 tile fitted to the
> -         Realview(R) Emulation Baseboard platform.
> -

You seem to lose the "select CPU_V6" here, so we end up building
realview_defconfig for ARMv6K or higher, and that won't work
on ARM1136r0 (it will work on ARM1136r1 and all other v6 based
cores).

I actually liked the idea of having per-CPU options for Realview-EB
here, but if we can find another way to select CPU_V6 when needed,
I won't complain about the removal as it does simplify things
quite a bit.

	Arnd
