From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Jan 2011 16:26:30 +0100
Subject: [PATCH 2/2] ARM i.MXS: Add auart platform support for i.MX28
In-Reply-To: <20110111151725.GT24920@pengutronix.de>
References: <1294758545-9445-1-git-send-email-s.hauer@pengutronix.de>
	<1294758545-9445-3-git-send-email-s.hauer@pengutronix.de>
	<20110111151725.GT24920@pengutronix.de>
Message-ID: <20110111152630.GU12078@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 04:17:25PM +0100, Uwe Kleine-K?nig wrote:
> >  
> > +extern const struct mxs_auart_data mx28_auart_data[] __initconst;
> > +#define mx28_add_auart(id)	mxs_add_auart(&mx28_auart_data[id])
> > +#define mx28_add_auart0()		mx28_add_auart(0)
> > +#define mx28_add_auart1()		mx28_add_auart(1)
> > +#define mx28_add_auart2()		mx28_add_auart(2)
> > +#define mx28_add_auart3()		mx28_add_auart(3)
> > +#define mx28_add_auart4()		mx28_add_auart(4)
> I wouldn't add the mx28_add_auartX macros, only mx28_add_auart.  The
> former are a relict of the time when we didn't use an array to get the
> data from.

With pleasure.

> 
> > +
> >  extern const struct mxs_fec_data mx28_fec_data[] __initconst;
> >  #define mx28_add_fec(id, pdata) \
> >  	mxs_add_fec(&mx28_fec_data[id], pdata)
> > diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
> > index a35a2dc..9d16540 100644
> > --- a/arch/arm/mach-mxs/devices/Kconfig
> > +++ b/arch/arm/mach-mxs/devices/Kconfig
> > @@ -1,5 +1,8 @@
> >  config MXS_HAVE_PLATFORM_DUART
> >  	bool
> >  
> > +config MXS_HAVE_PLATFORM_AUART
> > +	bool
> > +
> This doesn't happen to be an amba device, too?

no

> 
> >  config MXS_HAVE_PLATFORM_FEC
> >  	bool
> > diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
> > index 4b5266a..b46d18d 100644
> > --- a/arch/arm/mach-mxs/devices/Makefile
> > +++ b/arch/arm/mach-mxs/devices/Makefile
> > @@ -1,2 +1,3 @@
> >  obj-$(CONFIG_MXS_HAVE_PLATFORM_DUART) += platform-duart.o
> > +obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
> >  obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
> this conflicts with the "make duart use amba-pl011 driver" patch.

Nah, let the maintainer deal with it...

> Also can you please keep the file sorted alphabetically?

ok

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
