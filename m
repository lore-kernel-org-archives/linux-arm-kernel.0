From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 19 Jul 2013 10:16:44 -0700
Subject: [PATCH 1/2] clk/zynq/pll: Fix documentation for PLL register function
Message-ID: <1374254205-9912-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clk/zynq/pll.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynq/pll.c b/drivers/clk/zynq/pll.c
index 47e307c..67f1b5e 100644
--- a/drivers/clk/zynq/pll.c
+++ b/drivers/clk/zynq/pll.c
@@ -182,7 +182,12 @@ static const struct clk_ops zynq_pll_ops = {
 
 /**
  * clk_register_zynq_pll() - Register PLL with the clock framework
- * @np	Pointer to the DT device node
+ * @name	PLL name
+ * @parent	Parent clock name
+ * @pll_ctrl	Pointer to PLL control register
+ * @pll_status	Pointer to PLL status register
+ * @lock_index	Bit index to this PLL's lock status bit in @pll_status
+ * @lock	Register lock
  */
 struct clk *clk_register_zynq_pll(const char *name, const char *parent,
 		void __iomem *pll_ctrl, void __iomem *pll_status, u8 lock_index,
-- 
1.8.3.3
