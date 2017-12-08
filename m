From: dhaval23031987@gmail.com (Dhaval Shah)
Date: Fri,  8 Dec 2017 17:45:16 +0530
Subject: [PATCH] clkc: zynq: Missing a blank line after declarations.
Message-ID: <20171208121516.17389-1-dhaval23031987@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resolved missing a blank line after declarations checkpatch
warnings. Issue found by checkpatch.

Signed-off-by: Dhaval Shah <dhaval23031987@gmail.com>
---
 drivers/clk/zynq/clkc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 88a2cab37f62..1cd4705e405e 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -363,6 +363,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 	/* Peripheral clocks */
 	for (i = fclk0; i <= fclk3; i++) {
 		int enable = !!(fclk_enable & BIT(i - fclk0));
+
 		zynq_clk_register_fclk(i, clk_output_name[i],
 				SLCR_FPGA0_CLK_CTRL + 0x10 * (i - fclk0),
 				periph_parents, enable);
-- 
2.11.0
