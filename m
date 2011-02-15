From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 15 Feb 2011 17:23:23 +0100
Subject: [PATCH] i2c-pxa: fix unbinding/rebinding of the device
In-Reply-To: <AANLkTimO1KFNm5xZ+2qJoGQq-ndVg0ER3KKwf0RYYOLK@mail.gmail.com>
References: <20110106124028.GX25121@pengutronix.de>
	<1294502804-6580-1-git-send-email-dbaryshkov@gmail.com>
	<20110108161828.GC8237@pengutronix.de>
	<AANLkTimO1KFNm5xZ+2qJoGQq-ndVg0ER3KKwf0RYYOLK@mail.gmail.com>
Message-ID: <20110215162323.GO13279@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 04:59:28PM +0300, Dmitry Eremin-Solenikov wrote:
> Hello, all
> 
> 2011/1/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > On Sat, Jan 08, 2011 at 07:06:44PM +0300, Dmitry Eremin-Solenikov wrote:
> >> When a "pxa2xx-i2c" device was unbound (e.g. via sysfs) the remove
> >> callback was not called because it was discarded when linking the
> >> kernel. ?Because of that the resources allocated in probe were not
> >> freed and so a clean unbind/rebind was impossible.
> >>
> >> Fix that by moving the remove callback to .devexit.text.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> I see this patch is still not pushed to neither linus nor linux-next.
> Should I put it into rmk's patch system? Or will it find it's way to main kernel
> via other paths?
rmk's patch system isn't the right place.  Ben needs to take it.  Ben?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
