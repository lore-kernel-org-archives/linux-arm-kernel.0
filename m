From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Mon, 21 Aug 2017 10:30:28 +0800
Subject: [PATCH v1 3/3] clk: rockchip: rv1108: rename macphy to mac
In-Reply-To: <1503282628-23542-1-git-send-email-zhangqing@rock-chips.com>
References: <1503282628-23542-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1503282628-23542-4-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This MAC has no internal phy for rv1108.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rv1108.c      | 12 ++++++------
 include/dt-bindings/clock/rv1108-cru.h |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
index 0e441ec21e90..658da17c9d99 100644
--- a/drivers/clk/rockchip/clk-rv1108.c
+++ b/drivers/clk/rockchip/clk-rv1108.c
@@ -140,7 +140,7 @@ enum rv1108_plls {
 PNAME(mux_uart0_p)		= { "uart0_src", "uart0_frac", "xin24m" };
 PNAME(mux_uart1_p)		= { "uart1_src", "uart1_frac", "xin24m" };
 PNAME(mux_uart2_p)		= { "uart2_src", "uart2_frac", "xin24m" };
-PNAME(mux_sclk_macphy_p)	= { "ext_gmac", "sclk_macphy_pre" };
+PNAME(mux_sclk_mac_p)	= { "ext_gmac", "sclk_mac_pre" };
 PNAME(mux_i2s0_pre_p)		= { "i2s0_src", "i2s0_frac", "ext_i2s", "xin12m" };
 PNAME(mux_i2s_out_p)		= { "i2s0_pre", "xin12m" };
 PNAME(mux_i2s1_p)		= { "i2s1_src", "i2s1_frac", "dummy", "xin12m" };
@@ -755,14 +755,14 @@ enum rv1108_plls {
 			RV1108_CLKGATE_CON(5), 4, GFLAGS),
 	GATE(HCLK_SFC, "hclk_sfc", "hclk_periph", 0, RV1108_CLKGATE_CON(15), 10, GFLAGS),
 
-	COMPOSITE(SCLK_MACPHY_PRE, "sclk_macphy_pre", mux_pll_src_apll_gpll_p, 0,
+	COMPOSITE(SCLK_MAC_PRE, "sclk_mac_pre", mux_pll_src_apll_gpll_p, 0,
 			RV1108_CLKSEL_CON(24), 12, 1, MFLAGS, 0, 5, DFLAGS,
 			RV1108_CLKGATE_CON(4), 10, GFLAGS),
-	MUX(SCLK_MACPHY, "sclk_macphy", mux_sclk_macphy_p, CLK_SET_RATE_PARENT,
+	MUX(SCLK_MAC, "sclk_mac", mux_sclk_mac_p, CLK_SET_RATE_PARENT,
 			RV1108_CLKSEL_CON(24), 8, 1, MFLAGS),
-	GATE(SCLK_MACPHY_RX, "sclk_macphy_rx", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 8, GFLAGS),
-	GATE(SCLK_MAC_REF, "sclk_mac_ref", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 6, GFLAGS),
-	GATE(SCLK_MAC_REFOUT, "sclk_mac_refout", "sclk_macphy", 0, RV1108_CLKGATE_CON(4), 7, GFLAGS),
+	GATE(SCLK_MAC_RX, "sclk_mac_rx", "sclk_mac", 0, RV1108_CLKGATE_CON(4), 8, GFLAGS),
+	GATE(SCLK_MAC_REF, "sclk_mac_ref", "sclk_mac", 0, RV1108_CLKGATE_CON(4), 6, GFLAGS),
+	GATE(SCLK_MAC_REFOUT, "sclk_mac_refout", "sclk_mac", 0, RV1108_CLKGATE_CON(4), 7, GFLAGS),
 	GATE(ACLK_GMAC, "aclk_gmac", "aclk_periph", 0, RV1108_CLKGATE_CON(15), 4, GFLAGS),
 	GATE(PCLK_GMAC, "pclk_gmac", "pclk_periph", 0, RV1108_CLKGATE_CON(15), 5, GFLAGS),
 
diff --git a/include/dt-bindings/clock/rv1108-cru.h b/include/dt-bindings/clock/rv1108-cru.h
index 2239ae2a19b9..d8d0e0456dc2 100644
--- a/include/dt-bindings/clock/rv1108-cru.h
+++ b/include/dt-bindings/clock/rv1108-cru.h
@@ -67,9 +67,9 @@
 #define SCLK_SPI			108
 #define SCLK_SARADC			109
 #define SCLK_TSADC			110
-#define SCLK_MACPHY_PRE			111
-#define SCLK_MACPHY			112
-#define SCLK_MACPHY_RX			113
+#define SCLK_MAC_PRE			111
+#define SCLK_MAC			112
+#define SCLK_MAC_RX			113
 #define SCLK_MAC_REF			114
 #define SCLK_MAC_REFOUT			115
 #define SCLK_DSP_PFM			116
-- 
1.9.1
