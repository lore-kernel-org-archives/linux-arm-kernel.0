From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 22 Apr 2013 15:50:50 +0200 (CEST)
Subject: [PATCH v3] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <201304221404.31281.arnd@arndb.de>
References: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130419150927.GE15233@pengutronix.de>
 <20130422100219.GH15233@pengutronix.de> <201304221404.31281.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1304221519221.21884@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Apr 2013, Arnd Bergmann wrote:
> On Monday 22 April 2013, Uwe Kleine-K?nig wrote:
> > For the uncommented files using %32 instead of -gc->irq_base should
> > work.
> 
> I'm not sure I understand why this doesn't work for the ones that use
> a base that isn't a multiple of 32. Since you are masking the hwirq
> rather than the irq number, it will still be zero-based, won't it?

The issue is that for anything which uses this w/o irq domains
d->hwirq is 0.

Thanks,

	tglx
