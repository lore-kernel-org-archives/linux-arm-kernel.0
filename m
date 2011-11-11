From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 11 Nov 2011 17:30:55 +0800
Subject: [PATCH v5 3/3] ARM: mx28evk: set a initial clock rate for saif
In-Reply-To: <1321003855-13430-1-git-send-email-b29396@freescale.com>
References: <1321003855-13430-1-git-send-email-b29396@freescale.com>
Message-ID: <1321003855-13430-4-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>

---
Changes since v1:
 * make comments a little better.
   It's originally suggested by Uwe.
---
 arch/arm/mach-mxs/clock-mx28.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index c51fe85..b0c248d 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -808,6 +808,15 @@ int __init mx28_clocks_init(void)
 	clk_set_parent(&saif0_clk, &pll0_clk);
 	clk_set_parent(&saif1_clk, &pll0_clk);
 
+	/*
+	 * Set an initial clock rate for the saif internal logic to work
+	 * properly. This is important when working in EXTMASTER mode that
+	 * uses the other saif's BITCLK&LRCLK but it still needs a basic
+	 * clock which should be fast enough for the internal logic.
+	 */
+	clk_set_rate(&saif0_clk, 24000000);
+	clk_set_rate(&saif1_clk, 24000000);
+
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	mxs_timer_init(&clk32k_clk, MX28_INT_TIMER0);
-- 
1.7.0.4
