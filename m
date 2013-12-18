From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 18 Dec 2013 18:02:59 +0100
Subject: [PATCH V2 1/4] ARM: socfpga: clk: remove unused field
In-Reply-To: <1387386182-30923-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1387386182-30923-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1387386182-30923-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_name field from the socfpga_clk struct is unused.
Remove it.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/clk/socfpga/clk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 46911748..4503863 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -68,7 +68,6 @@ static void __iomem *clk_mgr_base_addr;
 struct socfpga_clk {
 	struct clk_gate hw;
 	char *parent_name;
-	char *clk_name;
 	u32 fixed_div;
 	void __iomem *div_reg;
 	u32 width;	/* only valid if div_reg != 0 */
-- 
1.8.5.1
