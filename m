From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Nov 2010 15:18:30 +0100
Subject: [PATCH 09/10] MCDE: Add build files and bus
In-Reply-To: <201011261224.59490.arnd@arndb.de>
References: <F45880696056844FA6A73F415B568C6953604E802E@EXDCVYMBSTM006.EQ1STM.local>
	<201011251747.48365.arnd@arndb.de>
	<C832F8F5D375BD43BFA11E82E0FE9FE0082586F430@EXDCVYMBSTM005.EQ1STM.local>
	<201011261224.59490.arnd@arndb.de>
Message-ID: <AANLkTinCYdb8p4-H+Aki-z+i7ZL2ETwGJdDxOQ4XpBJ+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/26 Arnd Bergmann <arnd@arndb.de>:

> * When you say that the devices are static, I hope you do not mean
> ?static in the C language sense. We used to allow devices to be
> ?declared as "static struct" and registered using
> ?platform_device_register (or other bus specific functions). This
> ?is no longer valid and we are removing the existing users, do not
> ?add new ones. When creating a platform device, use
> ?platform_device_register_simple or platform_device_register_resndata.

Is this part of the generic ARM runtime multi-platform kernel
and device trees shebang?

The Ux500 still isn't in that sector, it needs extensive rewriting
of arch/arm/mach-ux500 to be done first, so as to support e.g.
U8500 and U5500 with a single kernel image.

Trying to skin that cat that as part of this review is a bit too
much to ask IMO, I'd rather have the author of this driver
adapt to whatever platform data registration mechanism is
in place for the merge window. Else it needs fixing as part
of a bigger endavour to root out compile-time platform
configuration.

Yours
Linus Walleij
