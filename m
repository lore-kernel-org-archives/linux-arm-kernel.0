From: mgr@pengutronix.de (Michael Grzeschik)
Date: Tue, 24 Aug 2010 10:54:08 +0200
Subject: [PATCH] MX3x: clean kpp resource structure definitions
In-Reply-To: <20100824083944.GD1536@pengutronix.de>
References: <1282636659-2868-1-git-send-email-m.grzeschik@pengutronix.de>
	<20100824083944.GD1536@pengutronix.de>
Message-ID: <20100824085408.GB3571@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Uwe,

On Tue, Aug 24, 2010 at 10:39:44AM +0200, Uwe Kleine-K?nig wrote:
> Hallo Michael,
> 
> On Tue, Aug 24, 2010 at 09:57:39AM +0200, Michael Grzeschik wrote:
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> >  arch/arm/mach-mx3/devices.c |   10 +++++-----
> >  1 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
> > index a4fd1a2..a3e0fe2 100644
> > --- a/arch/arm/mach-mx3/devices.c
> > +++ b/arch/arm/mach-mx3/devices.c
> > @@ -374,12 +374,12 @@ struct platform_device imx_rtc_device0 = {
> >  
> >  static struct resource imx_kpp_resources[] = {
> >  	{
> > -		.start	= MX3x_KPP_BASE_ADDR,
> > -		.end	= MX3x_KPP_BASE_ADDR + 0xf,
> > -		.flags	= IORESOURCE_MEM
> > +		.start	= KPP_BASE_ADDR,
> > +		.end	= KPP_BASE_ADDR + SZ_4K - 1,
> > +		.flags	= IORESOURCE_MEM,
> >  	}, {
> > -		.start	= MX3x_INT_KPP,
> > -		.end	= MX3x_INT_KPP,
> > +		.start	= MXC_INT_KPP,
> > +		.end	= MXC_INT_KPP,
> >  		.flags	= IORESOURCE_IRQ,
> >  	},
> >  };
> what ist the exact problem you want to fix?
> I'm OK with adding that
> comma and using SZ_4K (assuming you checked it in the reference
> manuals).
Yes i looked for it in the reference manuals. So it should be ok.

> But why s/MX3x_KPP_BASE_ADDR/KPP_BASE_ADDR/ ?
I didn't see that in mx3x.h these Symbols are defined as deprecated.
So you are right and we better stay with the MX3x_* Prefix.

I think you could take the SZ_4K into one of your patches when you are going
to touch the devices.c again. Or do you prefer a oneline patch?

Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
