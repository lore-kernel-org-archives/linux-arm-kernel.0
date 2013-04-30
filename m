From: tony@atomide.com (Tony Lindgren)
Date: Tue, 30 Apr 2013 16:51:48 -0700
Subject: Latest build results - errors/warnings - lots of them
In-Reply-To: <201305010111.14247.arnd@arndb.de>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
 <201305010111.14247.arnd@arndb.de>
Message-ID: <20130430235147.GG28721@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130430 16:16]:
> 
> I've uploaded this to the test-merge-20130430 branch in the arm-soc
> tree if anyone is curious. I suppose we should get all the changes
> in arch/arm included in the merge window and then work with the
> subsystem maintainers on the other bugs.

>  arch/arm/mach-omap2/Kconfig                   | 133 +++++++++++++-------------
>  arch/arm/mach-omap2/Makefile                  |   8 +-

Nice, I like your changes to flip ARCH_OMAP2PLUS to be selected
by the SoC. That's a better way to fix things than just tinkering
with the Makefile like I posted earlier today.

Now you have SOC_OMAP5 selected twice in omap2plus_defconfig though,
which causes:

.config:283:warning: override: reassigning to symbol SOC_OMAP5

For the SERIAL_OMAP change, let's just use my earlier patch
"ARM: OMAP2+: Fix unmet direct dependencies for SERIAL_OMAP".
We should not select optional drivers at all in Kconfig.

Regards,

Tony
