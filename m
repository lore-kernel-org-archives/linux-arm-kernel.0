From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 26 Sep 2011 23:52:33 +0800
Subject: [PATCH v3 3/3] ARM: mx28evk: set a initial clock rate for saif
In-Reply-To: <1317052353-6029-1-git-send-email-b29396@freescale.com>
References: <1317052353-6029-1-git-send-email-b29396@freescale.com>
Message-ID: <1317052353-6029-4-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>

---
No changes since v1.
---
 arch/arm/mach-mxs/clock-mx28.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 9497346..2daab49 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -837,6 +837,15 @@ int __init mx28_clocks_init(void)
 	clk_set_parent(&saif0_clk, &pll0_clk);
 	clk_set_parent(&saif1_clk, &pll0_clk);
 
+	/*
+	 * Set an initial clk rate for saif's internal logic to work properly,
+	 * this is especially for the saif working on EXTMASTER mode that who
+	 * uses other saif's BITCLK&LRCLK but it still needs a basic clk which
+	 * should be bigger enough for its internal logic.
+	 */
+	clk_set_rate(&saif0_clk, 24000000);
+	clk_set_rate(&saif1_clk, 24000000);
+
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	mxs_timer_init(&clk32k_clk, MX28_INT_TIMER0);
-- 
1.7.0.4
