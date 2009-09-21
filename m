From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 21 Sep 2009 11:16:14 +0200
Subject: [PATCH] Don't disable irqs in set_next_event and set_mode
	callbacks
In-Reply-To: <20090921090400.GD27357@n2100.arm.linux.org.uk>
References: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20090921090400.GD27357@n2100.arm.linux.org.uk>
Message-ID: <20090921091614.GA25422@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2009 at 10:04:00AM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 21, 2009 at 09:39:22AM +0200, Uwe Kleine-K?nig wrote:
> > These functions are called with irqs already off.
> > 
> > at91rm2000 had a WARN_ON_ONCE if irqs were enabled since Nov 2008 with
> > noone reporting having hit it.
> 
> It might be useful to document these clockevent interfaces.  There's
> at least a few ARM clockevent implementations which don't set the
> periodic interval when set_next_event() is called - probably because
> it wasn't realised that it was required.
I'm a bit confused now as AFAIK set_next_event isn't called in periodic
mode.

You mean they don't start the timer if mode==CLOCK_EVT_MODE_PERIODIC in
.set_mode?
It looks as if pxa is such an implementation, it does nothing in this
case.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
