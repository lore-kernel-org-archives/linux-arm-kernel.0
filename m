From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 30 Jun 2011 17:11:38 +0200
Subject: [PATCH 3/3] pwm: Add a i.MX23/28 pwm driver
In-Reply-To: <201106301342.36088.arnd@arndb.de>
References: <1309430517-23821-1-git-send-email-s.hauer@pengutronix.de>
	<1309430517-23821-4-git-send-email-s.hauer@pengutronix.de>
	<201106301342.36088.arnd@arndb.de>
Message-ID: <20110630151138.GB9349@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 01:42:35PM +0200, Arnd Bergmann wrote:
> On Thursday 30 June 2011, Sascha Hauer wrote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Hi Sascha,
> 
> The probing looks good to me now. I would have added extra code to avoid
> ioremapping the same page multiple times, but I see this as a matter of
> different preferences, so I'm fine with that.
> 
> You are still missing a description of the driver, both in the changelog
> above and in the Kconfig patch. A small sentence to spell out PWM
> in the changelog and to list the devices that will use this driver
> would be helpful to the causal reader.

Ok, will add.

> 
> Provided that you add that:
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 93c1052..5694574 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -2,11 +2,15 @@ menuconfig PWM
> >  	bool "PWM Support"
> >  	help
> >  	  This enables PWM support through the generic PWM framework.
> > -	  You only need to enable this, if you also want to enable
> > +	  You only need to enable this if you also want to enable
> >  	  one or more of the PWM drivers below.
> >  
> >  	  If unsure, say N.
> >  
> 
> I think this hunk should have been in the other first patch.

Indeed, will fix.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
