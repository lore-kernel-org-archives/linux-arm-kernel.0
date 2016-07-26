From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 22:30:35 +0200
Subject: [PATCH 07/13] clk: sunxi-ng: sun8i: Prefix clock defines by SoC Name
In-Reply-To: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
Message-ID: <20160726203041.29366-8-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the A64 and H3 have a slightly different clock set, they will have
different opaque clock numbers set as well. Make that obvious by using the
SoC name in the defines.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi          |  62 ++++-----
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c      | 232 +++++++++++++++----------------
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h      |  44 +++---
 include/dt-bindings/clock/sun8i-h3-ccu.h | 188 ++++++++++++-------------
 4 files changed, 263 insertions(+), 263 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 9871bad34742..0e7005865e20 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -144,7 +144,7 @@
 			compatible = "allwinner,sun8i-h3-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_DMA>;
+			clocks = <&ccu CLK_H3_BUS_DMA>;
 			resets = <&ccu RST_BUS_DMA>;
 			#dma-cells = <1>;
 		};
@@ -152,10 +152,10 @@
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ccu CLK_BUS_MMC0>,
-				 <&ccu CLK_MMC0>,
-				 <&ccu CLK_MMC0_OUTPUT>,
-				 <&ccu CLK_MMC0_SAMPLE>;
+			clocks = <&ccu CLK_H3_BUS_MMC0>,
+				 <&ccu CLK_H3_MMC0>,
+				 <&ccu CLK_H3_MMC0_OUTPUT>,
+				 <&ccu CLK_H3_MMC0_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
@@ -171,10 +171,10 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ccu CLK_BUS_MMC1>,
-				 <&ccu CLK_MMC1>,
-				 <&ccu CLK_MMC1_OUTPUT>,
-				 <&ccu CLK_MMC1_SAMPLE>;
+			clocks = <&ccu CLK_H3_BUS_MMC1>,
+				 <&ccu CLK_H3_MMC1>,
+				 <&ccu CLK_H3_MMC1_OUTPUT>,
+				 <&ccu CLK_H3_MMC1_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
@@ -190,10 +190,10 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ccu CLK_BUS_MMC2>,
-				 <&ccu CLK_MMC2>,
-				 <&ccu CLK_MMC2_OUTPUT>,
-				 <&ccu CLK_MMC2_SAMPLE>;
+			clocks = <&ccu CLK_H3_BUS_MMC2>,
+				 <&ccu CLK_H3_MMC2>,
+				 <&ccu CLK_H3_MMC2_OUTPUT>,
+				 <&ccu CLK_H3_MMC2_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
@@ -218,10 +218,10 @@
 				    "pmu1",
 				    "pmu2",
 				    "pmu3";
-			clocks = <&ccu CLK_USB_PHY0>,
-				 <&ccu CLK_USB_PHY1>,
-				 <&ccu CLK_USB_PHY2>,
-				 <&ccu CLK_USB_PHY3>;
+			clocks = <&ccu CLK_H3_USB_PHY0>,
+				 <&ccu CLK_H3_USB_PHY1>,
+				 <&ccu CLK_H3_USB_PHY2>,
+				 <&ccu CLK_H3_USB_PHY3>;
 			clock-names = "usb0_phy",
 				      "usb1_phy",
 				      "usb2_phy",
@@ -242,7 +242,7 @@
 			compatible = "allwinner,sun8i-h3-ehci", "generic-ehci";
 			reg = <0x01c1b000 0x100>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_EHCI1>, <&ccu CLK_BUS_OHCI1>;
+			clocks = <&ccu CLK_H3_BUS_EHCI1>, <&ccu CLK_H3_BUS_OHCI1>;
 			resets = <&ccu RST_BUS_EHCI1>, <&ccu RST_BUS_OHCI1>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
@@ -253,8 +253,8 @@
 			compatible = "allwinner,sun8i-h3-ohci", "generic-ohci";
 			reg = <0x01c1b400 0x100>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_EHCI1>, <&ccu CLK_BUS_OHCI1>,
-				 <&ccu CLK_USB_OHCI1>;
+			clocks = <&ccu CLK_H3_BUS_EHCI1>, <&ccu CLK_H3_BUS_OHCI1>,
+				 <&ccu CLK_H3_USB_OHCI1>;
 			resets = <&ccu RST_BUS_EHCI1>, <&ccu RST_BUS_OHCI1>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
@@ -265,7 +265,7 @@
 			compatible = "allwinner,sun8i-h3-ehci", "generic-ehci";
 			reg = <0x01c1c000 0x100>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_EHCI2>, <&ccu CLK_BUS_OHCI2>;
+			clocks = <&ccu CLK_H3_BUS_EHCI2>, <&ccu CLK_H3_BUS_OHCI2>;
 			resets = <&ccu RST_BUS_EHCI2>, <&ccu RST_BUS_OHCI2>;
 			phys = <&usbphy 2>;
 			phy-names = "usb";
@@ -276,8 +276,8 @@
 			compatible = "allwinner,sun8i-h3-ohci", "generic-ohci";
 			reg = <0x01c1c400 0x100>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_EHCI2>, <&ccu CLK_BUS_OHCI2>,
-				 <&ccu CLK_USB_OHCI2>;
+			clocks = <&ccu CLK_H3_BUS_EHCI2>, <&ccu CLK_H3_BUS_OHCI2>,
+				 <&ccu CLK_H3_USB_OHCI2>;
 			resets = <&ccu RST_BUS_EHCI2>, <&ccu RST_BUS_OHCI2>;
 			phys = <&usbphy 2>;
 			phy-names = "usb";
@@ -288,7 +288,7 @@
 			compatible = "allwinner,sun8i-h3-ehci", "generic-ehci";
 			reg = <0x01c1d000 0x100>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_EHCI3>, <&ccu CLK_BUS_OHCI3>;
+			clocks = <&ccu CLK_H3_BUS_EHCI3>, <&ccu CLK_H3_BUS_OHCI3>;
 			resets = <&ccu RST_BUS_EHCI3>, <&ccu RST_BUS_OHCI3>;
 			phys = <&usbphy 3>;
 			phy-names = "usb";
@@ -299,8 +299,8 @@
 			compatible = "allwinner,sun8i-h3-ohci", "generic-ohci";
 			reg = <0x01c1d400 0x100>;
 			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_EHCI3>, <&ccu CLK_BUS_OHCI3>,
-				 <&ccu CLK_USB_OHCI3>;
+			clocks = <&ccu CLK_H3_BUS_EHCI3>, <&ccu CLK_H3_BUS_OHCI3>,
+				 <&ccu CLK_H3_USB_OHCI3>;
 			resets = <&ccu RST_BUS_EHCI3>, <&ccu RST_BUS_OHCI3>;
 			phys = <&usbphy 3>;
 			phy-names = "usb";
@@ -321,7 +321,7 @@
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_PIO>;
+			clocks = <&ccu CLK_H3_BUS_PIO>;
 			gpio-controller;
 			#gpio-cells = <3>;
 			interrupt-controller;
@@ -388,7 +388,7 @@
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART0>;
+			clocks = <&ccu CLK_H3_BUS_UART0>;
 			resets = <&ccu RST_BUS_UART0>;
 			dmas = <&dma 6>, <&dma 6>;
 			dma-names = "rx", "tx";
@@ -401,7 +401,7 @@
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART1>;
+			clocks = <&ccu CLK_H3_BUS_UART1>;
 			resets = <&ccu RST_BUS_UART1>;
 			dmas = <&dma 7>, <&dma 7>;
 			dma-names = "rx", "tx";
@@ -414,7 +414,7 @@
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART2>;
+			clocks = <&ccu CLK_H3_BUS_UART2>;
 			resets = <&ccu RST_BUS_UART2>;
 			dmas = <&dma 8>, <&dma 8>;
 			dma-names = "rx", "tx";
@@ -427,7 +427,7 @@
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART3>;
+			clocks = <&ccu CLK_H3_BUS_UART3>;
 			resets = <&ccu RST_BUS_UART3>;
 			dmas = <&dma 9>, <&dma 9>;
 			dma-names = "rx", "tx";
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index ec8c67201e8e..2e91f43937c8 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -612,123 +612,123 @@ static struct ccu_common *sun8i_h3_ccu_clks[] = {
 
 static struct clk_hw_onecell_data sun8i_h3_hw_clks = {
 	.hws	= {
-		[CLK_PLL_CPUX]		= &pll_cpux_clk.common.hw,
-		[CLK_PLL_AUDIO_BASE]	= &pll_audio_base_clk.common.hw,
-		[CLK_PLL_AUDIO]		= &pll_audio_clk.hw,
-		[CLK_PLL_AUDIO_2X]	= &pll_audio_2x_clk.hw,
-		[CLK_PLL_AUDIO_4X]	= &pll_audio_4x_clk.hw,
-		[CLK_PLL_AUDIO_8X]	= &pll_audio_8x_clk.hw,
-		[CLK_PLL_VIDEO]		= &pll_video_clk.common.hw,
-		[CLK_PLL_VE]		= &pll_ve_clk.common.hw,
-		[CLK_PLL_DDR]		= &pll_ddr_clk.common.hw,
-		[CLK_PLL_PERIPH0]	= &pll_periph0_clk.common.hw,
-		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.hw,
-		[CLK_PLL_GPU]		= &pll_gpu_clk.common.hw,
-		[CLK_PLL_PERIPH1]	= &pll_periph1_clk.common.hw,
-		[CLK_PLL_DE]		= &pll_de_clk.common.hw,
-		[CLK_CPUX]		= &cpux_clk.common.hw,
-		[CLK_AXI]		= &axi_clk.common.hw,
-		[CLK_AHB1]		= &ahb1_clk.common.hw,
-		[CLK_APB1]		= &apb1_clk.common.hw,
-		[CLK_APB2]		= &apb2_clk.common.hw,
-		[CLK_AHB2]		= &ahb2_clk.common.hw,
-		[CLK_BUS_CE]		= &bus_ce_clk.common.hw,
-		[CLK_BUS_DMA]		= &bus_dma_clk.common.hw,
-		[CLK_BUS_MMC0]		= &bus_mmc0_clk.common.hw,
-		[CLK_BUS_MMC1]		= &bus_mmc1_clk.common.hw,
-		[CLK_BUS_MMC2]		= &bus_mmc2_clk.common.hw,
-		[CLK_BUS_NAND]		= &bus_nand_clk.common.hw,
-		[CLK_BUS_DRAM]		= &bus_dram_clk.common.hw,
-		[CLK_BUS_EMAC]		= &bus_emac_clk.common.hw,
-		[CLK_BUS_TS]		= &bus_ts_clk.common.hw,
-		[CLK_BUS_HSTIMER]	= &bus_hstimer_clk.common.hw,
-		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
-		[CLK_BUS_SPI1]		= &bus_spi1_clk.common.hw,
-		[CLK_BUS_OTG]		= &bus_otg_clk.common.hw,
-		[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common.hw,
-		[CLK_BUS_EHCI1]		= &bus_ehci1_clk.common.hw,
-		[CLK_BUS_EHCI2]		= &bus_ehci2_clk.common.hw,
-		[CLK_BUS_EHCI3]		= &bus_ehci3_clk.common.hw,
-		[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common.hw,
-		[CLK_BUS_OHCI1]		= &bus_ohci1_clk.common.hw,
-		[CLK_BUS_OHCI2]		= &bus_ohci2_clk.common.hw,
-		[CLK_BUS_OHCI3]		= &bus_ohci3_clk.common.hw,
-		[CLK_BUS_VE]		= &bus_ve_clk.common.hw,
-		[CLK_BUS_TCON0]		= &bus_tcon0_clk.common.hw,
-		[CLK_BUS_TCON1]		= &bus_tcon1_clk.common.hw,
-		[CLK_BUS_DEINTERLACE]	= &bus_deinterlace_clk.common.hw,
-		[CLK_BUS_CSI]		= &bus_csi_clk.common.hw,
-		[CLK_BUS_TVE]		= &bus_tve_clk.common.hw,
-		[CLK_BUS_HDMI]		= &bus_hdmi_clk.common.hw,
-		[CLK_BUS_DE]		= &bus_de_clk.common.hw,
-		[CLK_BUS_GPU]		= &bus_gpu_clk.common.hw,
-		[CLK_BUS_MSGBOX]	= &bus_msgbox_clk.common.hw,
-		[CLK_BUS_SPINLOCK]	= &bus_spinlock_clk.common.hw,
-		[CLK_BUS_CODEC]		= &bus_codec_clk.common.hw,
-		[CLK_BUS_SPDIF]		= &bus_spdif_clk.common.hw,
-		[CLK_BUS_PIO]		= &bus_pio_clk.common.hw,
-		[CLK_BUS_THS]		= &bus_ths_clk.common.hw,
-		[CLK_BUS_I2S0]		= &bus_i2s0_clk.common.hw,
-		[CLK_BUS_I2S1]		= &bus_i2s1_clk.common.hw,
-		[CLK_BUS_I2S2]		= &bus_i2s2_clk.common.hw,
-		[CLK_BUS_I2C0]		= &bus_i2c0_clk.common.hw,
-		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
-		[CLK_BUS_I2C2]		= &bus_i2c2_clk.common.hw,
-		[CLK_BUS_UART0]		= &bus_uart0_clk.common.hw,
-		[CLK_BUS_UART1]		= &bus_uart1_clk.common.hw,
-		[CLK_BUS_UART2]		= &bus_uart2_clk.common.hw,
-		[CLK_BUS_UART3]		= &bus_uart3_clk.common.hw,
-		[CLK_BUS_SCR]		= &bus_scr_clk.common.hw,
-		[CLK_BUS_EPHY]		= &bus_ephy_clk.common.hw,
-		[CLK_BUS_DBG]		= &bus_dbg_clk.common.hw,
-		[CLK_THS]		= &ths_clk.common.hw,
-		[CLK_NAND]		= &nand_clk.common.hw,
-		[CLK_MMC0]		= &mmc0_clk.common.hw,
-		[CLK_MMC0_SAMPLE]	= &mmc0_sample_clk.common.hw,
-		[CLK_MMC0_OUTPUT]	= &mmc0_output_clk.common.hw,
-		[CLK_MMC1]		= &mmc1_clk.common.hw,
-		[CLK_MMC1_SAMPLE]	= &mmc1_sample_clk.common.hw,
-		[CLK_MMC1_OUTPUT]	= &mmc1_output_clk.common.hw,
-		[CLK_MMC2]		= &mmc2_clk.common.hw,
-		[CLK_MMC2_SAMPLE]	= &mmc2_sample_clk.common.hw,
-		[CLK_MMC2_OUTPUT]	= &mmc2_output_clk.common.hw,
-		[CLK_TS]		= &ts_clk.common.hw,
-		[CLK_CE]		= &ce_clk.common.hw,
-		[CLK_SPI0]		= &spi0_clk.common.hw,
-		[CLK_SPI1]		= &spi1_clk.common.hw,
-		[CLK_I2S0]		= &i2s0_clk.common.hw,
-		[CLK_I2S1]		= &i2s1_clk.common.hw,
-		[CLK_I2S2]		= &i2s2_clk.common.hw,
-		[CLK_SPDIF]		= &spdif_clk.common.hw,
-		[CLK_USB_PHY0]		= &usb_phy0_clk.common.hw,
-		[CLK_USB_PHY1]		= &usb_phy1_clk.common.hw,
-		[CLK_USB_PHY2]		= &usb_phy2_clk.common.hw,
-		[CLK_USB_PHY3]		= &usb_phy3_clk.common.hw,
-		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
-		[CLK_USB_OHCI1]		= &usb_ohci1_clk.common.hw,
-		[CLK_USB_OHCI2]		= &usb_ohci2_clk.common.hw,
-		[CLK_USB_OHCI3]		= &usb_ohci3_clk.common.hw,
-		[CLK_DRAM]		= &dram_clk.common.hw,
-		[CLK_DRAM_VE]		= &dram_ve_clk.common.hw,
-		[CLK_DRAM_CSI]		= &dram_csi_clk.common.hw,
-		[CLK_DRAM_DEINTERLACE]	= &dram_deinterlace_clk.common.hw,
-		[CLK_DRAM_TS]		= &dram_ts_clk.common.hw,
-		[CLK_DE]		= &de_clk.common.hw,
-		[CLK_TCON0]		= &tcon_clk.common.hw,
-		[CLK_TVE]		= &tve_clk.common.hw,
-		[CLK_DEINTERLACE]	= &deinterlace_clk.common.hw,
-		[CLK_CSI_MISC]		= &csi_misc_clk.common.hw,
-		[CLK_CSI_SCLK]		= &csi_sclk_clk.common.hw,
-		[CLK_CSI_MCLK]		= &csi_mclk_clk.common.hw,
-		[CLK_VE]		= &ve_clk.common.hw,
-		[CLK_AC_DIG]		= &ac_dig_clk.common.hw,
-		[CLK_AVS]		= &avs_clk.common.hw,
-		[CLK_HDMI]		= &hdmi_clk.common.hw,
-		[CLK_HDMI_DDC]		= &hdmi_ddc_clk.common.hw,
-		[CLK_MBUS]		= &mbus_clk.common.hw,
-		[CLK_GPU]		= &gpu_clk.common.hw,
+		[CLK_H3_PLL_CPUX]	= &pll_cpux_clk.common.hw,
+		[CLK_H3_PLL_AUDIO_BASE]	= &pll_audio_base_clk.common.hw,
+		[CLK_H3_PLL_AUDIO]	= &pll_audio_clk.hw,
+		[CLK_H3_PLL_AUDIO_2X]	= &pll_audio_2x_clk.hw,
+		[CLK_H3_PLL_AUDIO_4X]	= &pll_audio_4x_clk.hw,
+		[CLK_H3_PLL_AUDIO_8X]	= &pll_audio_8x_clk.hw,
+		[CLK_H3_PLL_VIDEO]	= &pll_video0_clk.common.hw,
+		[CLK_H3_PLL_VE]		= &pll_ve_clk.common.hw,
+		[CLK_H3_PLL_DDR]	= &pll_ddr0_clk.common.hw,
+		[CLK_H3_PLL_PERIPH0]	= &pll_periph0_clk.common.hw,
+		[CLK_H3_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.hw,
+		[CLK_H3_PLL_GPU]	= &pll_gpu_clk.common.hw,
+		[CLK_H3_PLL_PERIPH1]	= &pll_periph1_h3_clk.common.hw,
+		[CLK_H3_PLL_DE]		= &pll_de_clk.common.hw,
+		[CLK_H3_CPUX]		= &cpux_clk.common.hw,
+		[CLK_H3_AXI]		= &axi_clk.common.hw,
+		[CLK_H3_AHB1]		= &ahb1_clk.common.hw,
+		[CLK_H3_APB1]		= &apb1_clk.common.hw,
+		[CLK_H3_APB2]		= &apb2_h3_clk.common.hw,
+		[CLK_H3_AHB2]		= &ahb2_clk.common.hw,
+		[CLK_H3_BUS_CE]		= &bus_ce_clk.common.hw,
+		[CLK_H3_BUS_DMA]	= &bus_dma_clk.common.hw,
+		[CLK_H3_BUS_MMC0]	= &bus_mmc0_clk.common.hw,
+		[CLK_H3_BUS_MMC1]	= &bus_mmc1_clk.common.hw,
+		[CLK_H3_BUS_MMC2]	= &bus_mmc2_clk.common.hw,
+		[CLK_H3_BUS_NAND]	= &bus_nand_clk.common.hw,
+		[CLK_H3_BUS_DRAM]	= &bus_dram_clk.common.hw,
+		[CLK_H3_BUS_EMAC]	= &bus_emac_clk.common.hw,
+		[CLK_H3_BUS_TS]		= &bus_ts_clk.common.hw,
+		[CLK_H3_BUS_HSTIMER]	= &bus_hstimer_clk.common.hw,
+		[CLK_H3_BUS_SPI0]	= &bus_spi0_clk.common.hw,
+		[CLK_H3_BUS_SPI1]	= &bus_spi1_clk.common.hw,
+		[CLK_H3_BUS_OTG]	= &bus_otg_clk.common.hw,
+		[CLK_H3_BUS_EHCI0]	= &bus_ehci0_clk.common.hw,
+		[CLK_H3_BUS_EHCI1]	= &bus_ehci1_clk.common.hw,
+		[CLK_H3_BUS_EHCI2]	= &bus_ehci2_h3_clk.common.hw,
+		[CLK_H3_BUS_EHCI3]	= &bus_ehci3_h3_clk.common.hw,
+		[CLK_H3_BUS_OHCI0]	= &bus_ohci0_clk.common.hw,
+		[CLK_H3_BUS_OHCI1]	= &bus_ohci1_clk.common.hw,
+		[CLK_H3_BUS_OHCI2]	= &bus_ohci2_h3_clk.common.hw,
+		[CLK_H3_BUS_OHCI3]	= &bus_ohci3_h3_clk.common.hw,
+		[CLK_H3_BUS_VE]		= &bus_ve_clk.common.hw,
+		[CLK_H3_BUS_TCON0]	= &bus_tcon0_clk.common.hw,
+		[CLK_H3_BUS_TCON1]	= &bus_tcon1_clk.common.hw,
+		[CLK_H3_BUS_DEINTERLACE]	= &bus_deinterlace_clk.common.hw,
+		[CLK_H3_BUS_CSI]	= &bus_csi_clk.common.hw,
+		[CLK_H3_BUS_TVE]	= &bus_tve_h3_clk.common.hw,
+		[CLK_H3_BUS_HDMI]	= &bus_hdmi_clk.common.hw,
+		[CLK_H3_BUS_DE]		= &bus_de_clk.common.hw,
+		[CLK_H3_BUS_GPU]	= &bus_gpu_clk.common.hw,
+		[CLK_H3_BUS_MSGBOX]	= &bus_msgbox_clk.common.hw,
+		[CLK_H3_BUS_SPINLOCK]	= &bus_spinlock_clk.common.hw,
+		[CLK_H3_BUS_CODEC]	= &bus_codec_clk.common.hw,
+		[CLK_H3_BUS_SPDIF]	= &bus_spdif_clk.common.hw,
+		[CLK_H3_BUS_PIO]	= &bus_pio_clk.common.hw,
+		[CLK_H3_BUS_THS]	= &bus_ths_clk.common.hw,
+		[CLK_H3_BUS_I2S0]	= &bus_i2s0_clk.common.hw,
+		[CLK_H3_BUS_I2S1]	= &bus_i2s1_clk.common.hw,
+		[CLK_H3_BUS_I2S2]	= &bus_i2s2_clk.common.hw,
+		[CLK_H3_BUS_I2C0]	= &bus_i2c0_clk.common.hw,
+		[CLK_H3_BUS_I2C1]	= &bus_i2c1_clk.common.hw,
+		[CLK_H3_BUS_I2C2]	= &bus_i2c2_clk.common.hw,
+		[CLK_H3_BUS_UART0]	= &bus_uart0_clk.common.hw,
+		[CLK_H3_BUS_UART1]	= &bus_uart1_clk.common.hw,
+		[CLK_H3_BUS_UART2]	= &bus_uart2_clk.common.hw,
+		[CLK_H3_BUS_UART3]	= &bus_uart3_clk.common.hw,
+		[CLK_H3_BUS_SCR]	= &bus_scr_h3_clk.common.hw,
+		[CLK_H3_BUS_EPHY]	= &bus_ephy_h3_clk.common.hw,
+		[CLK_H3_BUS_DBG]	= &bus_dbg_clk.common.hw,
+		[CLK_H3_THS]		= &ths_clk.common.hw,
+		[CLK_H3_NAND]		= &nand_clk.common.hw,
+		[CLK_H3_MMC0]		= &mmc0_h3_clk.common.hw,
+		[CLK_H3_MMC0_SAMPLE]	= &mmc0_sample_h3_clk.common.hw,
+		[CLK_H3_MMC0_OUTPUT]	= &mmc0_output_h3_clk.common.hw,
+		[CLK_H3_MMC1]		= &mmc1_h3_clk.common.hw,
+		[CLK_H3_MMC1_SAMPLE]	= &mmc1_sample_h3_clk.common.hw,
+		[CLK_H3_MMC1_OUTPUT]	= &mmc1_output_h3_clk.common.hw,
+		[CLK_H3_MMC2]		= &mmc2_h3_clk.common.hw,
+		[CLK_H3_MMC2_SAMPLE]	= &mmc2_sample_h3_clk.common.hw,
+		[CLK_H3_MMC2_OUTPUT]	= &mmc2_output_h3_clk.common.hw,
+		[CLK_H3_TS]		= &ts_clk.common.hw,
+		[CLK_H3_CE]		= &ce_h3_clk.common.hw,
+		[CLK_H3_SPI0]		= &spi0_clk.common.hw,
+		[CLK_H3_SPI1]		= &spi1_clk.common.hw,
+		[CLK_H3_I2S0]		= &i2s0_clk.common.hw,
+		[CLK_H3_I2S1]		= &i2s1_clk.common.hw,
+		[CLK_H3_I2S2]		= &i2s2_clk.common.hw,
+		[CLK_H3_SPDIF]		= &spdif_clk.common.hw,
+		[CLK_H3_USB_PHY0]	= &usb_phy0_clk.common.hw,
+		[CLK_H3_USB_PHY1]	= &usb_phy1_clk.common.hw,
+		[CLK_H3_USB_PHY2]	= &usb_phy2_h3_clk.common.hw,
+		[CLK_H3_USB_PHY3]	= &usb_phy3_h3_clk.common.hw,
+		[CLK_H3_USB_OHCI0]	= &usb_ohci0_h3_clk.common.hw,
+		[CLK_H3_USB_OHCI1]	= &usb_ohci1_h3_clk.common.hw,
+		[CLK_H3_USB_OHCI2]	= &usb_ohci2_h3_clk.common.hw,
+		[CLK_H3_USB_OHCI3]	= &usb_ohci3_h3_clk.common.hw,
+		[CLK_H3_DRAM]		= &dram_h3_clk.common.hw,
+		[CLK_H3_DRAM_VE]	= &dram_ve_clk.common.hw,
+		[CLK_H3_DRAM_CSI]	= &dram_csi_clk.common.hw,
+		[CLK_H3_DRAM_DEINTERLACE]	= &dram_deinterlace_clk.common.hw,
+		[CLK_H3_DRAM_TS]	= &dram_ts_clk.common.hw,
+		[CLK_H3_DE]		= &de_clk.common.hw,
+		[CLK_H3_TCON0]		= &tcon0_h3_clk.common.hw,
+		[CLK_H3_TVE]		= &tve_h3_clk.common.hw,
+		[CLK_H3_DEINTERLACE]	= &deinterlace_clk.common.hw,
+		[CLK_H3_CSI_MISC]	= &csi_misc_clk.common.hw,
+		[CLK_H3_CSI_SCLK]	= &csi_sclk_clk.common.hw,
+		[CLK_H3_CSI_MCLK]	= &csi_mclk_h3_clk.common.hw,
+		[CLK_H3_VE]		= &ve_clk.common.hw,
+		[CLK_H3_AC_DIG]		= &ac_dig_clk.common.hw,
+		[CLK_H3_AVS]		= &avs_clk.common.hw,
+		[CLK_H3_HDMI]		= &hdmi_h3_clk.common.hw,
+		[CLK_H3_HDMI_DDC]	= &hdmi_ddc_clk.common.hw,
+		[CLK_H3_MBUS]		= &mbus_h3_clk.common.hw,
+		[CLK_H3_GPU]		= &gpu_clk.common.hw,
 	},
-	.num	= CLK_NUMBER,
+	.num	= CLK_H3_NUMBER,
 };
 
 static struct ccu_reset_map sun8i_h3_ccu_resets[] = {
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
index 78be712c7487..80a7f34d0fbf 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
@@ -20,43 +20,43 @@
 #include <dt-bindings/clock/sun8i-h3-ccu.h>
 #include <dt-bindings/reset/sun8i-h3-ccu.h>
 
-#define CLK_PLL_CPUX		0
-#define CLK_PLL_AUDIO_BASE	1
-#define CLK_PLL_AUDIO		2
-#define CLK_PLL_AUDIO_2X	3
-#define CLK_PLL_AUDIO_4X	4
-#define CLK_PLL_AUDIO_8X	5
-#define CLK_PLL_VIDEO		6
-#define CLK_PLL_VE		7
-#define CLK_PLL_DDR		8
-#define CLK_PLL_PERIPH0		9
-#define CLK_PLL_PERIPH0_2X	10
-#define CLK_PLL_GPU		11
-#define CLK_PLL_PERIPH1		12
-#define CLK_PLL_DE		13
+#define CLK_H3_PLL_CPUX		0
+#define CLK_H3_PLL_AUDIO_BASE	1
+#define CLK_H3_PLL_AUDIO	2
+#define CLK_H3_PLL_AUDIO_2X	3
+#define CLK_H3_PLL_AUDIO_4X	4
+#define CLK_H3_PLL_AUDIO_8X	5
+#define CLK_H3_PLL_VIDEO	6
+#define CLK_H3_PLL_VE		7
+#define CLK_H3_PLL_DDR		8
+#define CLK_H3_PLL_PERIPH0	9
+#define CLK_H3_PLL_PERIPH0_2X	10
+#define CLK_H3_PLL_GPU		11
+#define CLK_H3_PLL_PERIPH1	12
+#define CLK_H3_PLL_DE		13
 
 /* The CPUX clock is exported */
 
-#define CLK_AXI			15
-#define CLK_AHB1		16
-#define CLK_APB1		17
-#define CLK_APB2		18
-#define CLK_AHB2		19
+#define CLK_H3_AXI		15
+#define CLK_H3_AHB1		16
+#define CLK_H3_APB1		17
+#define CLK_H3_APB2		18
+#define CLK_H3_AHB2		19
 
 /* All the bus gates are exported */
 
 /* The first bunch of module clocks are exported */
 
-#define CLK_DRAM		96
+#define CLK_H3_DRAM		96
 
 /* All the DRAM gates are exported */
 
 /* Some more module clocks are exported */
 
-#define CLK_MBUS		113
+#define CLK_H3_MBUS		113
 
 /* And the GPU module clock is exported */
 
-#define CLK_NUMBER		(CLK_GPU + 1)
+#define CLK_H3_NUMBER		(CLK_H3_GPU + 1)
 
 #endif /* _CCU_SUN8I_H3_H_ */
diff --git a/include/dt-bindings/clock/sun8i-h3-ccu.h b/include/dt-bindings/clock/sun8i-h3-ccu.h
index efb7ba2bd515..47a0681b16c7 100644
--- a/include/dt-bindings/clock/sun8i-h3-ccu.h
+++ b/include/dt-bindings/clock/sun8i-h3-ccu.h
@@ -43,103 +43,103 @@
 #ifndef _DT_BINDINGS_CLK_SUN8I_H3_H_
 #define _DT_BINDINGS_CLK_SUN8I_H3_H_
 
-#define CLK_CPUX		14
+#define CLK_H3_CPUX		14
 
-#define CLK_BUS_CE		20
-#define CLK_BUS_DMA		21
-#define CLK_BUS_MMC0		22
-#define CLK_BUS_MMC1		23
-#define CLK_BUS_MMC2		24
-#define CLK_BUS_NAND		25
-#define CLK_BUS_DRAM		26
-#define CLK_BUS_EMAC		27
-#define CLK_BUS_TS		28
-#define CLK_BUS_HSTIMER		29
-#define CLK_BUS_SPI0		30
-#define CLK_BUS_SPI1		31
-#define CLK_BUS_OTG		32
-#define CLK_BUS_EHCI0		33
-#define CLK_BUS_EHCI1		34
-#define CLK_BUS_EHCI2		35
-#define CLK_BUS_EHCI3		36
-#define CLK_BUS_OHCI0		37
-#define CLK_BUS_OHCI1		38
-#define CLK_BUS_OHCI2		39
-#define CLK_BUS_OHCI3		40
-#define CLK_BUS_VE		41
-#define CLK_BUS_TCON0		42
-#define CLK_BUS_TCON1		43
-#define CLK_BUS_DEINTERLACE	44
-#define CLK_BUS_CSI		45
-#define CLK_BUS_TVE		46
-#define CLK_BUS_HDMI		47
-#define CLK_BUS_DE		48
-#define CLK_BUS_GPU		49
-#define CLK_BUS_MSGBOX		50
-#define CLK_BUS_SPINLOCK	51
-#define CLK_BUS_CODEC		52
-#define CLK_BUS_SPDIF		53
-#define CLK_BUS_PIO		54
-#define CLK_BUS_THS		55
-#define CLK_BUS_I2S0		56
-#define CLK_BUS_I2S1		57
-#define CLK_BUS_I2S2		58
-#define CLK_BUS_I2C0		59
-#define CLK_BUS_I2C1		60
-#define CLK_BUS_I2C2		61
-#define CLK_BUS_UART0		62
-#define CLK_BUS_UART1		63
-#define CLK_BUS_UART2		64
-#define CLK_BUS_UART3		65
-#define CLK_BUS_SCR		66
-#define CLK_BUS_EPHY		67
-#define CLK_BUS_DBG		68
+#define CLK_H3_BUS_CE		20
+#define CLK_H3_BUS_DMA		21
+#define CLK_H3_BUS_MMC0		22
+#define CLK_H3_BUS_MMC1		23
+#define CLK_H3_BUS_MMC2		24
+#define CLK_H3_BUS_NAND		25
+#define CLK_H3_BUS_DRAM		26
+#define CLK_H3_BUS_EMAC		27
+#define CLK_H3_BUS_TS		28
+#define CLK_H3_BUS_HSTIMER	29
+#define CLK_H3_BUS_SPI0		30
+#define CLK_H3_BUS_SPI1		31
+#define CLK_H3_BUS_OTG		32
+#define CLK_H3_BUS_EHCI0	33
+#define CLK_H3_BUS_EHCI1	34
+#define CLK_H3_BUS_EHCI2	35
+#define CLK_H3_BUS_EHCI3	36
+#define CLK_H3_BUS_OHCI0	37
+#define CLK_H3_BUS_OHCI1	38
+#define CLK_H3_BUS_OHCI2	39
+#define CLK_H3_BUS_OHCI3	40
+#define CLK_H3_BUS_VE		41
+#define CLK_H3_BUS_TCON0	42
+#define CLK_H3_BUS_TCON1	43
+#define CLK_H3_BUS_DEINTERLACE	44
+#define CLK_H3_BUS_CSI		45
+#define CLK_H3_BUS_TVE		46
+#define CLK_H3_BUS_HDMI		47
+#define CLK_H3_BUS_DE		48
+#define CLK_H3_BUS_GPU		49
+#define CLK_H3_BUS_MSGBOX	50
+#define CLK_H3_BUS_SPINLOCK	51
+#define CLK_H3_BUS_CODEC	52
+#define CLK_H3_BUS_SPDIF	53
+#define CLK_H3_BUS_PIO		54
+#define CLK_H3_BUS_THS		55
+#define CLK_H3_BUS_I2S0		56
+#define CLK_H3_BUS_I2S1		57
+#define CLK_H3_BUS_I2S2		58
+#define CLK_H3_BUS_I2C0		59
+#define CLK_H3_BUS_I2C1		60
+#define CLK_H3_BUS_I2C2		61
+#define CLK_H3_BUS_UART0	62
+#define CLK_H3_BUS_UART1	63
+#define CLK_H3_BUS_UART2	64
+#define CLK_H3_BUS_UART3	65
+#define CLK_H3_BUS_SCR		66
+#define CLK_H3_BUS_EPHY		67
+#define CLK_H3_BUS_DBG		68
 
-#define CLK_THS			69
-#define CLK_NAND		70
-#define CLK_MMC0		71
-#define CLK_MMC0_SAMPLE		72
-#define CLK_MMC0_OUTPUT		73
-#define CLK_MMC1		74
-#define CLK_MMC1_SAMPLE		75
-#define CLK_MMC1_OUTPUT		76
-#define CLK_MMC2		77
-#define CLK_MMC2_SAMPLE		78
-#define CLK_MMC2_OUTPUT		79
-#define CLK_TS			80
-#define CLK_CE			81
-#define CLK_SPI0		82
-#define CLK_SPI1		83
-#define CLK_I2S0		84
-#define CLK_I2S1		85
-#define CLK_I2S2		86
-#define CLK_SPDIF		87
-#define CLK_USB_PHY0		88
-#define CLK_USB_PHY1		89
-#define CLK_USB_PHY2		90
-#define CLK_USB_PHY3		91
-#define CLK_USB_OHCI0		92
-#define CLK_USB_OHCI1		93
-#define CLK_USB_OHCI2		94
-#define CLK_USB_OHCI3		95
+#define CLK_H3_THS		69
+#define CLK_H3_NAND		70
+#define CLK_H3_MMC0		71
+#define CLK_H3_MMC0_SAMPLE	72
+#define CLK_H3_MMC0_OUTPUT	73
+#define CLK_H3_MMC1		74
+#define CLK_H3_MMC1_SAMPLE	75
+#define CLK_H3_MMC1_OUTPUT	76
+#define CLK_H3_MMC2		77
+#define CLK_H3_MMC2_SAMPLE	78
+#define CLK_H3_MMC2_OUTPUT	79
+#define CLK_H3_TS		80
+#define CLK_H3_CE		81
+#define CLK_H3_SPI0		82
+#define CLK_H3_SPI1		83
+#define CLK_H3_I2S0		84
+#define CLK_H3_I2S1		85
+#define CLK_H3_I2S2		86
+#define CLK_H3_SPDIF		87
+#define CLK_H3_USB_PHY0		88
+#define CLK_H3_USB_PHY1		89
+#define CLK_H3_USB_PHY2		90
+#define CLK_H3_USB_PHY3		91
+#define CLK_H3_USB_OHCI0	92
+#define CLK_H3_USB_OHCI1	93
+#define CLK_H3_USB_OHCI2	94
+#define CLK_H3_USB_OHCI3	95
 
-#define CLK_DRAM_VE		97
-#define CLK_DRAM_CSI		98
-#define CLK_DRAM_DEINTERLACE	99
-#define CLK_DRAM_TS		100
-#define CLK_DE			101
-#define CLK_TCON0		102
-#define CLK_TVE			103
-#define CLK_DEINTERLACE		104
-#define CLK_CSI_MISC		105
-#define CLK_CSI_SCLK		106
-#define CLK_CSI_MCLK		107
-#define CLK_VE			108
-#define CLK_AC_DIG		109
-#define CLK_AVS			110
-#define CLK_HDMI		111
-#define CLK_HDMI_DDC		112
+#define CLK_H3_DRAM_VE		97
+#define CLK_H3_DRAM_CSI		98
+#define CLK_H3_DRAM_DEINTERLACE	99
+#define CLK_H3_DRAM_TS		100
+#define CLK_H3_DE		101
+#define CLK_H3_TCON0		102
+#define CLK_H3_TVE		103
+#define CLK_H3_DEINTERLACE	104
+#define CLK_H3_CSI_MISC		105
+#define CLK_H3_CSI_SCLK		106
+#define CLK_H3_CSI_MCLK		107
+#define CLK_H3_VE		108
+#define CLK_H3_AC_DIG		109
+#define CLK_H3_AVS		110
+#define CLK_H3_HDMI		111
+#define CLK_H3_HDMI_DDC		112
 
-#define CLK_GPU			114
+#define CLK_H3_GPU		114
 
 #endif /* _DT_BINDINGS_CLK_SUN8I_H3_H_ */
-- 
2.9.2
