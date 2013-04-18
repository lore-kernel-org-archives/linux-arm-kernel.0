From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Apr 2013 11:38:13 +0200
Subject: [PATCH v3] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <20130418092436.GB21099@pengutronix.de>
References: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201304181101.13644.arnd@arndb.de> <20130418092436.GB21099@pengutronix.de>
Message-ID: <201304181138.13599.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 April 2013, Uwe Kleine-K?nig wrote:
> That is, there are (INTLINESNUM + 1) * 32 irqs for INTLINESNUM < 15. For
> INTLINESNUM == 15 there are only 496 and not 16 * 32 == 512. That's the
> same on the gic (just with bigger numbers).

Ok, but since you are now using a linear domain, it doesn't actually hurt
to register 512 in that special case, right?

	Arnd
