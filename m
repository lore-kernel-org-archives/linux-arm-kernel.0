From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 19 Apr 2013 15:51:07 +0200
Subject: [PATCH v3] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <201304181138.13599.arnd@arndb.de>
References: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201304181101.13644.arnd@arndb.de>
 <20130418092436.GB21099@pengutronix.de>
 <201304181138.13599.arnd@arndb.de>
Message-ID: <20130419135107.GD15233@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 11:38:13AM +0200, Arnd Bergmann wrote:
> On Thursday 18 April 2013, Uwe Kleine-K?nig wrote:
> > That is, there are (INTLINESNUM + 1) * 32 irqs for INTLINESNUM < 15. For
> > INTLINESNUM == 15 there are only 496 and not 16 * 32 == 512. That's the
> > same on the gic (just with bigger numbers).
> 
> Ok, but since you are now using a linear domain, it doesn't actually hurt
> to register 512 in that special case, right?
Well, it depends if allocating space for 16 unused unsigned ints hurts
(maybe not). And it makes mapping some irqs successfull while the irq
doesn't really exist. But probably this doesn't hurt either because the
problem already exists.

I don't care much. Is there another advantage beside saving a few source
lines/instructions?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
