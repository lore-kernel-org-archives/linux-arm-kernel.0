From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 16 Nov 2014 22:48:38 +0100
Subject: [PATCH] gpio: mxs: implement get_direction callback
In-Reply-To: <20141116214239.GX27002@pengutronix.de>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de>
 <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de>
Message-ID: <20141116214838.GY27002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

On Sun, Nov 16, 2014 at 10:42:39PM +0100, Uwe Kleine-K?nig wrote:
> Also note that the atmel_get_lines_status function can be simplified to
> just:
> 
> 	status = UART_GET_CSR(port);
> 	return mctrl_gpio_get(atmel_port->gpios, &status);
thinking again, this is wrong because it uses the Atmel specific
register bits for the different flags, but with the generic solution
outlined in the previous mail this function wouldn't need to handle the
gpio parts at all.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
