From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Oct 2011 13:03:48 +0200
Subject: [PATCH 23/30] ARM: omap2: select twl4030 support on boards that
	need it
In-Reply-To: <4E8945CE.6070800@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-24-git-send-email-arnd@arndb.de>
	<4E8945CE.6070800@ti.com>
Message-ID: <8140311.pfrshFtPLz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 October 2011 10:49:10 Santosh Shilimkar wrote:
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index 57b66d5..4deeade 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -253,6 +253,8 @@ config MACH_OMAP_ZOOM2
> >       select SERIAL_CORE_CONSOLE
> >       select SERIAL_8250_CONSOLE
> >       select REGULATOR_FIXED_VOLTAGE
> > +     select TWL4030_CORE
> > +     select I2C
> >  
> Another option to ensure I2C is selected when
> TWL* drivers are selected is let it depends
> on I2C. That wat we can avoid patching every
> machine entry with I2C option.
> Not a strong opinion though.

I generally try to avoid having select statements where a
depends on works fine, as in the generic TWL4030_CORE config.

For platforms that require TWL4030, this does not work, although
it would be better not to have this strict dependency and make
the configuration build if the driver is disabled, even if that
is rather pointless.

	Arnd
