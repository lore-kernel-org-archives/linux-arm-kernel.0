From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Tue, 14 Oct 2014 20:41:49 +0300
Subject: [PATCH] ARM: i.MX6: Fix "emi" clock name typo
Message-ID: <1413308509-16468-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Longerbeam <steve_longerbeam@mentor.com>

Fix a typo error, the "emi" names refer to the eim clocks.

The change fixes typo in EIM and EIM_SLOW pre-output dividers and
selectors clock names. Notably EIM_SLOW clock itself is named correctly.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
[vladimir_zapolskiy at mentor.com: ported to v3.17]
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6q.c             |   14 +++++++-------
 include/dt-bindings/clock/imx6qdl-clock.h |    8 ++++----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 29d4129..a03cfcb 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -50,8 +50,8 @@ static const char *pcie_axi_sels[]	= { "axi", "ahb", };
 static const char *ssi_sels[]		= { "pll3_pfd2_508m", "pll3_pfd3_454m", "pll4_audio_div", };
 static const char *usdhc_sels[]	= { "pll2_pfd2_396m", "pll2_pfd0_352m", };
 static const char *enfc_sels[]	= { "pll2_pfd0_352m", "pll2_bus", "pll3_usb_otg", "pll2_pfd2_396m", };
-static const char *emi_sels[]		= { "pll2_pfd2_396m", "pll3_usb_otg", "axi", "pll2_pfd0_352m", };
-static const char *emi_slow_sels[]      = { "axi", "pll3_usb_otg", "pll2_pfd2_396m", "pll2_pfd0_352m", };
+static const char *eim_sels[]		= { "pll2_pfd2_396m", "pll3_usb_otg", "axi", "pll2_pfd0_352m", };
+static const char *eim_slow_sels[]      = { "axi", "pll3_usb_otg", "pll2_pfd2_396m", "pll2_pfd0_352m", };
 static const char *vdo_axi_sels[]	= { "axi", "ahb", };
 static const char *vpu_axi_sels[]	= { "axi", "pll2_pfd2_396m", "pll2_pfd0_352m", };
 static const char *cko1_sels[]	= { "pll3_usb_otg", "pll2_bus", "pll1_sys", "pll5_video_div",
@@ -250,8 +250,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_USDHC3_SEL]       = imx_clk_fixup_mux("usdhc3_sel", base + 0x1c, 18, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels), imx_cscmr1_fixup);
 	clk[IMX6QDL_CLK_USDHC4_SEL]       = imx_clk_fixup_mux("usdhc4_sel", base + 0x1c, 19, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels), imx_cscmr1_fixup);
 	clk[IMX6QDL_CLK_ENFC_SEL]         = imx_clk_mux("enfc_sel",         base + 0x2c, 16, 2, enfc_sels,         ARRAY_SIZE(enfc_sels));
-	clk[IMX6QDL_CLK_EMI_SEL]          = imx_clk_fixup_mux("emi_sel",      base + 0x1c, 27, 2, emi_sels,        ARRAY_SIZE(emi_sels), imx_cscmr1_fixup);
-	clk[IMX6QDL_CLK_EMI_SLOW_SEL]     = imx_clk_fixup_mux("emi_slow_sel", base + 0x1c, 29, 2, emi_slow_sels,   ARRAY_SIZE(emi_slow_sels), imx_cscmr1_fixup);
+	clk[IMX6QDL_CLK_EIM_SEL]          = imx_clk_fixup_mux("eim_sel",      base + 0x1c, 27, 2, eim_sels,        ARRAY_SIZE(eim_sels), imx_cscmr1_fixup);
+	clk[IMX6QDL_CLK_EIM_SLOW_SEL]     = imx_clk_fixup_mux("eim_slow_sel", base + 0x1c, 29, 2, eim_slow_sels,   ARRAY_SIZE(eim_slow_sels), imx_cscmr1_fixup);
 	clk[IMX6QDL_CLK_VDO_AXI_SEL]      = imx_clk_mux("vdo_axi_sel",      base + 0x18, 11, 1, vdo_axi_sels,      ARRAY_SIZE(vdo_axi_sels));
 	clk[IMX6QDL_CLK_VPU_AXI_SEL]      = imx_clk_mux("vpu_axi_sel",      base + 0x18, 14, 2, vpu_axi_sels,      ARRAY_SIZE(vpu_axi_sels));
 	clk[IMX6QDL_CLK_CKO1_SEL]         = imx_clk_mux("cko1_sel",         base + 0x60, 0,  4, cko1_sels,         ARRAY_SIZE(cko1_sels));
@@ -302,8 +302,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_USDHC4_PODF]      = imx_clk_divider("usdhc4_podf",      "usdhc4_sel",        base + 0x24, 22, 3);
 	clk[IMX6QDL_CLK_ENFC_PRED]        = imx_clk_divider("enfc_pred",        "enfc_sel",          base + 0x2c, 18, 3);
 	clk[IMX6QDL_CLK_ENFC_PODF]        = imx_clk_divider("enfc_podf",        "enfc_pred",         base + 0x2c, 21, 6);
-	clk[IMX6QDL_CLK_EMI_PODF]         = imx_clk_fixup_divider("emi_podf",   "emi_sel",           base + 0x1c, 20, 3, imx_cscmr1_fixup);
-	clk[IMX6QDL_CLK_EMI_SLOW_PODF]    = imx_clk_fixup_divider("emi_slow_podf", "emi_slow_sel",   base + 0x1c, 23, 3, imx_cscmr1_fixup);
+	clk[IMX6QDL_CLK_EIM_PODF]         = imx_clk_fixup_divider("eim_podf",   "eim_sel",           base + 0x1c, 20, 3, imx_cscmr1_fixup);
+	clk[IMX6QDL_CLK_EIM_SLOW_PODF]    = imx_clk_fixup_divider("eim_slow_podf", "eim_slow_sel",   base + 0x1c, 23, 3, imx_cscmr1_fixup);
 	clk[IMX6QDL_CLK_VPU_AXI_PODF]     = imx_clk_divider("vpu_axi_podf",     "vpu_axi_sel",       base + 0x24, 25, 3);
 	clk[IMX6QDL_CLK_CKO1_PODF]        = imx_clk_divider("cko1_podf",        "cko1_sel",          base + 0x60, 4,  3);
 	clk[IMX6QDL_CLK_CKO2_PODF]        = imx_clk_divider("cko2_podf",        "cko2_sel",          base + 0x60, 21, 3);
@@ -398,7 +398,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_USDHC2]       = imx_clk_gate2("usdhc2",        "usdhc2_podf",       base + 0x80, 4);
 	clk[IMX6QDL_CLK_USDHC3]       = imx_clk_gate2("usdhc3",        "usdhc3_podf",       base + 0x80, 6);
 	clk[IMX6QDL_CLK_USDHC4]       = imx_clk_gate2("usdhc4",        "usdhc4_podf",       base + 0x80, 8);
-	clk[IMX6QDL_CLK_EIM_SLOW]     = imx_clk_gate2("eim_slow",      "emi_slow_podf",     base + 0x80, 10);
+	clk[IMX6QDL_CLK_EIM_SLOW]     = imx_clk_gate2("eim_slow",      "eim_slow_podf",     base + 0x80, 10);
 	clk[IMX6QDL_CLK_VDO_AXI]      = imx_clk_gate2("vdo_axi",       "vdo_axi_sel",       base + 0x80, 12);
 	clk[IMX6QDL_CLK_VPU_AXI]      = imx_clk_gate2("vpu_axi",       "vpu_axi_podf",      base + 0x80, 14);
 	clk[IMX6QDL_CLK_CKO1]         = imx_clk_gate("cko1",           "cko1_podf",         base + 0x60, 7);
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index 654151e..ac190e3 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -62,8 +62,8 @@
 #define IMX6QDL_CLK_USDHC3_SEL			50
 #define IMX6QDL_CLK_USDHC4_SEL			51
 #define IMX6QDL_CLK_ENFC_SEL			52
-#define IMX6QDL_CLK_EMI_SEL			53
-#define IMX6QDL_CLK_EMI_SLOW_SEL		54
+#define IMX6QDL_CLK_EIM_SEL			53
+#define IMX6QDL_CLK_EIM_SLOW_SEL		54
 #define IMX6QDL_CLK_VDO_AXI_SEL			55
 #define IMX6QDL_CLK_VPU_AXI_SEL			56
 #define IMX6QDL_CLK_CKO1_SEL			57
@@ -106,8 +106,8 @@
 #define IMX6QDL_CLK_USDHC4_PODF			94
 #define IMX6QDL_CLK_ENFC_PRED			95
 #define IMX6QDL_CLK_ENFC_PODF			96
-#define IMX6QDL_CLK_EMI_PODF			97
-#define IMX6QDL_CLK_EMI_SLOW_PODF		98
+#define IMX6QDL_CLK_EIM_PODF			97
+#define IMX6QDL_CLK_EIM_SLOW_PODF		98
 #define IMX6QDL_CLK_VPU_AXI_PODF		99
 #define IMX6QDL_CLK_CKO1_PODF			100
 #define IMX6QDL_CLK_AXI				101
-- 
1.7.10.4
