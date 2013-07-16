From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Jul 2013 20:56:48 +0800
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1373968166.4327.11.camel@pizza.hi.pengutronix.de>
References: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
 <20130716015038.GD28375@S2101-09.ap.freescale.net>
 <51E4BF98.8030604@wwwdotorg.org>
 <20130716041056.GA30067@S2101-09.ap.freescale.net>
 <1373968166.4327.11.camel@pizza.hi.pengutronix.de>
Message-ID: <20130716125646.GM28375@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 11:49:26AM +0200, Philipp Zabel wrote:
> so you want to have gpio-reset probed at arch_initcall time and you have
> gpio-pca953x probed at subsys_initcall time. Won't then all gpio-reset
> devices that use gpios on pca953x to reset other peripherals need to be
> deferred?

Yes, they will be deferred, but they will be probed and ready at
subsys_initcall time when gpio-pca953x probes.  This is still good since
most of component device drivers probes at module_init time.

Shawn
