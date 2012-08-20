From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 20 Aug 2012 19:16:55 +0200
Subject: [PATCH 02/11] pinctrl: mvebu: dove pinctrl driver
In-Reply-To: <CACRpkda9BL5+NiDOsMKG0kv2coBsw=Er=ZccXnNkgeftV9hPhQ@mail.gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1344689809-6223-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkda9BL5+NiDOsMKG0kv2coBsw=Er=ZccXnNkgeftV9hPhQ@mail.gmail.com>
Message-ID: <20120820191655.5e2f2dba@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Mon, 20 Aug 2012 15:43:11 +0200,
Linus Walleij <linus.walleij@linaro.org> a ?crit :

> >  config PINCTRL_MVEBU
> >         bool "Marvell SoC pin controller drivers"
> > -       depends on ARCH_MVEBU
> > +       depends on ARCH_MVEBU || ARCH_DOVE
> 
> Hmmmm.
> 
> Shouldn't this thing rather be:
> 
> depends on PLAT_ORION
> 
> else you end up lining up all Marvell machines here...

When we started working on this, ARCH_MVEBU was not a PLAT_ORION
platform, because PLAT_ORION includes its own custom pinmux code, gpio
code, etc, and what we're trying to achieve with Sebastian is to clean
all this. Ultimately, our goal is to have all Orion, Kirkwood, Dove,
Discovery and Armada 370/XP supported in mach-mvebu, and therefore
plat-orion would most likely disappear.

In the mean time, a patch got accepted that separates PLAT_ORION for
PLAT_ORION_LEGACY, and therefore MACH_MVEBU now selects PLAT_ORION to
access things that are still useful (address decoding code) while all
other platforms select PLAT_ORION_LEGACY to get the old pinmux code,
old gpio code, etc. All this is very much a work in progress.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
