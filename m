From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 10 Jul 2011 16:15:00 +0200
Subject: [PATCH 3/3] mc13xxx: implicitly enable leds and buttons
In-Reply-To: <201107101333.10309.philippe.retornaz@epfl.ch>
References: <1310252796-10596-1-git-send-email-philippe.retornaz@epfl.ch>
	<1310252796-10596-4-git-send-email-philippe.retornaz@epfl.ch>
	<20110710080450.GW29624@pengutronix.de>
	<201107101333.10309.philippe.retornaz@epfl.ch>
Message-ID: <20110710141500.GX29624@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Philippe,

On Sun, Jul 10, 2011 at 01:33:09PM +0200, Philippe R?tornaz wrote:
> Le dimanche 10 juillet 2011 10:04:50, Uwe Kleine-K?nig a ?crit :
> > Hello,
> > 
> > On Sun, Jul 10, 2011 at 01:06:36AM +0200, Philippe R?tornaz wrote:
> > > The leds and buttons subdevices cannot be used without additional
> > > platform data.
> > > 
> > > Use the presence of the platform data to enable the device instead
> > > of an additional flag.
> > 
> > I guess you could make some people happy by splitting this patch into:
> > 
> > 	- mfd/mc13xxx: implicitly enable leds and buttons (and
> > 	  regulators?)
> > 	- drop MC13XXX_USE_... in arch code
> 
> But this mean that between the two commit the build will be broken or the 
> behavior will change.  Which will break bissections.
If you don't remove the MC13XXX_USE_... constants the unconverted boards
should still compile.
> 
> For the regulator stuff, I don't want to change the behavior of others
> board as some (mx31lite) enable the regualtor without platform data.
> That's why I did not changed it. 
If having pdata=NULL is a valid config then either we need to keep the
constant for regulators or (as Mark suggested) register unconditionally.

> Moreover for the mc13892 chip (which share the same flag), the probe() does 
> modify some registers, so it's not just some cosmetic change, it will change 
> the behavior on some boards.
no fear, that's what the -rc phase is there for. When improving
something you often have to change behaviour.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
