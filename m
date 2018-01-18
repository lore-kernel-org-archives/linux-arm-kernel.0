From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 18 Jan 2018 13:28:23 +0300
Subject: [PATCH] soc: xilinx: xlnx_vcu: Fix && vs & typo
Message-ID: <20180118102823.GA21064@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We accidentally used a logical AND instead of a bitwise AND here.

Fixes: cee8113a295a ("soc: xilinx: xlnx_vcu: Add Xilinx ZYNQMP VCU logicoreIP init driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/soc/xilinx/xlnx_vcu.c b/drivers/soc/xilinx/xlnx_vcu.c
index c1d6f1b190b6..a840c0272135 100644
--- a/drivers/soc/xilinx/xlnx_vcu.c
+++ b/drivers/soc/xilinx/xlnx_vcu.c
@@ -334,7 +334,7 @@ static int xvcu_set_vcu_pll_info(struct xvcu_device *xvcu)
 	 */
 	vcu_pll_ctrl = xvcu_read(xvcu->vcu_slcr_ba, VCU_PLL_CTRL);
 	clkoutdiv = vcu_pll_ctrl >> VCU_PLL_CTRL_CLKOUTDIV_SHIFT;
-	clkoutdiv = clkoutdiv && VCU_PLL_CTRL_CLKOUTDIV_MASK;
+	clkoutdiv = clkoutdiv & VCU_PLL_CTRL_CLKOUTDIV_MASK;
 	if (clkoutdiv != 1) {
 		dev_err(xvcu->dev, "clkoutdiv value is invalid\n");
 		return -EINVAL;
