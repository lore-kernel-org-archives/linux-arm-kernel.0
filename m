From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 18 Nov 2014 08:55:45 +0100
Subject: [PATCH v2] gpio: mxs: implement get_direction callback
In-Reply-To: <1416221256-11671-1-git-send-email-j.uzycki@elproma.com.pl>
References: <1416221256-11671-1-git-send-email-j.uzycki@elproma.com.pl>
Message-ID: <20141118075545.GO27002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 17, 2014 at 11:47:36AM +0100, Janusz Uzycki wrote:
> gpiolib's gpiod_get_direction() function returns the EINVAL error
> if .get_direction callback is not defined.
> The patch implements the callback for mxs chip what is useful
s/what/which/

> for debugging.
> 
> Commit f9e42397d79b
> ("serial: mxs-auart: add interrupts for modem control lines")
> as based on commit ab5e4e4108ca
> ("tty/serial: at91: add interrupts for modem control lines")
> uses the gpiod_get_direction() function.
This paragraph is obsolete now that we agreed that .get_direction has
nothing to do with mctrl_gpio, right?
> 
> Inspired from arch/arm/mach-at91/gpio.c
s/from/by/ I think

Other than that:
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
