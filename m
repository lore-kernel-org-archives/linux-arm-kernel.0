From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 8 Jul 2011 17:25:29 +0200
Subject: [PATCH 1/2] mc13783: add power button support
In-Reply-To: <201107081645.00724.philippe.retornaz@epfl.ch>
References: <1310135037-24289-1-git-send-email-philippe.retornaz@epfl.ch>
	<1310135037-24289-2-git-send-email-philippe.retornaz@epfl.ch>
	<20110708143032.GT29624@pengutronix.de>
	<201107081645.00724.philippe.retornaz@epfl.ch>
Message-ID: <20110708152529.GV29624@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Philippe,

On Fri, Jul 08, 2011 at 04:45:00PM +0200, Philippe R?tornaz wrote:
> > > +config INPUT_MC13783_ON
> > > +	tristate "MC13783 ON buttons"
> > > +	depends on MFD_MC13783
> > > +	help
> > > +	  Support the ON buttons of MC13783 PMIC as an input device
> > > +	  reporting power button status.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module
> > > +	  will be called mc13783-pwrbutton.
> > 
> > Why not use INPUT_MC13783_PWRBUTTON to match the source file (and so
> > module) name.
> 
> Ok.
> 
> > 
> > > +
> > > +
> > 
> > one empty line should be enough
> 
> Ok.
> 
> > > diff --git a/drivers/input/misc/mc13783-pwrbutton.c
> > > b/drivers/input/misc/mc13783-pwrbutton.c new file mode 100644
> > > index 0000000..6aee01c
> > > --- /dev/null
> > > +++ b/drivers/input/misc/mc13783-pwrbutton.c
> > > @@ -0,0 +1,288 @@
> > > +/**
> > > + * mc13783-pwrbutton.c - MC13783 Power Button Input Driver
> > > + *
> > > + * Copyright (C) 2011 Philippe R?tornaz
> > > + *
> > > + * Based on twl4030-pwrbutton driver by:
> > > + *     Peter De Schrijver <peter.de-schrijver@nokia.com>
> > > + *     Felipe Balbi <felipe.balbi@nokia.com>
> > > + *
> > > + * This file is subject to the terms and conditions of the GNU General
> > > + * Public License. See the file "COPYING" in the main directory of this
> > > + * archive for more details.
> > 
> > This implies GPL v2 only? So you either need to clearify here or you
> > need to adapt the MODULE_LICENSE line below to read
> > 
> > 	MODULE_LICENSE("GPL v2");
> 
> Well, I took exactly the same license than the twl4030-pwrbutton. 
> This driver is: MODULE_LICENSE("GPL"), why should I change it ?
So this driver is wrong, too. According to include/linux/module.h, "GPL"
means "GNU Public License v2 or later" and "GPL v2" means "GNU Public
License v2".

> > > --- a/drivers/mfd/mc13xxx-core.c
> > > +++ b/drivers/mfd/mc13xxx-core.c
> > > 
> > > @@ -778,6 +778,10 @@ err_revision:
> > >  		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
> > >  		
> > >  				pdata->leds, sizeof(*pdata->leds));
> > > 
> > > +	if (pdata->flags & MC13XXX_USE_BUTTON)
> > 
> > Why not use
> > 
> > 	if (pdata->buttons)
> > 
> > to detect if the pwrbutton device should be registered?
> 
> To keep consistancy as the others sub-device are registered the same way 
> (regulator, led). I can do it as you propose for the button but IMHO it's a 
> bit strange to have a MC13XXX_USE_* for all the subdevice except the buttons. 
> So should I change ?
It would be a third patch for your commit count to convert regulator and
led, too ;-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
