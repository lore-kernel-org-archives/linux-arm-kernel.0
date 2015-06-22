From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 22 Jun 2015 12:12:59 +0000
Subject: [RFC PATCH] ARM: dts: Convert Linkstation Mini to Device Tree
In-Reply-To: <20150620180839.GB9863@lunn.ch>
References: <1434765234.5177.25.camel@dolka.fr>
 <20150620173421.GJ2936@io.lakedaemon.net>
 <20150620180839.GB9863@lunn.ch>
Message-ID: <20150622121259.GM2936@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 20, 2015 at 08:08:39PM +0200, Andrew Lunn wrote:
...
> > > diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
> > > index 2412efb..08d2be2 100644
> > > --- a/arch/arm/mach-orion5x/Kconfig
> > > +++ b/arch/arm/mach-orion5x/Kconfig
> > > @@ -78,11 +78,11 @@ config MACH_LINKSTATION_LSCHL
> > >  	  Buffalo Linkstation Live v3 (LS-CHL) platform.
> > >  
> > >  config MACH_LINKSTATION_MINI
> > > -	bool "Buffalo Linkstation Mini"
> > > -	select I2C_BOARDINFO
> > > +	bool "Buffalo Linkstation Mini (Flattened Device Tree)"
> > > +	select ARCH_ORION5X_DT
> > >  	help
> > >  	  Say 'Y' here if you want your kernel to support the
> > > -	  Buffalo Linkstation Mini platform.
> > > +	  Buffalo Linkstation Mini (LS-WSGL) platform.
> > 
> > Hmmm, this question is for the other mvebu maintainers:  When we
> > originally converted kirkwood and dove, we put a lot of effort into
> > keeping the board files and the dts files around in parallel for a
> > while.  Do we need to do that here?  All the drivers are converted, so
> > we don't need to keep the legacy board files for that reason.
> 
> We get so little interest in orion5x, and it has been shown to be
> broken for quite a while with respect to IRQ0, that if a real user
> comes by and swaps his platform to DT only, i say we go with it.

Ack.

thx,

Jason.
