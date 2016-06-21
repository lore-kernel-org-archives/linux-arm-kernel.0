From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 21 Jun 2016 12:59:47 +0800
Subject: [PATCH 5/5] clk: rockchip: rk3228: export related MAC clocks
In-Reply-To: <1466484811-26923-1-git-send-email-zhengxing@rock-chips.com>
References: <1466484811-26923-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1466485187-27081-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch exports related MAC clocks for dts reference.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3228.c      |   22 +++++++++++-----------
 include/dt-bindings/clock/rk3228-cru.h |   11 +++++++++++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index 980d0da..db6e5a9 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -499,25 +499,25 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(2), 14, 1, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(1), 0, GFLAGS),
 
-	COMPOSITE(0, "sclk_gmac_src", mux_pll_src_2plls_p, 0,
+	COMPOSITE(SCLK_MAC_SRC, "sclk_gmac_src", mux_pll_src_2plls_p, 0,
 			RK2928_CLKSEL_CON(5), 7, 1, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(1), 7, GFLAGS),
-	MUX(0, "sclk_mac_extclk", mux_sclk_mac_extclk_p, 0,
+	MUX(SCLK_MAC_EXTCLK, "sclk_mac_extclk", mux_sclk_mac_extclk_p, 0,
 			RK2928_CLKSEL_CON(29), 10, 1, MFLAGS),
-	MUX(0, "sclk_gmac_pre", mux_sclk_gmac_pre_p, 0,
+	MUX(SCLK_MAC, "sclk_gmac_pre", mux_sclk_gmac_pre_p, 0,
 			RK2928_CLKSEL_CON(5), 5, 1, MFLAGS),
-	GATE(0, "sclk_mac_refout", "sclk_gmac_pre", 0,
+	GATE(SCLK_MAC_REFOUT, "sclk_mac_refout", "sclk_gmac_pre", 0,
 			RK2928_CLKGATE_CON(5), 4, GFLAGS),
-	GATE(0, "sclk_mac_ref", "sclk_gmac_pre", 0,
+	GATE(SCLK_MAC_REF, "sclk_mac_ref", "sclk_gmac_pre", 0,
 			RK2928_CLKGATE_CON(5), 3, GFLAGS),
-	GATE(0, "sclk_mac_rx", "sclk_gmac_pre", 0,
+	GATE(SCLK_MAC_RX, "sclk_mac_rx", "sclk_gmac_pre", 0,
 			RK2928_CLKGATE_CON(5), 5, GFLAGS),
-	GATE(0, "sclk_mac_tx", "sclk_gmac_pre", 0,
+	GATE(SCLK_MAC_TX, "sclk_mac_tx", "sclk_gmac_pre", 0,
 			RK2928_CLKGATE_CON(5), 6, GFLAGS),
-	COMPOSITE(0, "sclk_macphy", mux_sclk_macphy_p, 0,
+	COMPOSITE(SCLK_MAC_PHY, "sclk_macphy", mux_sclk_macphy_p, 0,
 			RK2928_CLKSEL_CON(29), 12, 1, MFLAGS, 8, 2, DFLAGS,
 			RK2928_CLKGATE_CON(5), 7, GFLAGS),
-	COMPOSITE(0, "sclk_gmac_out", mux_pll_src_2plls_p, 0,
+	COMPOSITE(SCLK_MAC_OUT, "sclk_gmac_out", mux_pll_src_2plls_p, 0,
 			RK2928_CLKSEL_CON(5), 15, 1, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(2), 2, GFLAGS),
 
@@ -551,7 +551,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 
 	/* PD_PERI */
 	GATE(0, "aclk_peri_noc", "aclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(12), 0, GFLAGS),
-	GATE(0, "aclk_gmac", "aclk_peri", 0, RK2928_CLKGATE_CON(11), 4, GFLAGS),
+	GATE(ACLK_GMAC, "aclk_gmac", "aclk_peri", 0, RK2928_CLKGATE_CON(11), 4, GFLAGS),
 
 	GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 0, GFLAGS),
 	GATE(HCLK_SDIO, "hclk_sdio", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 1, GFLAGS),
@@ -567,7 +567,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 	GATE(0, "hclk_host2_arb", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 14, GFLAGS),
 	GATE(0, "hclk_peri_noc", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(12), 1, GFLAGS),
 
-	GATE(0, "pclk_gmac", "pclk_peri", 0, RK2928_CLKGATE_CON(11), 5, GFLAGS),
+	GATE(PCLK_GMAC, "pclk_gmac", "pclk_peri", 0, RK2928_CLKGATE_CON(11), 5, GFLAGS),
 	GATE(0, "pclk_peri_noc", "pclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(12), 2, GFLAGS),
 
 	/* PD_GPU */
diff --git a/include/dt-bindings/clock/rk3228-cru.h b/include/dt-bindings/clock/rk3228-cru.h
index c992f3e..b27e2b1 100644
--- a/include/dt-bindings/clock/rk3228-cru.h
+++ b/include/dt-bindings/clock/rk3228-cru.h
@@ -52,6 +52,15 @@
 #define SCLK_EMMC_SAMPLE	121
 #define SCLK_VOP		122
 #define SCLK_HDMI_HDCP		123
+#define SCLK_MAC_SRC		124
+#define SCLK_MAC_EXTCLK		125
+#define SCLK_MAC		126
+#define SCLK_MAC_REFOUT		127
+#define SCLK_MAC_REF		128
+#define SCLK_MAC_RX		129
+#define SCLK_MAC_TX		130
+#define SCLK_MAC_PHY		131
+#define SCLK_MAC_OUT		132
 
 /* dclk gates */
 #define DCLK_VOP		190
@@ -61,6 +70,7 @@
 #define ACLK_DMAC		194
 #define ACLK_PERI		210
 #define ACLK_VOP		211
+#define ACLK_GMAC		212
 
 /* pclk gates */
 #define PCLK_GPIO0		320
@@ -82,6 +92,7 @@
 #define PCLK_PERI		363
 #define PCLK_HDMI_CTRL		364
 #define PCLK_HDMI_PHY		365
+#define PCLK_GMAC		367
 
 /* hclk gates */
 #define HCLK_I2S0_8CH		442
-- 
1.7.9.5
