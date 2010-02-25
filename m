From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 25 Feb 2010 10:35:55 +0100
Subject: [PATCH] MXC: mach_armadillo5x0: Add USB Host support.
In-Reply-To: <1267090289.2722.4.camel@realization>
References: <1267054032.3870.47.camel@realization>
	<20100225080259.GA13295@pengutronix.de>
	<1267090289.2722.4.camel@realization>
Message-ID: <20100225093555.GA10399@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alberto,

> > I think you need to protect all hunks by
> > #ifdef CONFIG_USB_ULPI
> > 
> > For the pin-setup it's not important, but you must not call
> > otg_ulpi_create if USB_ULPI isn't configured.
> > 
> > Best regards
> > Uwe
> > 
> 
> Ok, I'd seen this protection in pcm037 but I thought that on
> my board USB will be always enabled.
This breaks make randconfig, so either (a) add the #ifdefs or (b) select
USB_ULPI.  IMHO (a) is preferable.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
