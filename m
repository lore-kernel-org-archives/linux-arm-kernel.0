From: jon.mason@broadcom.com (Jon Mason)
Date: Mon, 20 Mar 2017 18:12:14 -0400
Subject: [PATCH] clk: ns2: Correct SDIO bits
Message-ID: <1490047934-3061-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>

Corrected the bits for power and iso.

Signed-off-by: Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>
Signed-off-by: Jon Mason <jon.mason@broadcom.com>
Fixes: f7225a83 ("clk: ns2: add clock support for Broadcom Northstar 2 SoC")
---
 drivers/clk/bcm/clk-ns2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-ns2.c b/drivers/clk/bcm/clk-ns2.c
index a564e92..adc1414 100644
--- a/drivers/clk/bcm/clk-ns2.c
+++ b/drivers/clk/bcm/clk-ns2.c
@@ -103,7 +103,7 @@ CLK_OF_DECLARE(ns2_genpll_src_clk, "brcm,ns2-genpll-scr",
 
 static const struct iproc_pll_ctrl genpll_sw = {
 	.flags = IPROC_CLK_AON | IPROC_CLK_PLL_SPLIT_STAT_CTRL,
-	.aon = AON_VAL(0x0, 2, 9, 8),
+	.aon = AON_VAL(0x0, 1, 11, 10),
 	.reset = RESET_VAL(0x4, 2, 1),
 	.dig_filter = DF_VAL(0x0, 9, 3, 5, 4, 2, 3),
 	.ndiv_int = REG_VAL(0x8, 4, 10),
-- 
2.7.4
