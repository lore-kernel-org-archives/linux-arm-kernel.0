From: philippe.retornaz@epfl.ch (Philippe =?iso-8859-1?q?R=E9tornaz?=)
Date: Sun, 10 Jul 2011 13:33:09 +0200
Subject: [PATCH 3/3] mc13xxx: implicitly enable leds and buttons
In-Reply-To: <20110710080450.GW29624@pengutronix.de>
References: <1310252796-10596-1-git-send-email-philippe.retornaz@epfl.ch>
	<1310252796-10596-4-git-send-email-philippe.retornaz@epfl.ch>
	<20110710080450.GW29624@pengutronix.de>
Message-ID: <201107101333.10309.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le dimanche 10 juillet 2011 10:04:50, Uwe Kleine-K?nig a ?crit :
> Hello,
> 
> On Sun, Jul 10, 2011 at 01:06:36AM +0200, Philippe R?tornaz wrote:
> > The leds and buttons subdevices cannot be used without additional
> > platform data.
> > 
> > Use the presence of the platform data to enable the device instead
> > of an additional flag.
> 
> I guess you could make some people happy by splitting this patch into:
> 
> 	- mfd/mc13xxx: implicitly enable leds and buttons (and
> 	  regulators?)
> 	- drop MC13XXX_USE_... in arch code

But this mean that between the two commit the build will be broken or the 
behavior will change.  Which will break bissections.

For the regulator stuff, I don't want to change the behavior of others board as 
some (mx31lite) enable the regualtor without platform data. That's why I did 
not changed it. 
Moreover for the mc13892 chip (which share the same flag), the probe() does 
modify some registers, so it's not just some cosmetic change, it will change 
the behavior on some boards.

BTW I will be on holydays next week so I won't be able to produce new patches 
soon.

Thanks,

Philippe
