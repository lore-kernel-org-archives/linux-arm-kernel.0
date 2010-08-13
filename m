From: hjk@linutronix.de (Hans J. Koch)
Date: Fri, 13 Aug 2010 11:14:33 +0200
Subject: [PATCH v3] mx35: Fix boot ROM hang in internal boot mode
In-Reply-To: <20100813090849.GB27637@pengutronix.de>
References: <20100812131053.GD8670@local>
	<20100813090849.GB27637@pengutronix.de>
Message-ID: <20100813091432.GA22619@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 13, 2010 at 11:08:49AM +0200, Uwe Kleine-K?nig wrote:
> On Thu, Aug 12, 2010 at 03:10:53PM +0200, Hans J. Koch wrote:
> > If a watchdog reset occurs after booting in internal boot mode, the i.MX35
> > won't boot anymore. The boot ROM code seems to assume that some clocks are
> > turned on (they are after a power-on reset). This patch turns on the
> > necessary clocks.
> > 
> > Signed-off-by: Hans J. Koch <hjk@linutronix.de>
> Even if it should be a bootloader issue and not a ROM problem this fix
> is sensible.
> 
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

We should also add:

Reported-by: John Ogness <jogness@linutronix.de>

I forgot that.

Thanks,
Hans

> 
> Thanks
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
