From: plaes@plaes.org (Priit Laes)
Date: Sun,  3 Sep 2017 16:50:17 +0300
Subject: [PATCH 2/3] ARM: dts: sun7i: Use defines for clock and reset indices
In-Reply-To: <cover.28f5be8e511ad74e9ae3f573891882e62bebdb7b.1504446535.git-series.plaes@plaes.org>
References: <cover.28f5be8e511ad74e9ae3f573891882e62bebdb7b.1504446535.git-series.plaes@plaes.org>
Message-ID: <6e39cfeb26b07c8fe7b8da368db39f1f0410fe26.1504446535.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can now use defines for clock/reset indices defined in the
devicetree binding include files.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 146 ++++++++++++++++----------------
 1 file changed, 74 insertions(+), 72 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index a5ca5a8..39d0727 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -47,6 +47,8 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/dma/sun4i-a10.h>
+#include <dt-bindings/clock/sun4i-a10-ccu.h>
+#include <dt-bindings/reset/sun4i-a10-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -64,10 +66,10 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
-			clocks = <&ccu 56>, <&ccu 60>,
-				 <&ccu 62>, <&ccu 144>,
-				 <&ccu 155>, <&ccu 140>,
-				 <&ccu 164>;
+			clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_HDMI0>,
+				 <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_DE_BE0>,
+				 <&ccu CLK_TCON0_CH1>, <&ccu CLK_DRAM_DE_BE0>,
+				 <&ccu CLK_HDMI>;
 			status = "disabled";
 		};
 
@@ -75,9 +77,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&ccu 56>, <&ccu 62>,
-				 <&ccu 144>, <&ccu 149>,
-				 <&ccu 140>;
+			clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_DE_BE0>,
+				 <&ccu CLK_DE_BE0>, <&ccu CLK_TCON0_CH0>,
+				 <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
 		};
 
@@ -85,10 +87,10 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-tve0";
-			clocks = <&ccu 54>, <&ccu 56>,
-				 <&ccu 62>,
-				 <&ccu 144>, <&ccu 155>,
-				 <&ccu 135>, <&ccu 140>;
+			clocks = <&ccu CLK_AHB_TVE0>, <&ccu CLK_AHB_LCD0>,
+				 <&ccu CLK_AHB_DE_BE0>,
+				 <&ccu CLK_DE_BE0>, <&ccu CLK_TCON0_CH1>,
+				 <&ccu CLK_DRAM_TVE0>, <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
 		};
 	};
@@ -101,7 +103,7 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
-			clocks = <&ccu 20>;
+			clocks = <&ccu CLK_CPU>;
 			clock-latency = <244144>; /* 8 32k periods */
 			operating-points = <
 				/* kHz	  uV */
@@ -280,7 +282,7 @@
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 32>;
+			clocks = <&ccu CLK_AHB_DMA>;
 			#dma-cells = <2>;
 		};
 
@@ -288,7 +290,7 @@
 			compatible = "allwinner,sun4i-a10-nand";
 			reg = <0x01c03000 0x1000>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 39>, <&ccu 96>;
+			clocks = <&ccu CLK_AHB_NAND>, <&ccu CLK_NAND>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 3>;
 			dma-names = "rxtx";
@@ -301,7 +303,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 44>, <&ccu 112>;
+			clocks = <&ccu CLK_AHB_SPI0>, <&ccu CLK_SPI0>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 27>,
 			       <&dma SUN4I_DMA_DEDICATED 26>;
@@ -316,7 +318,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c06000 0x1000>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 45>, <&ccu 113>;
+			clocks = <&ccu CLK_AHB_SPI1>, <&ccu CLK_SPI1>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 9>,
 			       <&dma SUN4I_DMA_DEDICATED 8>;
@@ -331,7 +333,7 @@
 			compatible = "allwinner,sun4i-a10-emac";
 			reg = <0x01c0b000 0x1000>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 42>;
+			clocks = <&ccu CLK_AHB_EMAC>;
 			allwinner,sram = <&emac_sram 1>;
 			status = "disabled";
 		};
@@ -347,10 +349,10 @@
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ccu 34>,
-				 <&ccu 98>,
-				 <&ccu 99>,
-				 <&ccu 100>;
+			clocks = <&ccu CLK_AHB_MMC0>,
+				 <&ccu CLK_MMC0>,
+				 <&ccu CLK_MMC0_OUTPUT>,
+				 <&ccu CLK_MMC0_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
@@ -364,10 +366,10 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ccu 35>,
-				 <&ccu 101>,
-				 <&ccu 102>,
-				 <&ccu 103>;
+			clocks = <&ccu CLK_AHB_MMC1>,
+				 <&ccu CLK_MMC1>,
+				 <&ccu CLK_MMC1_OUTPUT>,
+				 <&ccu CLK_MMC1_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
@@ -381,10 +383,10 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ccu 36>,
-				 <&ccu 104>,
-				 <&ccu 105>,
-				 <&ccu 106>;
+			clocks = <&ccu CLK_AHB_MMC2>,
+				 <&ccu CLK_MMC2>,
+				 <&ccu CLK_MMC2_OUTPUT>,
+				 <&ccu CLK_MMC2_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
@@ -398,10 +400,10 @@
 		mmc3: mmc at 01c12000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c12000 0x1000>;
-			clocks = <&ccu 37>,
-				 <&ccu 107>,
-				 <&ccu 108>,
-				 <&ccu 109>;
+			clocks = <&ccu CLK_AHB_MMC3>,
+				 <&ccu CLK_MMC3>,
+				 <&ccu CLK_MMC3_OUTPUT>,
+				 <&ccu CLK_MMC3_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
@@ -415,7 +417,7 @@
 		usb_otg: usb at 01c13000 {
 			compatible = "allwinner,sun4i-a10-musb";
 			reg = <0x01c13000 0x0400>;
-			clocks = <&ccu 26>;
+			clocks = <&ccu CLK_AHB_OTG>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mc";
 			phys = <&usbphy 0>;
@@ -430,11 +432,11 @@
 			compatible = "allwinner,sun7i-a20-usb-phy";
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
@@ -443,7 +445,7 @@
 			compatible = "allwinner,sun7i-a20-ehci", "generic-ehci";
 			reg = <0x01c14000 0x100>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 27>;
+			clocks = <&ccu CLK_AHB_EHCI0>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -453,7 +455,7 @@
 			compatible = "allwinner,sun7i-a20-ohci", "generic-ohci";
 			reg = <0x01c14400 0x100>;
 			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 123>, <&ccu 28>;
+			clocks = <&ccu CLK_USB_OHCI0>, <&ccu CLK_AHB_OHCI0>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -464,7 +466,7 @@
 				     "allwinner,sun4i-a10-crypto";
 			reg = <0x01c15000 0x1000>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 31>, <&ccu 111>;
+			clocks = <&ccu CLK_AHB_SS>, <&ccu CLK_SS>;
 			clock-names = "ahb", "mod";
 		};
 
@@ -472,7 +474,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 46>, <&ccu 114>;
+			clocks = <&ccu CLK_AHB_SPI2>, <&ccu CLK_SPI2>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 29>,
 			       <&dma SUN4I_DMA_DEDICATED 28>;
@@ -487,7 +489,7 @@
 			compatible = "allwinner,sun4i-a10-ahci";
 			reg = <0x01c18000 0x1000>;
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 49>, <&ccu 122>;
+			clocks = <&ccu CLK_AHB_SATA>, <&ccu CLK_SATA>;
 			status = "disabled";
 		};
 
@@ -495,7 +497,7 @@
 			compatible = "allwinner,sun7i-a20-ehci", "generic-ehci";
 			reg = <0x01c1c000 0x100>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 29>;
+			clocks = <&ccu CLK_AHB_EHCI1>;
 			phys = <&usbphy 2>;
 			phy-names = "usb";
 			status = "disabled";
@@ -505,7 +507,7 @@
 			compatible = "allwinner,sun7i-a20-ohci", "generic-ohci";
 			reg = <0x01c1c400 0x100>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 124>, <&ccu 30>;
+			clocks = <&ccu CLK_USB_OHCI1>, <&ccu CLK_AHB_OHCI1>;
 			phys = <&usbphy 2>;
 			phy-names = "usb";
 			status = "disabled";
@@ -515,7 +517,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c1f000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 47>, <&ccu 127>;
+			clocks = <&ccu CLK_AHB_SPI3>, <&ccu CLK_SPI3>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 31>,
 			       <&dma SUN4I_DMA_DEDICATED 30>;
@@ -539,7 +541,7 @@
 			compatible = "allwinner,sun7i-a20-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 74>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu CLK_APB0_PIO>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
@@ -810,7 +812,7 @@
 			compatible = "allwinner,sun4i-a10-spdif";
 			reg = <0x01c21000 0x400>;
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 70>, <&ccu 120>;
+			clocks = <&ccu CLK_APB0_SPDIF>, <&ccu CLK_SPDIF>;
 			clock-names = "apb", "spdif";
 			dmas = <&dma SUN4I_DMA_NORMAL 2>,
 			       <&dma SUN4I_DMA_NORMAL 2>;
@@ -820,7 +822,7 @@
 
 		ir0: ir at 01c21800 {
 			compatible = "allwinner,sun4i-a10-ir";
-			clocks = <&ccu 75>, <&ccu 116>;
+			clocks = <&ccu CLK_APB0_IR0>, <&ccu CLK_IR0>;
 			clock-names = "apb", "ir";
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x01c21800 0x40>;
@@ -829,7 +831,7 @@
 
 		ir1: ir at 01c21c00 {
 			compatible = "allwinner,sun4i-a10-ir";
-			clocks = <&ccu 76>, <&ccu 117>;
+			clocks = <&ccu CLK_APB0_IR1>, <&ccu CLK_IR1>;
 			clock-names = "apb", "ir";
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x01c21c00 0x40>;
@@ -841,7 +843,7 @@
 			compatible = "allwinner,sun4i-a10-i2s";
 			reg = <0x01c22000 0x400>;
 			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 73>, <&ccu 128>;
+			clocks = <&ccu CLK_APB0_I2S1>, <&ccu CLK_I2S1>;
 			clock-names = "apb", "mod";
 			dmas = <&dma SUN4I_DMA_NORMAL 4>,
 			       <&dma SUN4I_DMA_NORMAL 4>;
@@ -854,7 +856,7 @@
 			compatible = "allwinner,sun4i-a10-i2s";
 			reg = <0x01c22400 0x400>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 71>, <&ccu 118>;
+			clocks = <&ccu CLK_APB0_I2S0>, <&ccu CLK_I2S0>;
 			clock-names = "apb", "mod";
 			dmas = <&dma SUN4I_DMA_NORMAL 3>,
 			       <&dma SUN4I_DMA_NORMAL 3>;
@@ -874,7 +876,7 @@
 			compatible = "allwinner,sun7i-a20-codec";
 			reg = <0x01c22c00 0x40>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 69>, <&ccu 160>;
+			clocks = <&ccu CLK_APB0_CODEC>, <&ccu CLK_CODEC>;
 			clock-names = "apb", "codec";
 			dmas = <&dma SUN4I_DMA_NORMAL 19>,
 			       <&dma SUN4I_DMA_NORMAL 19>;
@@ -892,7 +894,7 @@
 			compatible = "allwinner,sun4i-a10-i2s";
 			reg = <0x01c24400 0x400>;
 			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 77>, <&ccu 129>;
+			clocks = <&ccu CLK_APB0_I2S2>, <&ccu CLK_I2S2>;
 			clock-names = "apb", "mod";
 			dmas = <&dma SUN4I_DMA_NORMAL 6>,
 			       <&dma SUN4I_DMA_NORMAL 6>;
@@ -913,7 +915,7 @@
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 88>;
+			clocks = <&ccu CLK_APB1_UART0>;
 			status = "disabled";
 		};
 
@@ -923,7 +925,7 @@
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 89>;
+			clocks = <&ccu CLK_APB1_UART1>;
 			status = "disabled";
 		};
 
@@ -933,7 +935,7 @@
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 90>;
+			clocks = <&ccu CLK_APB1_UART2>;
 			status = "disabled";
 		};
 
@@ -943,7 +945,7 @@
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 91>;
+			clocks = <&ccu CLK_APB1_UART3>;
 			status = "disabled";
 		};
 
@@ -953,7 +955,7 @@
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 92>;
+			clocks = <&ccu CLK_APB1_UART4>;
 			status = "disabled";
 		};
 
@@ -963,7 +965,7 @@
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 93>;
+			clocks = <&ccu CLK_APB1_UART5>;
 			status = "disabled";
 		};
 
@@ -973,7 +975,7 @@
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 94>;
+			clocks = <&ccu CLK_APB1_UART6>;
 			status = "disabled";
 		};
 
@@ -983,7 +985,7 @@
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 95>;
+			clocks = <&ccu CLK_APB1_UART7>;
 			status = "disabled";
 		};
 
@@ -991,7 +993,7 @@
 			compatible = "allwinner,sun4i-a10-ps2";
 			reg = <0x01c2a000 0x400>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 85>;
+			clocks = <&ccu CLK_APB1_PS20>;
 			status = "disabled";
 		};
 
@@ -999,7 +1001,7 @@
 			compatible = "allwinner,sun4i-a10-ps2";
 			reg = <0x01c2a400 0x400>;
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 86>;
+			clocks = <&ccu CLK_APB1_PS21>;
 			status = "disabled";
 		};
 
@@ -1008,7 +1010,7 @@
 				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 79>;
+			clocks = <&ccu CLK_APB1_I2C0>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1019,7 +1021,7 @@
 				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 80>;
+			clocks = <&ccu CLK_APB1_I2C1>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1030,7 +1032,7 @@
 				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 81>;
+			clocks = <&ccu CLK_APB1_I2C2>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1041,7 +1043,7 @@
 				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b800 0x400>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 82>;
+			clocks = <&ccu CLK_APB1_I2C3>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1052,7 +1054,7 @@
 				     "allwinner,sun4i-a10-can";
 			reg = <0x01c2bc00 0x400>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 83>;
+			clocks = <&ccu CLK_APB1_CAN>;
 			status = "disabled";
 		};
 
@@ -1061,7 +1063,7 @@
 				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2c000 0x400>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 87>;
+			clocks = <&ccu CLK_APB1_I2C4>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1072,7 +1074,7 @@
 			reg = <0x01c50000 0x10000>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-			clocks = <&ccu 66>, <&gmac_tx_clk>;
+			clocks = <&ccu CLK_AHB_GMAC>, <&gmac_tx_clk>;
 			clock-names = "stmmaceth", "allwinner_gmac_tx";
 			snps,pbl = <2>;
 			snps,fixed-burst;
@@ -1089,7 +1091,7 @@
 				     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 51>;
+			clocks = <&ccu CLK_AHB_HSTIMER>;
 		};
 
 		gic: interrupt-controller at 01c81000 {
-- 
git-series 0.9.1
