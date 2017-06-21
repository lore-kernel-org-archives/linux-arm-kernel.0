From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Wed, 21 Jun 2017 17:00:41 +0800
Subject: [PATCH 1/5] clk: hisilicon: add usb2 clocks for hi3798cv200 SoC
In-Reply-To: <1498035645-22804-1-git-send-email-xuejiancheng@hisilicon.com>
References: <1498035645-22804-1-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <1498035645-22804-2-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb2 clocks for hi3798cv200 SoC.

Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/clk/hisilicon/crg-hi3798cv200.c | 21 +++++++++++++++++++++
 include/dt-bindings/clock/histb-clock.h |  9 ++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798cv200.c b/drivers/clk/hisilicon/crg-hi3798cv200.c
index fc8b5bc..ed8bb5f 100644
--- a/drivers/clk/hisilicon/crg-hi3798cv200.c
+++ b/drivers/clk/hisilicon/crg-hi3798cv200.c
@@ -44,6 +44,9 @@
 #define HI3798CV200_ETH_BUS0_CLK	78
 #define HI3798CV200_ETH_BUS1_CLK	79
 #define HI3798CV200_COMBPHY1_MUX	80
+#define HI3798CV200_FIXED_12M	81
+#define HI3798CV200_FIXED_48M	82
+#define HI3798CV200_FIXED_60M	83
 
 #define HI3798CV200_CRG_NR_CLKS		128
 
@@ -51,9 +54,12 @@
 	{ HISTB_OSC_CLK, "clk_osc", NULL, 0, 24000000, },
 	{ HISTB_APB_CLK, "clk_apb", NULL, 0, 100000000, },
 	{ HISTB_AHB_CLK, "clk_ahb", NULL, 0, 200000000, },
+	{ HI3798CV200_FIXED_12M, "12m", NULL, 0, 12000000, },
 	{ HI3798CV200_FIXED_24M, "24m", NULL, 0, 24000000, },
 	{ HI3798CV200_FIXED_25M, "25m", NULL, 0, 25000000, },
+	{ HI3798CV200_FIXED_48M, "48m", NULL, 0, 48000000, },
 	{ HI3798CV200_FIXED_50M, "50m", NULL, 0, 50000000, },
+	{ HI3798CV200_FIXED_60M, "60m", NULL, 0, 60000000, },
 	{ HI3798CV200_FIXED_75M, "75m", NULL, 0, 75000000, },
 	{ HI3798CV200_FIXED_100M, "100m", NULL, 0, 100000000, },
 	{ HI3798CV200_FIXED_150M, "150m", NULL, 0, 150000000, },
@@ -134,6 +140,21 @@
 	/* COMBPHY1 */
 	{ HISTB_COMBPHY1_CLK, "clk_combphy1", "combphy1_mux",
 		CLK_SET_RATE_PARENT, 0x188, 8, 0, },
+	/* USB2 */
+	{ HISTB_USB2_BUS_CLK, "clk_u2_bus", "clk_ahb",
+		CLK_SET_RATE_PARENT, 0xb8, 0, 0, },
+	{ HISTB_USB2_PHY_CLK, "clk_u2_phy", "60m",
+		CLK_SET_RATE_PARENT, 0xb8, 4, 0, },
+	{ HISTB_USB2_12M_CLK, "clk_u2_12m", "12m",
+		CLK_SET_RATE_PARENT, 0xb8, 2, 0 },
+	{ HISTB_USB2_48M_CLK, "clk_u2_48m", "48m",
+		CLK_SET_RATE_PARENT, 0xb8, 1, 0 },
+	{ HISTB_USB2_UTMI_CLK, "clk_u2_utmi", "60m",
+		CLK_SET_RATE_PARENT, 0xb8, 5, 0 },
+	{ HISTB_USB2_PHY1_REF_CLK, "clk_u2_phy1_ref", "24m",
+		CLK_SET_RATE_PARENT, 0xbc, 0, 0 },
+	{ HISTB_USB2_PHY2_REF_CLK, "clk_u2_phy2_ref", "24m",
+		CLK_SET_RATE_PARENT, 0xbc, 2, 0 },
 };
 
 static struct hisi_clock_data *hi3798cv200_clk_register(
diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
index 181c0f0..067f5e5 100644
--- a/include/dt-bindings/clock/histb-clock.h
+++ b/include/dt-bindings/clock/histb-clock.h
@@ -53,7 +53,14 @@
 #define HISTB_ETH1_MAC_CLK		31
 #define HISTB_ETH1_MACIF_CLK		32
 #define HISTB_COMBPHY1_CLK		33
-
+#define HISTB_USB2_BUS_CLK	34
+#define HISTB_USB2_PHY_CLK	35
+#define HISTB_USB2_UTMI_CLK	36
+#define HISTB_USB2_12M_CLK	37
+#define HISTB_USB2_48M_CLK	38
+#define HISTB_USB2_OTG_UTMI_CLK	39
+#define HISTB_USB2_PHY1_REF_CLK	40
+#define HISTB_USB2_PHY2_REF_CLK	41
 
 /* clocks provided by mcu CRG */
 #define HISTB_MCE_CLK	1
-- 
1.9.1
