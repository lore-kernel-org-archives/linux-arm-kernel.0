From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Feb 2016 18:25:32 +0100
Subject: [PATCH] ARM: prima2: always enable reset controller
In-Reply-To: <1456417673-2115511-1-git-send-email-arnd@arndb.de>
References: <1456417673-2115511-1-git-send-email-arnd@arndb.de>
Message-ID: <1456421132.3268.16.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 25.02.2016, 17:27 +0100 schrieb Arnd Bergmann:
> The atlas7 clock controller driver registers a reset controller
> for itself, which causes a link error when the subsystem is
> disabled:
> 
> drivers/built-in.o: In function `atlas7_clk_init':
> drivers/clk/sirf/clk-atlas7.c:1681: undefined reference to `reset_controller_register'
> 
> As the clk driver does not have a Kconfig symbol for itself
> but it always built-in when the platform is enabled, we have
> to ensure that the reset controller subsystem is also built-in
> in this case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 301c5d29402e ("clk: sirf: add CSR atlas7 clk and reset support")

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
