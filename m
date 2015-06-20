From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Jun 2015 20:08:39 +0200
Subject: [RFC PATCH] ARM: dts: Convert Linkstation Mini to Device Tree
In-Reply-To: <20150620173421.GJ2936@io.lakedaemon.net>
References: <1434765234.5177.25.camel@dolka.fr>
 <20150620173421.GJ2936@io.lakedaemon.net>
Message-ID: <20150620180839.GB9863@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  arch/arm/boot/dts/Makefile           |   3 +-
> >  arch/arm/boot/dts/orion5x-lswsgl.dts | 241 ++++++++++++++++++++++++++++++
> >  arch/arm/mach-orion5x/Kconfig        |   6 +-
> >  arch/arm/mach-orion5x/lsmini-setup.c | 280 -----------------------------------
> >  4 files changed, 246 insertions(+), 284 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/orion5x-lswsgl.dts
> >  delete mode 100644 arch/arm/mach-orion5x/lsmini-setup.c
> 
> Ahhh, that's always refreshing to see...

And i missed it all together. More discussion below.

> 
> > diff --git a/arch/arm/boot/dts/orion5x-lswsgl.dts b/arch/arm/boot/dts/orion5x-lswsgl.dts
> > new file mode 100644
> > index 0000000..c7537a6
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/orion5x-lswsgl.dts
> > @@ -0,0 +1,241 @@
> > +/*
> > + * Copyright (C) 2015 Benjamin Cama <benoar@dolka.fr>
> > + * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > + * Copyright (C) 2008 Alexey Kopytko <alexey@kopytko.ru>
> 
> It may be preferable to say "Based on the board file
> arch/arm/mach-orion5x/lsmini-setup.c, Copyright (C) 2008 Alexey Kopytko
> <alexey@kopytko.ru>"  But that's very nit-picky.  As long as Alexey is
> recognized, it should be fine.
> 
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2. This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> 
> We're trying to move the dts{i} files to dual license.  Please take a
> look at the current armada-*.dts{i} license blocks.  If you are ok with
> it, please change the above to match.

For orion5x we have a chance to make this happen, since most of
orion5x.dtsi comes from the usual suspects.

So, yes, this makes sense.
 
> > diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
> > index 2412efb..08d2be2 100644
> > --- a/arch/arm/mach-orion5x/Kconfig
> > +++ b/arch/arm/mach-orion5x/Kconfig
> > @@ -78,11 +78,11 @@ config MACH_LINKSTATION_LSCHL
> >  	  Buffalo Linkstation Live v3 (LS-CHL) platform.
> >  
> >  config MACH_LINKSTATION_MINI
> > -	bool "Buffalo Linkstation Mini"
> > -	select I2C_BOARDINFO
> > +	bool "Buffalo Linkstation Mini (Flattened Device Tree)"
> > +	select ARCH_ORION5X_DT
> >  	help
> >  	  Say 'Y' here if you want your kernel to support the
> > -	  Buffalo Linkstation Mini platform.
> > +	  Buffalo Linkstation Mini (LS-WSGL) platform.
> 
> Hmmm, this question is for the other mvebu maintainers:  When we
> originally converted kirkwood and dove, we put a lot of effort into
> keeping the board files and the dts files around in parallel for a
> while.  Do we need to do that here?  All the drivers are converted, so
> we don't need to keep the legacy board files for that reason.

We get so little interest in orion5x, and it has been shown to be
broken for quite a while with respect to IRQ0, that if a real user
comes by and swaps his platform to DT only, i say we go with it.

      Andrew
