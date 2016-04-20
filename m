From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 20 Apr 2016 19:06:49 +0800
Subject: [PATCH 1/6] clk: rockchip: rk3399: export some necessary clock IDs
In-Reply-To: <1461150414-29638-1-git-send-email-zhengxing@rock-chips.com>
References: <1461150414-29638-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1461150414-29638-2-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We export some clock IDs for the reference drivers need them.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3399.c      |   12 ++++++------
 include/dt-bindings/clock/rk3399-cru.h |    5 ++++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index e8f040b..7ec84fd 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -554,7 +554,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(20), 14, 2, MFLAGS, 8, 5, DFLAGS,
 			RK3399_CLKGATE_CON(5), 5, GFLAGS),
 
-	MUX(0, "clk_rmii_src", mux_rmii_p, CLK_SET_RATE_PARENT,
+	MUX(SCLK_RMII_SRC, "clk_rmii_src", mux_rmii_p, CLK_SET_RATE_PARENT,
 			RK3399_CLKSEL_CON(19), 4, 1, MFLAGS),
 	GATE(SCLK_MACREF_OUT, "clk_mac_refout", "clk_rmii_src", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(5), 6, GFLAGS),
@@ -780,7 +780,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(16), 1, GFLAGS),
 
 	/* rga */
-	COMPOSITE(0, "clk_rga_core", mux_pll_src_cpll_gpll_npll_ppll_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(SCLK_RGA_CORE, "clk_rga_core", mux_pll_src_cpll_gpll_npll_ppll_p, CLK_IGNORE_UNUSED,
 			RK3399_CLKSEL_CON(12), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(4), 10, GFLAGS),
 
@@ -896,7 +896,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(17), 8, 3, MFLAGS, 0, 7, DFLAGS,
 			RK3399_CLKGATE_CON(6), 2, GFLAGS),
 
-	COMPOSITE_NOMUX(0, "clk_pciephy_ref100m", "npll", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(SCLK_PCIEPHY_REF100M, "clk_pciephy_ref100m", "npll", CLK_IGNORE_UNUSED,
 			RK3399_CLKSEL_CON(18), 11, 5, DFLAGS,
 			RK3399_CLKGATE_CON(12), 6, GFLAGS),
 	MUX(SCLK_PCIEPHY_REF, "clk_pciephy_ref", mux_pll_src_24m_pciephy_p, CLK_SET_RATE_PARENT,
@@ -1191,10 +1191,10 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(10), 15, GFLAGS),
 
 	/* isp */
-	COMPOSITE(0, "aclk_isp0", mux_pll_src_cpll_gpll_ppll_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(ACLK_ISP0, "aclk_isp0", mux_pll_src_cpll_gpll_ppll_p, CLK_IGNORE_UNUSED,
 			RK3399_CLKSEL_CON(53), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(12), 8, GFLAGS),
-	COMPOSITE_NOMUX(0, "hclk_isp0", "aclk_isp0", 0,
+	COMPOSITE_NOMUX(HCLK_ISP0, "hclk_isp0", "aclk_isp0", 0,
 			RK3399_CLKSEL_CON(53), 8, 5, DFLAGS,
 			RK3399_CLKGATE_CON(12), 9, GFLAGS),
 
@@ -1217,7 +1217,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	COMPOSITE(ACLK_ISP1, "aclk_isp1", mux_pll_src_cpll_gpll_ppll_p, CLK_IGNORE_UNUSED,
 			RK3399_CLKSEL_CON(54), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(12), 10, GFLAGS),
-	COMPOSITE_NOMUX(0, "hclk_isp1", "aclk_isp1", 0,
+	COMPOSITE_NOMUX(HCLK_ISP1, "hclk_isp1", "aclk_isp1", 0,
 			RK3399_CLKSEL_CON(54), 8, 5, DFLAGS,
 			RK3399_CLKGATE_CON(12), 11, GFLAGS),
 
diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings/clock/rk3399-cru.h
index f60fe6e..50a44cf 100644
--- a/include/dt-bindings/clock/rk3399-cru.h
+++ b/include/dt-bindings/clock/rk3399-cru.h
@@ -72,7 +72,7 @@
 #define SCLK_MACREF_OUT			106
 #define SCLK_VOP0_PWM			107
 #define SCLK_VOP1_PWM			108
-#define SCLK_RGA			109
+#define SCLK_RGA_CORE			109
 #define SCLK_ISP0			110
 #define SCLK_ISP1			111
 #define SCLK_HDMI_CEC			112
@@ -129,6 +129,8 @@
 #define SCLK_DPHY_TX0_CFG		163
 #define SCLK_DPHY_TX1RX1_CFG		164
 #define SCLK_DPHY_RX0_CFG		165
+#define SCLK_RMII_SRC			166
+#define SCLK_PCIEPHY_REF100M		167
 
 #define DCLK_VOP0			180
 #define DCLK_VOP1			181
@@ -671,6 +673,7 @@
 #define SRST_P_EDP_CTRL			285
 
 /* cru_softrst_con18 */
+#define SRST_A_GPU			288
 #define SRST_A_GPU_NOC			289
 #define SRST_A_GPU_GRF			290
 #define SRST_PVTM_GPU			291
-- 
1.7.9.5
