From: mirza.krak@hostmobility.com (Mirza Krak)
Date: Tue, 19 May 2015 14:27:36 +0200
Subject: [PATCH 1/1] ARM: imx: clk-v610: Add clock for I2C2 and I2C3
Message-ID: <1432038456-29706-1-git-send-email-mirza.krak@hostmobility.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mirza Krak <mirza.krak@gmail.com>

Add support for clock gating of I2C2 and I2C3.
We use I2C2 in a (not yet mainlined) device tree.

Signed-off-by: Mirza Krak <mirza.krak@hostmobility.com>
Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
---
 arch/arm/mach-imx/clk-vf610.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/clk-vf610.c b/arch/arm/mach-imx/clk-vf610.c
index 5fcc4be..f5fff09 100644
--- a/arch/arm/mach-imx/clk-vf610.c
+++ b/arch/arm/mach-imx/clk-vf610.c
@@ -279,6 +279,8 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 
 	clk[VF610_CLK_I2C0] = imx_clk_gate2("i2c0", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(6));
 	clk[VF610_CLK_I2C1] = imx_clk_gate2("i2c1", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(7));
+	clk[VF610_CLK_I2C2] = imx_clk_gate2("i2c2", "ipg_bus", CCM_CCGR10, CCM_CCGRx_CGn(6));
+	clk[VF610_CLK_I2C3] = imx_clk_gate2("i2c3", "ipg_bus", CCM_CCGR10, CCM_CCGRx_CGn(7));
 
 	clk[VF610_CLK_DSPI0] = imx_clk_gate2("dspi0", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(12));
 	clk[VF610_CLK_DSPI1] = imx_clk_gate2("dspi1", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(13));
-- 
2.1.0
