From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 20 Feb 2010 17:12:48 +0100
Subject: [PATCH 01/13] ARM: LPC32XX: Initial architecture header files
In-Reply-To: <1266621969-28847-2-git-send-email-wellsk40@gmail.com>
References: <1266621969-28847-1-git-send-email-wellsk40@gmail.com>
	<1266621969-28847-2-git-send-email-wellsk40@gmail.com>
Message-ID: <20100220161248.GA31424@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Kevin,

> +/*
> + * Note!
> + * Muxed GP pins need to be setup to the GP state in the board level
> + * code prior to using this driver.
This is done by the imx machines, too, and I wonder if it's worth to try
to get rid of that or at least let the gpio_direction_... functions fail
if the pin isn't muxed as gpio.  Thoughts?

I didn't check the alternative functionalities for the gpios on lpc32xx,
but what happens if any gpio is requested and the direction configured?
Does it interfer with system functions?  (E.g. if a pin is used in a
dedicated say i2c function, does it make the i2c driver non-functional
if I do gpio_direction_output(i2cpin, 1)?)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
