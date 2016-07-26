From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 22:30:33 +0200
Subject: [PATCH 05/13] clk: sunxi-ng: sun8i: Rename H3 only clocks
In-Reply-To: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
Message-ID: <20160726203041.29366-6-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a suffix for the H3-only clocks to prepare the introduction of the A64
clocks.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 140 ++++++++++++++++++------------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 3c236eefbb3a..f61d2e245ac4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -111,7 +111,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
 					BIT(28),	/* lock */
 					0);
 
-static SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(pll_periph1_clk, "pll-periph1",
+static SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(pll_periph1_h3_clk, "pll-periph1",
 					   "osc24M", 0x044,
 					   8, 5,	/* N */
 					   4, 2,	/* K */
@@ -175,9 +175,9 @@ static struct clk_div_table apb1_div_table[] = {
 static SUNXI_CCU_DIV_TABLE(apb1_clk, "apb1", "ahb1",
 			   0x054, 8, 2, apb1_div_table, 0);
 
-static const char * const apb2_parents[] = { "osc32k", "osc24M",
-					     "pll-periph0" , "pll-periph0" };
-static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", apb2_parents, 0x058,
+static const char * const apb2_h3_parents[] = { "osc32k", "osc24M",
+						"pll-periph0" , "pll-periph0" };
+static SUNXI_CCU_MP_WITH_MUX(apb2_h3_clk, "apb2", apb2_h3_parents, 0x058,
 			     0, 5,	/* M */
 			     16, 2,	/* P */
 			     24, 2,	/* mux */
@@ -235,17 +235,17 @@ static SUNXI_CCU_GATE(bus_ehci0_clk,	"bus-ehci0",	"ahb1",
 		      0x060, BIT(24), 0);
 static SUNXI_CCU_GATE(bus_ehci1_clk,	"bus-ehci1",	"ahb2",
 		      0x060, BIT(25), 0);
-static SUNXI_CCU_GATE(bus_ehci2_clk,	"bus-ehci2",	"ahb2",
+static SUNXI_CCU_GATE(bus_ehci2_h3_clk,	"bus-ehci2",	"ahb2",
 		      0x060, BIT(26), 0);
-static SUNXI_CCU_GATE(bus_ehci3_clk,	"bus-ehci3",	"ahb2",
+static SUNXI_CCU_GATE(bus_ehci3_h3_clk,	"bus-ehci3",	"ahb2",
 		      0x060, BIT(27), 0);
 static SUNXI_CCU_GATE(bus_ohci0_clk,	"bus-ohci0",	"ahb1",
 		      0x060, BIT(28), 0);
 static SUNXI_CCU_GATE(bus_ohci1_clk,	"bus-ohci1",	"ahb2",
 		      0x060, BIT(29), 0);
-static SUNXI_CCU_GATE(bus_ohci2_clk,	"bus-ohci2",	"ahb2",
+static SUNXI_CCU_GATE(bus_ohci2_h3_clk,	"bus-ohci2",	"ahb2",
 		      0x060, BIT(30), 0);
-static SUNXI_CCU_GATE(bus_ohci3_clk,	"bus-ohci3",	"ahb2",
+static SUNXI_CCU_GATE(bus_ohci3_h3_clk,	"bus-ohci3",	"ahb2",
 		      0x060, BIT(31), 0);
 
 static SUNXI_CCU_GATE(bus_ve_clk,	"bus-ve",	"ahb1",
@@ -258,7 +258,7 @@ static SUNXI_CCU_GATE(bus_deinterlace_clk,	"bus-deinterlace",	"ahb1",
 		      0x064, BIT(5), 0);
 static SUNXI_CCU_GATE(bus_csi_clk,	"bus-csi",	"ahb1",
 		      0x064, BIT(8), 0);
-static SUNXI_CCU_GATE(bus_tve_clk,	"bus-tve",	"ahb1",
+static SUNXI_CCU_GATE(bus_tve_h3_clk,	"bus-tve",	"ahb1",
 		      0x064, BIT(9), 0);
 static SUNXI_CCU_GATE(bus_hdmi_clk,	"bus-hdmi",	"ahb1",
 		      0x064, BIT(11), 0);
@@ -300,10 +300,10 @@ static SUNXI_CCU_GATE(bus_uart2_clk,	"bus-uart2",	"apb2",
 		      0x06c, BIT(18), 0);
 static SUNXI_CCU_GATE(bus_uart3_clk,	"bus-uart3",	"apb2",
 		      0x06c, BIT(19), 0);
-static SUNXI_CCU_GATE(bus_scr_clk,	"bus-scr",	"apb2",
+static SUNXI_CCU_GATE(bus_scr_h3_clk,	"bus-scr",	"apb2",
 		      0x06c, BIT(20), 0);
 
-static SUNXI_CCU_GATE(bus_ephy_clk,	"bus-ephy",	"ahb1",
+static SUNXI_CCU_GATE(bus_ephy_h3_clk,	"bus-ephy",	"ahb1",
 		      0x070, BIT(0), 0);
 static SUNXI_CCU_GATE(bus_dbg_clk,	"bus-dbg",	"ahb1",
 		      0x070, BIT(7), 0);
@@ -326,40 +326,40 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(nand_clk, "nand", mod0_default_parents, 0x080,
 				  BIT(31),	/* gate */
 				  0);
 
-static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_clk, "mmc0", mod0_default_parents, 0x088,
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_h3_clk, "mmc0", mod0_default_parents, 0x088,
 				  0, 4,		/* M */
 				  16, 2,	/* P */
 				  24, 2,	/* mux */
 				  BIT(31),	/* gate */
 				  0);
 
-static SUNXI_CCU_PHASE(mmc0_sample_clk, "mmc0_sample", "mmc0",
+static SUNXI_CCU_PHASE(mmc0_sample_h3_clk, "mmc0_sample", "mmc0",
 		       0x088, 20, 3, 0);
-static SUNXI_CCU_PHASE(mmc0_output_clk, "mmc0_output", "mmc0",
+static SUNXI_CCU_PHASE(mmc0_output_h3_clk, "mmc0_output", "mmc0",
 		       0x088, 8, 3, 0);
 
-static SUNXI_CCU_MP_WITH_MUX_GATE(mmc1_clk, "mmc1", mod0_default_parents, 0x08c,
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc1_h3_clk, "mmc1", mod0_default_parents, 0x08c,
 				  0, 4,		/* M */
 				  16, 2,	/* P */
 				  24, 2,	/* mux */
 				  BIT(31),	/* gate */
 				  0);
 
-static SUNXI_CCU_PHASE(mmc1_sample_clk, "mmc1_sample", "mmc1",
+static SUNXI_CCU_PHASE(mmc1_sample_h3_clk, "mmc1_sample", "mmc1",
 		       0x08c, 20, 3, 0);
-static SUNXI_CCU_PHASE(mmc1_output_clk, "mmc1_output", "mmc1",
+static SUNXI_CCU_PHASE(mmc1_output_h3_clk, "mmc1_output", "mmc1",
 		       0x08c, 8, 3, 0);
 
-static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mod0_default_parents, 0x090,
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_h3_clk, "mmc2", mod0_default_parents, 0x090,
 				  0, 4,		/* M */
 				  16, 2,	/* P */
 				  24, 2,	/* mux */
 				  BIT(31),	/* gate */
 				  0);
 
-static SUNXI_CCU_PHASE(mmc2_sample_clk, "mmc2_sample", "mmc2",
+static SUNXI_CCU_PHASE(mmc2_sample_h3_clk, "mmc2_sample", "mmc2",
 		       0x090, 20, 3, 0);
-static SUNXI_CCU_PHASE(mmc2_output_clk, "mmc2_output", "mmc2",
+static SUNXI_CCU_PHASE(mmc2_output_h3_clk, "mmc2_output", "mmc2",
 		       0x090, 8, 3, 0);
 
 static const char * const ts_parents[] = { "osc24M", "pll-periph0", };
@@ -370,7 +370,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(ts_clk, "ts", ts_parents, 0x098,
 				  BIT(31),	/* gate */
 				  0);
 
-static SUNXI_CCU_MP_WITH_MUX_GATE(ce_clk, "ce", mod0_default_parents, 0x09c,
+static SUNXI_CCU_MP_WITH_MUX_GATE(ce_h3_clk, "ce", mod0_default_parents, 0x09c,
 				  0, 4,		/* M */
 				  16, 2,	/* P */
 				  24, 2,	/* mux */
@@ -409,21 +409,21 @@ static SUNXI_CCU_GATE(usb_phy0_clk,	"usb-phy0",	"osc24M",
 		      0x0cc, BIT(8), 0);
 static SUNXI_CCU_GATE(usb_phy1_clk,	"usb-phy1",	"osc24M",
 		      0x0cc, BIT(9), 0);
-static SUNXI_CCU_GATE(usb_phy2_clk,	"usb-phy2",	"osc24M",
+static SUNXI_CCU_GATE(usb_phy2_h3_clk,	"usb-phy2",	"osc24M",
 		      0x0cc, BIT(10), 0);
-static SUNXI_CCU_GATE(usb_phy3_clk,	"usb-phy3",	"osc24M",
+static SUNXI_CCU_GATE(usb_phy3_h3_clk,	"usb-phy3",	"osc24M",
 		      0x0cc, BIT(11), 0);
-static SUNXI_CCU_GATE(usb_ohci0_clk,	"usb-ohci0",	"osc24M",
+static SUNXI_CCU_GATE(usb_ohci0_h3_clk,	"usb-ohci0",	"osc24M",
 		      0x0cc, BIT(16), 0);
-static SUNXI_CCU_GATE(usb_ohci1_clk,	"usb-ohci1",	"osc24M",
+static SUNXI_CCU_GATE(usb_ohci1_h3_clk,	"usb-ohci1",	"osc24M",
 		      0x0cc, BIT(17), 0);
-static SUNXI_CCU_GATE(usb_ohci2_clk,	"usb-ohci2",	"osc24M",
+static SUNXI_CCU_GATE(usb_ohci2_h3_clk,	"usb-ohci2",	"osc24M",
 		      0x0cc, BIT(18), 0);
-static SUNXI_CCU_GATE(usb_ohci3_clk,	"usb-ohci3",	"osc24M",
+static SUNXI_CCU_GATE(usb_ohci3_h3_clk,	"usb-ohci3",	"osc24M",
 		      0x0cc, BIT(19), 0);
 
-static const char * const dram_parents[] = { "pll-ddr0", "pll-periph0-2x" };
-static SUNXI_CCU_M_WITH_MUX(dram_clk, "dram", dram_parents,
+static const char * const dram_h3_parents[] = { "pll-ddr0", "pll-periph0-2x" };
+static SUNXI_CCU_M_WITH_MUX(dram_h3_clk, "dram", dram_h3_parents,
 			    0x0f4, 0, 4, 20, 2, CLK_IS_CRITICAL);
 
 static SUNXI_CCU_GATE(dram_ve_clk,	"dram-ve",	"dram",
@@ -439,12 +439,12 @@ static const char * const de_parents[] = { "pll-periph0-2x", "pll-de" };
 static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
 				 0x104, 0, 4, 24, 3, BIT(31), 0);
 
-static const char * const tcon_parents[] = { "pll-video0" };
-static SUNXI_CCU_M_WITH_MUX_GATE(tcon_clk, "tcon", tcon_parents,
+static const char * const tcon0_h3_parents[] = { "pll-video0" };
+static SUNXI_CCU_M_WITH_MUX_GATE(tcon0_h3_clk, "tcon0", tcon0_h3_parents,
 				 0x118, 0, 4, 24, 3, BIT(31), 0);
 
-static const char * const tve_parents[] = { "pll-de", "pll-periph1" };
-static SUNXI_CCU_M_WITH_MUX_GATE(tve_clk, "tve", tve_parents,
+static const char * const tve_h3_parents[] = { "pll-de", "pll-periph1" };
+static SUNXI_CCU_M_WITH_MUX_GATE(tve_h3_clk, "tve", tve_h3_parents,
 				 0x120, 0, 4, 24, 3, BIT(31), 0);
 
 static const char * const deinterlace_parents[] = { "pll-periph0", "pll-periph1" };
@@ -458,8 +458,8 @@ static const char * const csi_sclk_parents[] = { "pll-periph0", "pll-periph1" };
 static SUNXI_CCU_M_WITH_MUX_GATE(csi_sclk_clk, "csi-sclk", csi_sclk_parents,
 				 0x134, 16, 4, 24, 3, BIT(31), 0);
 
-static const char * const csi_mclk_parents[] = { "osc24M", "pll-video0", "pll-periph0" };
-static SUNXI_CCU_M_WITH_MUX_GATE(csi_mclk_clk, "csi-mclk", csi_mclk_parents,
+static const char * const csi_mclk_h3_parents[] = { "osc24M", "pll-video0", "pll-periph0" };
+static SUNXI_CCU_M_WITH_MUX_GATE(csi_mclk_h3_clk, "csi-mclk", csi_mclk_h3_parents,
 				 0x134, 0, 5, 8, 3, BIT(15), 0);
 
 static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
@@ -470,15 +470,15 @@ static SUNXI_CCU_GATE(ac_dig_clk,	"ac-dig",	"pll-audio",
 static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
 		      0x144, BIT(31), 0);
 
-static const char * const hdmi_parents[] = { "pll-video0" };
-static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents,
+static const char * const hdmi_h3_parents[] = { "pll-video0" };
+static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_h3_clk, "hdmi", hdmi_h3_parents,
 				 0x150, 0, 4, 24, 2, BIT(31), 0);
 
 static SUNXI_CCU_GATE(hdmi_ddc_clk,	"hdmi-ddc",	"osc24M",
 		      0x154, BIT(31), 0);
 
-static const char * const mbus_parents[] = { "osc24M", "pll-periph0-2x", "pll-ddr0" };
-static SUNXI_CCU_M_WITH_MUX_GATE(mbus_clk, "mbus", mbus_parents,
+static const char * const mbus_h3_parents[] = { "osc24M", "pll-periph0-2x", "pll-ddr0" };
+static SUNXI_CCU_M_WITH_MUX_GATE(mbus_h3_clk, "mbus", mbus_h3_parents,
 				 0x15c, 0, 3, 24, 2, BIT(31), CLK_IS_CRITICAL);
 
 static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
@@ -492,13 +492,13 @@ static struct ccu_common *sun8i_h3_ccu_clks[] = {
 	&pll_ddr0_clk.common,
 	&pll_periph0_clk.common,
 	&pll_gpu_clk.common,
-	&pll_periph1_clk.common,
+	&pll_periph1_h3_clk.common,
 	&pll_de_clk.common,
 	&cpux_clk.common,
 	&axi_clk.common,
 	&ahb1_clk.common,
 	&apb1_clk.common,
-	&apb2_clk.common,
+	&apb2_h3_clk.common,
 	&ahb2_clk.common,
 	&bus_ce_clk.common,
 	&bus_dma_clk.common,
@@ -515,18 +515,18 @@ static struct ccu_common *sun8i_h3_ccu_clks[] = {
 	&bus_otg_clk.common,
 	&bus_ehci0_clk.common,
 	&bus_ehci1_clk.common,
-	&bus_ehci2_clk.common,
-	&bus_ehci3_clk.common,
+	&bus_ehci2_h3_clk.common,
+	&bus_ehci3_h3_clk.common,
 	&bus_ohci0_clk.common,
 	&bus_ohci1_clk.common,
-	&bus_ohci2_clk.common,
-	&bus_ohci3_clk.common,
+	&bus_ohci2_h3_clk.common,
+	&bus_ohci3_h3_clk.common,
 	&bus_ve_clk.common,
 	&bus_tcon0_clk.common,
 	&bus_tcon1_clk.common,
 	&bus_deinterlace_clk.common,
 	&bus_csi_clk.common,
-	&bus_tve_clk.common,
+	&bus_tve_h3_clk.common,
 	&bus_hdmi_clk.common,
 	&bus_de_clk.common,
 	&bus_gpu_clk.common,
@@ -546,22 +546,22 @@ static struct ccu_common *sun8i_h3_ccu_clks[] = {
 	&bus_uart1_clk.common,
 	&bus_uart2_clk.common,
 	&bus_uart3_clk.common,
-	&bus_scr_clk.common,
-	&bus_ephy_clk.common,
+	&bus_scr_h3_clk.common,
+	&bus_ephy_h3_clk.common,
 	&bus_dbg_clk.common,
 	&ths_clk.common,
 	&nand_clk.common,
-	&mmc0_clk.common,
-	&mmc0_sample_clk.common,
-	&mmc0_output_clk.common,
-	&mmc1_clk.common,
-	&mmc1_sample_clk.common,
-	&mmc1_output_clk.common,
-	&mmc2_clk.common,
-	&mmc2_sample_clk.common,
-	&mmc2_output_clk.common,
+	&mmc0_h3_clk.common,
+	&mmc0_sample_h3_clk.common,
+	&mmc0_output_h3_clk.common,
+	&mmc1_h3_clk.common,
+	&mmc1_sample_h3_clk.common,
+	&mmc1_output_h3_clk.common,
+	&mmc2_h3_clk.common,
+	&mmc2_sample_h3_clk.common,
+	&mmc2_output_h3_clk.common,
 	&ts_clk.common,
-	&ce_clk.common,
+	&ce_h3_clk.common,
 	&spi0_clk.common,
 	&spi1_clk.common,
 	&i2s0_clk.common,
@@ -570,30 +570,30 @@ static struct ccu_common *sun8i_h3_ccu_clks[] = {
 	&spdif_clk.common,
 	&usb_phy0_clk.common,
 	&usb_phy1_clk.common,
-	&usb_phy2_clk.common,
-	&usb_phy3_clk.common,
-	&usb_ohci0_clk.common,
-	&usb_ohci1_clk.common,
-	&usb_ohci2_clk.common,
-	&usb_ohci3_clk.common,
-	&dram_clk.common,
+	&usb_phy2_h3_clk.common,
+	&usb_phy3_h3_clk.common,
+	&usb_ohci0_h3_clk.common,
+	&usb_ohci1_h3_clk.common,
+	&usb_ohci2_h3_clk.common,
+	&usb_ohci3_h3_clk.common,
+	&dram_h3_clk.common,
 	&dram_ve_clk.common,
 	&dram_csi_clk.common,
 	&dram_deinterlace_clk.common,
 	&dram_ts_clk.common,
 	&de_clk.common,
-	&tcon_clk.common,
-	&tve_clk.common,
+	&tcon0_h3_clk.common,
+	&tve_h3_clk.common,
 	&deinterlace_clk.common,
 	&csi_misc_clk.common,
 	&csi_sclk_clk.common,
-	&csi_mclk_clk.common,
+	&csi_mclk_h3_clk.common,
 	&ve_clk.common,
 	&ac_dig_clk.common,
 	&avs_clk.common,
-	&hdmi_clk.common,
+	&hdmi_h3_clk.common,
 	&hdmi_ddc_clk.common,
-	&mbus_clk.common,
+	&mbus_h3_clk.common,
 	&gpu_clk.common,
 };
 
-- 
2.9.2
