From: mirza.krak@hostmobility.com (Mirza Krak)
Date: Wed, 20 May 2015 11:38:03 +0200
Subject: [PATCH v2] ARM: imx: clk-v610: Add clock for I2C2 and I2C3
Message-ID: <1432114683-24945-1-git-send-email-mirza.krak@hostmobility.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mirza Krak <mirza.krak@hostmobility.com>

Add support for clock gating of I2C2 and I2C3.
We use I2C2 in a (not yet mainlined) device tree.

Signed-off-by: Mirza Krak <mirza.krak@hostmobility.com>
---

Changes since v1:
	* Rebased on branch git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git imx/soc
 drivers/clk/imx/clk-vf610.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 1c2d324..bff45ea 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -273,6 +273,8 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 
 	clk[VF610_CLK_I2C0] = imx_clk_gate2("i2c0", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(6));
 	clk[VF610_CLK_I2C1] = imx_clk_gate2("i2c1", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(7));
+	clk[VF610_CLK_I2C2] = imx_clk_gate2("i2c2", "ipg_bus", CCM_CCGR10, CCM_CCGRx_CGn(6));
+	clk[VF610_CLK_I2C3] = imx_clk_gate2("i2c3", "ipg_bus", CCM_CCGR10, CCM_CCGRx_CGn(7));
 
 	clk[VF610_CLK_DSPI0] = imx_clk_gate2("dspi0", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(12));
 	clk[VF610_CLK_DSPI1] = imx_clk_gate2("dspi1", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(13));
-- 
2.1.0
