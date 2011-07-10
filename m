From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 10 Jul 2011 10:04:50 +0200
Subject: [PATCH 3/3] mc13xxx: implicitly enable leds and buttons
In-Reply-To: <1310252796-10596-4-git-send-email-philippe.retornaz@epfl.ch>
References: <1310252796-10596-1-git-send-email-philippe.retornaz@epfl.ch>
	<1310252796-10596-2-git-send-email-philippe.retornaz@epfl.ch>
	<1310252796-10596-3-git-send-email-philippe.retornaz@epfl.ch>
	<1310252796-10596-4-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20110710080450.GW29624@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Jul 10, 2011 at 01:06:36AM +0200, Philippe R?tornaz wrote:
> The leds and buttons subdevices cannot be used without additional
> platform data.
> 
> Use the presence of the platform data to enable the device instead
> of an additional flag.
I guess you could make some people happy by splitting this patch into:

	- mfd/mc13xxx: implicitly enable leds and buttons (and
	  regulators?)
	- drop MC13XXX_USE_... in arch code

because the patches have different paths into mainline (unless it's
handled otherwise).

And I wonder why you introduce MC13XXX_USE_BUTTON in the first place.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
