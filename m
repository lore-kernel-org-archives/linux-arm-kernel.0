From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 16 Apr 2018 20:02:56 +0200
Subject: serial: imx: half-duplex RS485 operation with RTS active low
In-Reply-To: <15ca978834ac705c550d9d3339ae1602@agner.ch>
References: <0e88706a05a302201be396d2f03c3e9e@agner.ch>
 <20180416092257.frbmooduhm4zrhhl@pengutronix.de>
 <c6059022d48191909d030584f981d1a2@agner.ch>
 <94f7fcf8873f7607087fc3a59a9422a8@agner.ch>
 <20180416134249.vdjyye73elv2p5qr@pengutronix.de>
 <15ca978834ac705c550d9d3339ae1602@agner.ch>
Message-ID: <20180416180256.s6r7rrcnpevndmrf@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Stefan,

On Mon, Apr 16, 2018 at 06:12:41PM +0200, Stefan Agner wrote:
> On 16.04.2018 15:42, Uwe Kleine-K?nig wrote:
> > Adding a respective check in the driver would be nice though.
> 
> Hm, yes agreed. Where would that check go? In probe? Then I guess it
> only would warn when using device tree properties...?

look at the code between the calls to uart_get_rs485_mode() and
imx_uart_rs485_config(). Something like that would be needed and
imx_uart_rs485_config must adapt the flags accordingly.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
