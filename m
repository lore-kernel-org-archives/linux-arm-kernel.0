From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu,  7 Nov 2013 16:07:05 +0100
Subject: [PATCH 1/4] ARM: socfpga: clk: remove unused field
In-Reply-To: <1383836828-24886-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1383836828-24886-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1383836828-24886-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_name field from the socfpga_clk struct is unused.
Remove it.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/clk/socfpga/clk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 81dd31a..9bcf84e 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -60,7 +60,6 @@ extern void __iomem *clk_mgr_base_addr;
 struct socfpga_clk {
 	struct clk_gate hw;
 	char *parent_name;
-	char *clk_name;
 	u32 fixed_div;
 	void __iomem *div_reg;
 	u32 width;	/* only valid if div_reg != 0 */
-- 
1.8.4.rc3
