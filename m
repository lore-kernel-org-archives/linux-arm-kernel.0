From: adriana.reus@nxp.com (Adriana Reus)
Date: Mon,  2 Oct 2017 13:32:11 +0300
Subject: [PATCH RESEND 2/2] clk: imx: imx7d: Remove ARM_M0 clock
In-Reply-To: <1506940331-16742-1-git-send-email-adriana.reus@nxp.com>
References: <1506940331-16742-1-git-send-email-adriana.reus@nxp.com>
Message-ID: <1506940331-16742-3-git-send-email-adriana.reus@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IMX7d does not have an M0 Core and this particular
clock doesn't seem connected to anything else.
Remove this entry from the CCM driver.

Signed-off-by: Adriana Reus <adriana.reus@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c             | 9 ---------
 include/dt-bindings/clock/imx7d-clock.h | 8 ++++----
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 0ac9b30..80dc211 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -54,11 +54,6 @@ static const char *arm_m4_sel[] = { "osc", "pll_sys_main_240m_clk",
 	"pll_dram_533m_clk", "pll_audio_post_div", "pll_video_main_clk",
 	"pll_usb_main_clk", };
 
-static const char *arm_m0_sel[] = { "osc", "pll_sys_main_120m_clk",
-	"pll_enet_125m_clk", "pll_sys_pfd2_135m_clk",
-	"pll_dram_533m_clk", "pll_audio_post_div", "pll_video_main_clk",
-	"pll_usb_main_clk", };
-
 static const char *axi_sel[] = { "osc", "pll_sys_pfd1_332m_clk",
 	"pll_dram_533m_clk", "pll_enet_250m_clk", "pll_sys_pfd5_clk",
 	"pll_audio_post_div", "pll_video_main_clk", "pll_sys_pfd7_clk", };
@@ -510,7 +505,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 
 	clks[IMX7D_ARM_A7_ROOT_SRC] = imx_clk_mux2("arm_a7_src", base + 0x8000, 24, 3, arm_a7_sel, ARRAY_SIZE(arm_a7_sel));
 	clks[IMX7D_ARM_M4_ROOT_SRC] = imx_clk_mux2("arm_m4_src", base + 0x8080, 24, 3, arm_m4_sel, ARRAY_SIZE(arm_m4_sel));
-	clks[IMX7D_ARM_M0_ROOT_SRC] = imx_clk_mux2("arm_m0_src", base + 0x8100, 24, 3, arm_m0_sel, ARRAY_SIZE(arm_m0_sel));
 	clks[IMX7D_MAIN_AXI_ROOT_SRC] = imx_clk_mux2("axi_src", base + 0x8800, 24, 3, axi_sel, ARRAY_SIZE(axi_sel));
 	clks[IMX7D_DISP_AXI_ROOT_SRC] = imx_clk_mux2("disp_axi_src", base + 0x8880, 24, 3, disp_axi_sel, ARRAY_SIZE(disp_axi_sel));
 	clks[IMX7D_ENET_AXI_ROOT_SRC] = imx_clk_mux2("enet_axi_src", base + 0x8900, 24, 3, enet_axi_sel, ARRAY_SIZE(enet_axi_sel));
@@ -582,7 +576,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 
 	clks[IMX7D_ARM_A7_ROOT_CG] = imx_clk_gate3("arm_a7_cg", "arm_a7_src", base + 0x8000, 28);
 	clks[IMX7D_ARM_M4_ROOT_CG] = imx_clk_gate3("arm_m4_cg", "arm_m4_src", base + 0x8080, 28);
-	clks[IMX7D_ARM_M0_ROOT_CG] = imx_clk_gate3("arm_m0_cg", "arm_m0_src", base + 0x8100, 28);
 	clks[IMX7D_MAIN_AXI_ROOT_CG] = imx_clk_gate3("axi_cg", "axi_src", base + 0x8800, 28);
 	clks[IMX7D_DISP_AXI_ROOT_CG] = imx_clk_gate3("disp_axi_cg", "disp_axi_src", base + 0x8880, 28);
 	clks[IMX7D_ENET_AXI_ROOT_CG] = imx_clk_gate3("enet_axi_cg", "enet_axi_src", base + 0x8900, 28);
@@ -721,7 +714,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 
 	clks[IMX7D_ARM_A7_ROOT_DIV] = imx_clk_divider2("arm_a7_div", "arm_a7_cg", base + 0x8000, 0, 3);
 	clks[IMX7D_ARM_M4_ROOT_DIV] = imx_clk_divider2("arm_m4_div", "arm_m4_cg", base + 0x8080, 0, 3);
-	clks[IMX7D_ARM_M0_ROOT_DIV] = imx_clk_divider2("arm_m0_div", "arm_m0_cg", base + 0x8100, 0, 3);
 	clks[IMX7D_MAIN_AXI_ROOT_DIV] = imx_clk_divider2("axi_post_div", "axi_pre_div", base + 0x8800, 0, 6);
 	clks[IMX7D_DISP_AXI_ROOT_DIV] = imx_clk_divider2("disp_axi_post_div", "disp_axi_pre_div", base + 0x8880, 0, 6);
 	clks[IMX7D_ENET_AXI_ROOT_DIV] = imx_clk_divider2("enet_axi_post_div", "enet_axi_pre_div", base + 0x8900, 0, 6);
@@ -793,7 +785,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 
 	clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate4("arm_a7_root_clk", "arm_a7_div", base + 0x4000, 0);
 	clks[IMX7D_ARM_M4_ROOT_CLK] = imx_clk_gate4("arm_m4_root_clk", "arm_m4_div", base + 0x4010, 0);
-	clks[IMX7D_ARM_M0_ROOT_CLK] = imx_clk_gate4("arm_m0_root_clk", "arm_m0_div", base + 0x4020, 0);
 	clks[IMX7D_MAIN_AXI_ROOT_CLK] = imx_clk_gate4("main_axi_root_clk", "axi_post_div", base + 0x4040, 0);
 	clks[IMX7D_DISP_AXI_ROOT_CLK] = imx_clk_gate4("disp_axi_root_clk", "disp_axi_post_div", base + 0x4050, 0);
 	clks[IMX7D_ENET_AXI_ROOT_CLK] = imx_clk_gate4("enet_axi_root_clk", "enet_axi_post_div", base + 0x4060, 0);
diff --git a/include/dt-bindings/clock/imx7d-clock.h b/include/dt-bindings/clock/imx7d-clock.h
index de62a83..e2f99ae 100644
--- a/include/dt-bindings/clock/imx7d-clock.h
+++ b/include/dt-bindings/clock/imx7d-clock.h
@@ -80,10 +80,10 @@
 #define IMX7D_ARM_M4_ROOT_SRC		67
 #define IMX7D_ARM_M4_ROOT_CG		68
 #define IMX7D_ARM_M4_ROOT_DIV		69
-#define IMX7D_ARM_M0_ROOT_CLK		70
-#define IMX7D_ARM_M0_ROOT_SRC		71
-#define IMX7D_ARM_M0_ROOT_CG		72
-#define IMX7D_ARM_M0_ROOT_DIV		73
+#define IMX7D_ARM_M0_ROOT_CLK		70	/* unused */
+#define IMX7D_ARM_M0_ROOT_SRC		71	/* unused */
+#define IMX7D_ARM_M0_ROOT_CG		72	/* unused */
+#define IMX7D_ARM_M0_ROOT_DIV		73	/* unused */
 #define IMX7D_MAIN_AXI_ROOT_CLK		74
 #define IMX7D_MAIN_AXI_ROOT_SRC		75
 #define IMX7D_MAIN_AXI_ROOT_CG		76
-- 
2.7.4
