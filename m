From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 Jul 2016 19:30:57 +0200
Subject: [PATCH] serial: imx: add rx and tx led trigger
In-Reply-To: <5565521.Lr5FKj2vNK@wuerfel>
References: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <13559901.NSWqUx1Nl6@wuerfel>
 <20160704155009.GJ16643@pengutronix.de>
 <5565521.Lr5FKj2vNK@wuerfel>
Message-ID: <20160706173057.GS16643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 05:22:40PM +0200, Arnd Bergmann wrote:
> On Monday, July 4, 2016 5:50:09 PM CEST Uwe Kleine-K?nig wrote:
> > On Mon, Jul 04, 2016 at 05:43:03PM +0200, Arnd Bergmann wrote:
> > > On Monday, July 4, 2016 5:34:12 PM CEST Uwe Kleine-K?nig wrote:
> > > > Add support for two led triggers per UART instance that blink on
> > > > transmission and reception of data respectively.
> > > > 
> > > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > >  drivers/tty/serial/imx.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 57 insertions(+)
> > > 
> > > What is specific to this driver here? Could this be done in the
> > > core tty code instead?
> > 
> > The core doesn't notice when the driver starts to push out characters.
> > 
> > I also have a patch in my queue that adds support for rts delaying in
> > rs485 mode. While the delay between start_tx being called and the first
> > char leaving the hardware might not be big enough to care in rs232 mode,
> > with a big delay_rts_before_send it might matter.
> 
> Right, that makes sense. It still seems odd to have this just in one
> driver, and your changelog above doesn't really explain what the
> blinkenlights are actually good for.
> 
> I'm sure you had something useful in mind, can you elaborate?

I don't know the exact motivation. $customer wants to see when there is
traffic on the serial line. Is there a better motivation needed? If so,
what was the motivation for the mmc led trigger (which btw also used the
host's device name as trigger name).

> If this is something we may want to do on other platforms as well,
> we should perhaps not hardwire the name of the imx tty device in
> the led trigger name.

I cannot follow. If we have several serial lines and a trigger for each
of them, they must get different names. Using the device's name to
distinguish them seems like a good and obvious idea.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
