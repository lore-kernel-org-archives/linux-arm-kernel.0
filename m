From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 8 Mar 2011 18:51:09 +0800
Subject: [PATCH 1/2] ARM: mx28: set proper parent for lcdif clock
Message-ID: <1299581470-29854-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most likely, the LCD panel on mx28 platform will require a pixel
clock higher than ref_xtal_clk (24 MHz), so the patch initializes
the parent of lcdif clock as ref_pix_clk.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/clock-mx28.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index a350f95..5e489a2 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -750,6 +750,8 @@ int __init mx28_clocks_init(void)
 	clk_enable(&emi_clk);
 	clk_enable(&uart_clk);
 
+	clk_set_parent(&lcdif_clk, &ref_pix_clk);
+
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	mxs_timer_init(&clk32k_clk, MX28_INT_TIMER0);
-- 
1.7.1
