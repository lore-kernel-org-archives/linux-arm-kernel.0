From: plaes@plaes.org (Priit Laes)
Date: Sun,  3 Sep 2017 16:50:16 +0300
Subject: [PATCH 1/3] ARM: dts: sun4i: Use defines for clock and reset indices
In-Reply-To: <cover.28f5be8e511ad74e9ae3f573891882e62bebdb7b.1504446535.git-series.plaes@plaes.org>
References: <cover.28f5be8e511ad74e9ae3f573891882e62bebdb7b.1504446535.git-series.plaes@plaes.org>
Message-ID: <9c22e258a56199448c6e54a3880c70f2bb21c897.1504446535.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can now use defines for clock/reset indices defined in the
dt-bindings includes.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 121 ++++++++++++++++----------------
 1 file changed, 61 insertions(+), 60 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index fc23c41..c5efd53 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -44,8 +44,9 @@
 #include "skeleton.dtsi"
 
 #include <dt-bindings/thermal/thermal.h>
-
 #include <dt-bindings/dma/sun4i-a10.h>
+#include <dt-bindings/clock/sun4i-a10-ccu.h>
+#include <dt-bindings/reset/sun4i-a10-ccu.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -63,9 +64,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
-			clocks = <&ccu 56>, <&ccu 60>,
-				 <&ccu 62>, <&ccu 144>,
-				 <&ccu 155>, <&ccu 140>;
+			clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_HDMI0>,
+				 <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_DE_BE0>,
+				 <&ccu CLK_TCON0_CH1>, <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
 		};
 
@@ -73,11 +74,11 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-hdmi";
-			clocks = <&ccu 56>, <&ccu 60>,
-				 <&ccu 62>, <&ccu 64>,
-				 <&ccu 144>, <&ccu 146>,
-				 <&ccu 155>, <&ccu 164>,
-				 <&ccu 139>, <&ccu 140>;
+			clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_HDMI0>,
+				 <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
+				 <&ccu CLK_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
+				 <&ccu CLK_TCON0_CH1>, <&ccu CLK_HDMI>,
+				 <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
 		};
 
@@ -85,10 +86,10 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0";
-			clocks = <&ccu 56>, <&ccu 62>,
-				 <&ccu 64>, <&ccu 144>,
-				 <&ccu 146>, <&ccu 149>,
-				 <&ccu 139>, <&ccu 140>;
+			clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_DE_BE0>,
+				 <&ccu CLK_AHB_DE_FE0>, <&ccu CLK_DE_BE0>,
+				 <&ccu CLK_AHB_DE_FE0>, <&ccu CLK_TCON0_CH0>,
+				 <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
 		};
 
@@ -96,11 +97,11 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-tve0";
-			clocks = <&ccu 54>, <&ccu 56>,
-				 <&ccu 62>, <&ccu 64>,
-				 <&ccu 144>, <&ccu 146>,
-				 <&ccu 155>, <&ccu 135>,
-				 <&ccu 139>, <&ccu 140>;
+			clocks = <&ccu CLK_AHB_TVE0>, <&ccu CLK_AHB_LCD0>,
+				 <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
+				 <&ccu CLK_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
+				 <&ccu CLK_TCON0_CH1>, <&ccu CLK_DRAM_TVE0>,
+				 <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
 		};
 	};
@@ -112,7 +113,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a8";
 			reg = <0x0>;
-			clocks = <&ccu 20>;
+			clocks = <&ccu CLK_CPU>;
 			clock-latency = <244144>; /* 8 32k periods */
 			operating-points = <
 				/* kHz	  uV */
@@ -229,7 +230,7 @@
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <27>;
-			clocks = <&ccu 32>;
+			clocks = <&ccu CLK_AHB_DMA>;
 			#dma-cells = <2>;
 		};
 
@@ -237,7 +238,7 @@
 			compatible = "allwinner,sun4i-a10-nand";
 			reg = <0x01c03000 0x1000>;
 			interrupts = <37>;
-			clocks = <&ccu 39>, <&ccu 96>;
+			clocks = <&ccu CLK_AHB_NAND>, <&ccu CLK_NAND>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 3>;
 			dma-names = "rxtx";
@@ -250,7 +251,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
 			interrupts = <10>;
-			clocks = <&ccu 44>, <&ccu 112>;
+			clocks = <&ccu CLK_AHB_SPI0>, <&ccu CLK_SPI0>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 27>,
 			       <&dma SUN4I_DMA_DEDICATED 26>;
@@ -264,7 +265,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c06000 0x1000>;
 			interrupts = <11>;
-			clocks = <&ccu 45>, <&ccu 113>;
+			clocks = <&ccu CLK_AHB_SPI1>, <&ccu CLK_SPI1>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 9>,
 			       <&dma SUN4I_DMA_DEDICATED 8>;
@@ -278,7 +279,7 @@
 			compatible = "allwinner,sun4i-a10-emac";
 			reg = <0x01c0b000 0x1000>;
 			interrupts = <55>;
-			clocks = <&ccu 42>;
+			clocks = <&ccu CLK_AHB_EMAC>;
 			allwinner,sram = <&emac_sram 1>;
 			status = "disabled";
 		};
@@ -294,7 +295,7 @@
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ccu 34>, <&ccu 98>;
+			clocks = <&ccu CLK_AHB_MMC0>, <&ccu CLK_MMC0>;
 			clock-names = "ahb", "mmc";
 			interrupts = <32>;
 			status = "disabled";
@@ -305,7 +306,7 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ccu 35>, <&ccu 101>;
+			clocks = <&ccu CLK_AHB_MMC1>, <&ccu CLK_MMC1>;
 			clock-names = "ahb", "mmc";
 			interrupts = <33>;
 			status = "disabled";
@@ -316,7 +317,7 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ccu 36>, <&ccu 104>;
+			clocks = <&ccu CLK_AHB_MMC2>, <&ccu CLK_MMC2>;
 			clock-names = "ahb", "mmc";
 			interrupts = <34>;
 			status = "disabled";
@@ -327,7 +328,7 @@
 		mmc3: mmc at 01c12000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c12000 0x1000>;
-			clocks = <&ccu 37>, <&ccu 107>;
+			clocks = <&ccu CLK_AHB_MMC3>, <&ccu CLK_MMC3>;
 			clock-names = "ahb", "mmc";
 			interrupts = <35>;
 			status = "disabled";
@@ -338,7 +339,7 @@
 		usb_otg: usb at 01c13000 {
 			compatible = "allwinner,sun4i-a10-musb";
 			reg = <0x01c13000 0x0400>;
-			clocks = <&ccu 26>;
+			clocks = <&ccu CLK_AHB_OTG>;
 			interrupts = <38>;
 			interrupt-names = "mc";
 			phys = <&usbphy 0>;
@@ -353,11 +354,11 @@
 			compatible = "allwinner,sun4i-a10-usb-phy";
 			reg = <0x01c13400 0x10 0x01c14800 0x4 0x01c1c800 0x4>;
 			reg-names = "phy_ctrl", "pmu1", "pmu2";
-			clocks = <&ccu 125>;
+			clocks = <&ccu CLK_USB_PHY>;
 			clock-names = "usb_phy";
-			resets = <&ccu 1>,
-				 <&ccu 2>,
-				 <&ccu 3>;
+			resets = <&ccu RST_USB_PHY0>,
+				 <&ccu RST_USB_PHY1>,
+				 <&ccu RST_USB_PHY2>;
 			reset-names = "usb0_reset", "usb1_reset", "usb2_reset";
 			status = "disabled";
 		};
@@ -366,7 +367,7 @@
 			compatible = "allwinner,sun4i-a10-ehci", "generic-ehci";
 			reg = <0x01c14000 0x100>;
 			interrupts = <39>;
-			clocks = <&ccu 27>;
+			clocks = <&ccu CLK_AHB_EHCI0>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -376,7 +377,7 @@
 			compatible = "allwinner,sun4i-a10-ohci", "generic-ohci";
 			reg = <0x01c14400 0x100>;
 			interrupts = <64>;
-			clocks = <&ccu 123>, <&ccu 28>;
+			clocks = <&ccu CLK_USB_OHCI0>, <&ccu CLK_AHB_OHCI0>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -386,7 +387,7 @@
 			compatible = "allwinner,sun4i-a10-crypto";
 			reg = <0x01c15000 0x1000>;
 			interrupts = <86>;
-			clocks = <&ccu 31>, <&ccu 111>;
+			clocks = <&ccu CLK_AHB_SS>, <&ccu CLK_SS>;
 			clock-names = "ahb", "mod";
 		};
 
@@ -394,7 +395,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
 			interrupts = <12>;
-			clocks = <&ccu 46>, <&ccu 114>;
+			clocks = <&ccu CLK_AHB_SPI2>, <&ccu CLK_SPI2>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 29>,
 			       <&dma SUN4I_DMA_DEDICATED 28>;
@@ -408,7 +409,7 @@
 			compatible = "allwinner,sun4i-a10-ahci";
 			reg = <0x01c18000 0x1000>;
 			interrupts = <56>;
-			clocks = <&ccu 49>, <&ccu 122>;
+			clocks = <&ccu CLK_AHB_SATA>, <&ccu CLK_SATA>;
 			status = "disabled";
 		};
 
@@ -416,7 +417,7 @@
 			compatible = "allwinner,sun4i-a10-ehci", "generic-ehci";
 			reg = <0x01c1c000 0x100>;
 			interrupts = <40>;
-			clocks = <&ccu 29>;
+			clocks = <&ccu CLK_AHB_EHCI1>;
 			phys = <&usbphy 2>;
 			phy-names = "usb";
 			status = "disabled";
@@ -426,7 +427,7 @@
 			compatible = "allwinner,sun4i-a10-ohci", "generic-ohci";
 			reg = <0x01c1c400 0x100>;
 			interrupts = <65>;
-			clocks = <&ccu 124>, <&ccu 30>;
+			clocks = <&ccu CLK_USB_OHCI1>, <&ccu CLK_AHB_OHCI1>;
 			phys = <&usbphy 2>;
 			phy-names = "usb";
 			status = "disabled";
@@ -436,7 +437,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c1f000 0x1000>;
 			interrupts = <50>;
-			clocks = <&ccu 47>, <&ccu 127>;
+			clocks = <&ccu CLK_AHB_SPI3>, <&ccu CLK_SPI3>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 31>,
 			       <&dma SUN4I_DMA_DEDICATED 30>;
@@ -466,7 +467,7 @@
 			compatible = "allwinner,sun4i-a10-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <28>;
-			clocks = <&ccu 74>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu CLK_APB0_PIO>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
@@ -643,7 +644,7 @@
 			compatible = "allwinner,sun4i-a10-spdif";
 			reg = <0x01c21000 0x400>;
 			interrupts = <13>;
-			clocks = <&ccu 70>, <&ccu 120>;
+			clocks = <&ccu CLK_APB0_SPDIF>, <&ccu CLK_SPDIF>;
 			clock-names = "apb", "spdif";
 			dmas = <&dma SUN4I_DMA_NORMAL 2>,
 			       <&dma SUN4I_DMA_NORMAL 2>;
@@ -653,7 +654,7 @@
 
 		ir0: ir at 01c21800 {
 			compatible = "allwinner,sun4i-a10-ir";
-			clocks = <&ccu 75>, <&ccu 116>;
+			clocks = <&ccu CLK_APB0_IR0>, <&ccu CLK_IR0>;
 			clock-names = "apb", "ir";
 			interrupts = <5>;
 			reg = <0x01c21800 0x40>;
@@ -662,7 +663,7 @@
 
 		ir1: ir at 01c21c00 {
 			compatible = "allwinner,sun4i-a10-ir";
-			clocks = <&ccu 76>, <&ccu 117>;
+			clocks = <&ccu CLK_APB0_IR1>, <&ccu CLK_IR1>;
 			clock-names = "apb", "ir";
 			interrupts = <6>;
 			reg = <0x01c21c00 0x40>;
@@ -681,7 +682,7 @@
 			compatible = "allwinner,sun4i-a10-codec";
 			reg = <0x01c22c00 0x40>;
 			interrupts = <30>;
-			clocks = <&ccu 69>, <&ccu 160>;
+			clocks = <&ccu CLK_APB0_CODEC>, <&ccu CLK_CODEC>;
 			clock-names = "apb", "codec";
 			dmas = <&dma SUN4I_DMA_NORMAL 19>,
 			       <&dma SUN4I_DMA_NORMAL 19>;
@@ -707,7 +708,7 @@
 			interrupts = <1>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 88>;
+			clocks = <&ccu CLK_APB1_UART0>;
 			status = "disabled";
 		};
 
@@ -717,7 +718,7 @@
 			interrupts = <2>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 89>;
+			clocks = <&ccu CLK_APB1_UART1>;
 			status = "disabled";
 		};
 
@@ -727,7 +728,7 @@
 			interrupts = <3>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 90>;
+			clocks = <&ccu CLK_APB1_UART2>;
 			status = "disabled";
 		};
 
@@ -737,7 +738,7 @@
 			interrupts = <4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 91>;
+			clocks = <&ccu CLK_APB1_UART3>;
 			status = "disabled";
 		};
 
@@ -747,7 +748,7 @@
 			interrupts = <17>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 92>;
+			clocks = <&ccu CLK_APB1_UART4>;
 			status = "disabled";
 		};
 
@@ -757,7 +758,7 @@
 			interrupts = <18>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 93>;
+			clocks = <&ccu CLK_APB1_UART5>;
 			status = "disabled";
 		};
 
@@ -767,7 +768,7 @@
 			interrupts = <19>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 94>;
+			clocks = <&ccu CLK_APB1_UART6>;
 			status = "disabled";
 		};
 
@@ -777,7 +778,7 @@
 			interrupts = <20>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 95>;
+			clocks = <&ccu CLK_APB1_UART7>;
 			status = "disabled";
 		};
 
@@ -785,7 +786,7 @@
 			compatible = "allwinner,sun4i-a10-ps2";
 			reg = <0x01c2a000 0x400>;
 			interrupts = <62>;
-			clocks = <&ccu 85>;
+			clocks = <&ccu CLK_APB1_PS20>;
 			status = "disabled";
 		};
 
@@ -793,7 +794,7 @@
 			compatible = "allwinner,sun4i-a10-ps2";
 			reg = <0x01c2a400 0x400>;
 			interrupts = <63>;
-			clocks = <&ccu 86>;
+			clocks = <&ccu CLK_APB1_PS21>;
 			status = "disabled";
 		};
 
@@ -801,7 +802,7 @@
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
-			clocks = <&ccu 79>;
+			clocks = <&ccu CLK_APB1_I2C0>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -811,7 +812,7 @@
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
-			clocks = <&ccu 80>;
+			clocks = <&ccu CLK_APB1_I2C1>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -821,7 +822,7 @@
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
-			clocks = <&ccu 81>;
+			clocks = <&ccu CLK_APB1_I2C2>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -831,7 +832,7 @@
 			compatible = "allwinner,sun4i-a10-can";
 			reg = <0x01c2bc00 0x400>;
 			interrupts = <26>;
-			clocks = <&ccu 83>;
+			clocks = <&ccu CLK_APB1_CAN>;
 			status = "disabled";
 		};
 	};
-- 
git-series 0.9.1
