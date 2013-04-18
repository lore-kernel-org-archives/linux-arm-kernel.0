From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Apr 2013 11:01:13 +0200
Subject: [PATCH v3] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <20130418081555.GV30416@pengutronix.de>
References: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201304172223.43707.arnd@arndb.de> <20130418081555.GV30416@pengutronix.de>
Message-ID: <201304181101.13644.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 April 2013, Uwe Kleine-K?nig wrote:
> > > + * Each bank handles 32 irqs. Only the 16th (= last) bank handles only
> > > + * 16 irqs.
> > > + */
> > > +#define NVIC_MAX_IRQ               ((NVIC_MAX_BANKS - 1) * 32 + 16)
> > 
> > Is this actually inherent to the hardware design, or is the number of irqs
> > actually customizable? Also, why do you care about the maximum? You only
> > use it to check against the device tree provided value, but I suppose
> > you could just as well trust that property to be correct.
> I don't provide a value for the number of irqs in the device tree. There
> is only the value INTLINESNUM in the V7M_SCS_ICTR register that is used
> to determine the number of interrupt banks.

Ah, right. But do you have any reason to believe it could be wrong?

	Arnd
