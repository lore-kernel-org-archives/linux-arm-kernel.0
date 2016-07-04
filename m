From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 Jul 2016 17:50:09 +0200
Subject: [PATCH] serial: imx: add rx and tx led trigger
In-Reply-To: <13559901.NSWqUx1Nl6@wuerfel>
References: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <13559901.NSWqUx1Nl6@wuerfel>
Message-ID: <20160704155009.GJ16643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 05:43:03PM +0200, Arnd Bergmann wrote:
> On Monday, July 4, 2016 5:34:12 PM CEST Uwe Kleine-K?nig wrote:
> > Add support for two led triggers per UART instance that blink on
> > transmission and reception of data respectively.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/tty/serial/imx.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> 
> What is specific to this driver here? Could this be done in the
> core tty code instead?

The core doesn't notice when the driver starts to push out characters.

I also have a patch in my queue that adds support for rts delaying in
rs485 mode. While the delay between start_tx being called and the first
char leaving the hardware might not be big enough to care in rs232 mode,
with a big delay_rts_before_send it might matter.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
