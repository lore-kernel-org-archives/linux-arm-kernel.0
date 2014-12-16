From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Dec 2014 22:59:58 +0100
Subject: [PATCH 5/6] ARM: sunxi: DT: Convert the DTs to use the GIC headers
In-Reply-To: <1418767199-20957-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1418767199-20957-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1418767199-20957-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC requires some extra opaque arguments to set the IRQ type and flags.

Convert the DTs to using the common defines.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi |  97 ++++++++++++++++++-----------------
 arch/arm/boot/dts/sun7i-a20.dtsi | 106 ++++++++++++++++++++-------------------
 arch/arm/boot/dts/sun8i-a23.dtsi |  47 +++++++++--------
 arch/arm/boot/dts/sun9i-a80.dtsi |  52 ++++++++++---------
 4 files changed, 156 insertions(+), 146 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 00b7e03d5d98..6fc124ee764f 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -49,6 +49,8 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -113,10 +115,10 @@
 
 	pmu {
 		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
-		interrupts = <0 120 4>,
-			     <0 121 4>,
-			     <0 122 4>,
-			     <0 123 4>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	clocks {
@@ -355,7 +357,7 @@
 		dma: dma-controller at 01c02000 {
 			compatible = "allwinner,sun6i-a31-dma";
 			reg = <0x01c02000 0x1000>;
-			interrupts = <0 50 4>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb1_gates 6>;
 			resets = <&ahb1_rst 6>;
 			#dma-cells = <1>;
@@ -372,7 +374,7 @@
 			clock-names = "ahb", "mmc";
 			resets = <&ahb1_rst 8>;
 			reset-names = "ahb";
-			interrupts = <0 60 4>;
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -383,7 +385,7 @@
 			clock-names = "ahb", "mmc";
 			resets = <&ahb1_rst 9>;
 			reset-names = "ahb";
-			interrupts = <0 61 4>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -394,7 +396,7 @@
 			clock-names = "ahb", "mmc";
 			resets = <&ahb1_rst 10>;
 			reset-names = "ahb";
-			interrupts = <0 62 4>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -405,7 +407,7 @@
 			clock-names = "ahb", "mmc";
 			resets = <&ahb1_rst 11>;
 			reset-names = "ahb";
-			interrupts = <0 63 4>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -436,7 +438,7 @@
 		ehci0: usb at 01c1a000 {
 			compatible = "allwinner,sun6i-a31-ehci", "generic-ehci";
 			reg = <0x01c1a000 0x100>;
-			interrupts = <0 72 4>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb1_gates 26>;
 			resets = <&ahb1_rst 26>;
 			phys = <&usbphy 1>;
@@ -447,7 +449,7 @@
 		ohci0: usb at 01c1a400 {
 			compatible = "allwinner,sun6i-a31-ohci", "generic-ohci";
 			reg = <0x01c1a400 0x100>;
-			interrupts = <0 73 4>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb1_gates 29>, <&usb_clk 16>;
 			resets = <&ahb1_rst 29>;
 			phys = <&usbphy 1>;
@@ -458,7 +460,7 @@
 		ehci1: usb at 01c1b000 {
 			compatible = "allwinner,sun6i-a31-ehci", "generic-ehci";
 			reg = <0x01c1b000 0x100>;
-			interrupts = <0 74 4>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb1_gates 27>;
 			resets = <&ahb1_rst 27>;
 			phys = <&usbphy 2>;
@@ -469,7 +471,7 @@
 		ohci1: usb at 01c1b400 {
 			compatible = "allwinner,sun6i-a31-ohci", "generic-ohci";
 			reg = <0x01c1b400 0x100>;
-			interrupts = <0 75 4>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb1_gates 30>, <&usb_clk 17>;
 			resets = <&ahb1_rst 30>;
 			phys = <&usbphy 2>;
@@ -480,7 +482,7 @@
 		ohci2: usb at 01c1c400 {
 			compatible = "allwinner,sun6i-a31-ohci", "generic-ohci";
 			reg = <0x01c1c400 0x100>;
-			interrupts = <0 77 4>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb1_gates 31>, <&usb_clk 18>;
 			resets = <&ahb1_rst 31>;
 			status = "disabled";
@@ -489,10 +491,10 @@
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun6i-a31-pinctrl";
 			reg = <0x01c20800 0x400>;
-			interrupts = <0 11 4>,
-				     <0 15 4>,
-				     <0 16 4>,
-				     <0 17 4>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 5>;
 			gpio-controller;
 			interrupt-controller;
@@ -599,11 +601,11 @@
 		timer at 01c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0xa0>;
-			interrupts = <0 18 4>,
-				     <0 19 4>,
-				     <0 20 4>,
-				     <0 21 4>,
-				     <0 22 4>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&osc24M>;
 		};
 
@@ -615,7 +617,7 @@
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-			interrupts = <0 0 4>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 16>;
@@ -628,7 +630,7 @@
 		uart1: serial at 01c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
-			interrupts = <0 1 4>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 17>;
@@ -641,7 +643,7 @@
 		uart2: serial at 01c28800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28800 0x400>;
-			interrupts = <0 2 4>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 18>;
@@ -654,7 +656,7 @@
 		uart3: serial at 01c28c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28c00 0x400>;
-			interrupts = <0 3 4>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 19>;
@@ -667,7 +669,7 @@
 		uart4: serial at 01c29000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29000 0x400>;
-			interrupts = <0 4 4>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 20>;
@@ -680,7 +682,7 @@
 		uart5: serial at 01c29400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29400 0x400>;
-			interrupts = <0 5 4>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 21>;
@@ -693,7 +695,7 @@
 		i2c0: i2c at 01c2ac00 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2ac00 0x400>;
-			interrupts = <0 6 4>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb2_gates 0>;
 			resets = <&apb2_rst 0>;
 			status = "disabled";
@@ -704,7 +706,7 @@
 		i2c1: i2c at 01c2b000 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b000 0x400>;
-			interrupts = <0 7 4>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb2_gates 1>;
 			resets = <&apb2_rst 1>;
 			status = "disabled";
@@ -715,7 +717,7 @@
 		i2c2: i2c at 01c2b400 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b400 0x400>;
-			interrupts = <0 8 4>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb2_gates 2>;
 			resets = <&apb2_rst 2>;
 			status = "disabled";
@@ -726,7 +728,7 @@
 		i2c3: i2c at 01c2b800 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b800 0x400>;
-			interrupts = <0 9 4>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb2_gates 3>;
 			resets = <&apb2_rst 3>;
 			status = "disabled";
@@ -737,7 +739,7 @@
 		gmac: ethernet at 01c30000 {
 			compatible = "allwinner,sun7i-a20-gmac";
 			reg = <0x01c30000 0x1054>;
-			interrupts = <0 82 4>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			clocks = <&ahb1_gates 17>, <&gmac_tx_clk>;
 			clock-names = "stmmaceth", "allwinner_gmac_tx";
@@ -754,10 +756,10 @@
 		timer at 01c60000 {
 			compatible = "allwinner,sun6i-a31-hstimer", "allwinner,sun7i-a20-hstimer";
 			reg = <0x01c60000 0x1000>;
-			interrupts = <0 51 4>,
-				     <0 52 4>,
-				     <0 53 4>,
-				     <0 54 4>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb1_gates 19>;
 			resets = <&ahb1_rst 19>;
 		};
@@ -765,7 +767,7 @@
 		spi0: spi at 01c68000 {
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c68000 0x1000>;
-			interrupts = <0 65 4>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb1_gates 20>, <&spi0_clk>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma 23>, <&dma 23>;
@@ -777,7 +779,7 @@
 		spi1: spi at 01c69000 {
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c69000 0x1000>;
-			interrupts = <0 66 4>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb1_gates 21>, <&spi1_clk>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma 24>, <&dma 24>;
@@ -789,7 +791,7 @@
 		spi2: spi at 01c6a000 {
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c6a000 0x1000>;
-			interrupts = <0 67 4>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb1_gates 22>, <&spi2_clk>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma 25>, <&dma 25>;
@@ -801,7 +803,7 @@
 		spi3: spi at 01c6b000 {
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c6b000 0x1000>;
-			interrupts = <0 68 4>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb1_gates 23>, <&spi3_clk>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma 26>, <&dma 26>;
@@ -818,13 +820,14 @@
 			      <0x01c86000 0x2000>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			interrupts = <1 9 0xf04>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
 		rtc: rtc at 01f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
-			interrupts = <0 40 4>, <0 41 4>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		nmi_intc: interrupt-controller at 01f00c0c {
@@ -832,7 +835,7 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x01f00c0c 0x38>;
-			interrupts = <0 32 4>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		prcm at 01f01400 {
@@ -886,8 +889,8 @@
 		r_pio: pinctrl at 01f02c00 {
 			compatible = "allwinner,sun6i-a31-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-			interrupts = <0 45 4>,
-				     <0 46 4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb0_gates 0>;
 			resets = <&apb0_rst 0>;
 			gpio-controller;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 02bff2390034..853f4b758e8d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -49,6 +49,8 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
@@ -104,16 +106,16 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <1 13 0xf08>,
-			     <1 14 0xf08>,
-			     <1 11 0xf08>,
-			     <1 10 0xf08>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	pmu {
 		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
-		interrupts = <0 120 4>,
-			     <0 121 4>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	clocks {
@@ -465,13 +467,13 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x01c00030 0x0c>;
-			interrupts = <0 0 4>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		dma: dma-controller at 01c02000 {
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
-			interrupts = <0 27 4>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb_gates 6>;
 			#dma-cells = <2>;
 		};
@@ -479,7 +481,7 @@
 		spi0: spi at 01c05000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
-			interrupts = <0 10 4>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb_gates 20>, <&spi0_clk>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 27>,
@@ -493,7 +495,7 @@
 		spi1: spi at 01c06000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c06000 0x1000>;
-			interrupts = <0 11 4>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb_gates 21>, <&spi1_clk>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 9>,
@@ -507,7 +509,7 @@
 		emac: ethernet at 01c0b000 {
 			compatible = "allwinner,sun4i-a10-emac";
 			reg = <0x01c0b000 0x1000>;
-			interrupts = <0 55 4>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb_gates 17>;
 			status = "disabled";
 		};
@@ -525,7 +527,7 @@
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&ahb_gates 8>, <&mmc0_clk>;
 			clock-names = "ahb", "mmc";
-			interrupts = <0 32 4>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -534,7 +536,7 @@
 			reg = <0x01c10000 0x1000>;
 			clocks = <&ahb_gates 9>, <&mmc1_clk>;
 			clock-names = "ahb", "mmc";
-			interrupts = <0 33 4>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -543,7 +545,7 @@
 			reg = <0x01c11000 0x1000>;
 			clocks = <&ahb_gates 10>, <&mmc2_clk>;
 			clock-names = "ahb", "mmc";
-			interrupts = <0 34 4>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -552,7 +554,7 @@
 			reg = <0x01c12000 0x1000>;
 			clocks = <&ahb_gates 11>, <&mmc3_clk>;
 			clock-names = "ahb", "mmc";
-			interrupts = <0 35 4>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -571,7 +573,7 @@
 		ehci0: usb at 01c14000 {
 			compatible = "allwinner,sun7i-a20-ehci", "generic-ehci";
 			reg = <0x01c14000 0x100>;
-			interrupts = <0 39 4>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb_gates 1>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
@@ -581,7 +583,7 @@
 		ohci0: usb at 01c14400 {
 			compatible = "allwinner,sun7i-a20-ohci", "generic-ohci";
 			reg = <0x01c14400 0x100>;
-			interrupts = <0 64 4>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&usb_clk 6>, <&ahb_gates 2>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
@@ -591,7 +593,7 @@
 		spi2: spi at 01c17000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
-			interrupts = <0 12 4>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb_gates 22>, <&spi2_clk>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 29>,
@@ -605,7 +607,7 @@
 		ahci: sata at 01c18000 {
 			compatible = "allwinner,sun4i-a10-ahci";
 			reg = <0x01c18000 0x1000>;
-			interrupts = <0 56 4>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pll6 0>, <&ahb_gates 25>;
 			status = "disabled";
 		};
@@ -613,7 +615,7 @@
 		ehci1: usb at 01c1c000 {
 			compatible = "allwinner,sun7i-a20-ehci", "generic-ehci";
 			reg = <0x01c1c000 0x100>;
-			interrupts = <0 40 4>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb_gates 3>;
 			phys = <&usbphy 2>;
 			phy-names = "usb";
@@ -623,7 +625,7 @@
 		ohci1: usb at 01c1c400 {
 			compatible = "allwinner,sun7i-a20-ohci", "generic-ohci";
 			reg = <0x01c1c400 0x100>;
-			interrupts = <0 65 4>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&usb_clk 7>, <&ahb_gates 4>;
 			phys = <&usbphy 2>;
 			phy-names = "usb";
@@ -633,7 +635,7 @@
 		spi3: spi at 01c1f000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c1f000 0x1000>;
-			interrupts = <0 50 4>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb_gates 23>, <&spi3_clk>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 31>,
@@ -647,7 +649,7 @@
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun7i-a20-pinctrl";
 			reg = <0x01c20800 0x400>;
-			interrupts = <0 28 4>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb0_gates 5>;
 			gpio-controller;
 			interrupt-controller;
@@ -878,12 +880,12 @@
 		timer at 01c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0x90>;
-			interrupts = <0 22 4>,
-				     <0 23 4>,
-				     <0 24 4>,
-				     <0 25 4>,
-				     <0 67 4>,
-				     <0 68 4>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&osc24M>;
 		};
 
@@ -895,7 +897,7 @@
 		rtc: rtc at 01c20d00 {
 			compatible = "allwinner,sun7i-a20-rtc";
 			reg = <0x01c20d00 0x20>;
-			interrupts = <0 24 4>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pwm: pwm at 01c20e00 {
@@ -910,7 +912,7 @@
 			compatible = "allwinner,sun4i-a10-ir";
 			clocks = <&apb0_gates 6>, <&ir0_clk>;
 			clock-names = "apb", "ir";
-			interrupts = <0 5 4>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x01c21800 0x40>;
 			status = "disabled";
 		};
@@ -919,7 +921,7 @@
 			compatible = "allwinner,sun4i-a10-ir";
 			clocks = <&apb0_gates 7>, <&ir1_clk>;
 			clock-names = "apb", "ir";
-			interrupts = <0 6 4>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x01c21c00 0x40>;
 			status = "disabled";
 		};
@@ -932,13 +934,13 @@
 		rtp: rtp at 01c25000 {
 			compatible = "allwinner,sun4i-a10-ts";
 			reg = <0x01c25000 0x100>;
-			interrupts = <0 29 4>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-			interrupts = <0 1 4>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 16>;
@@ -948,7 +950,7 @@
 		uart1: serial at 01c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
-			interrupts = <0 2 4>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 17>;
@@ -958,7 +960,7 @@
 		uart2: serial at 01c28800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28800 0x400>;
-			interrupts = <0 3 4>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 18>;
@@ -968,7 +970,7 @@
 		uart3: serial at 01c28c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28c00 0x400>;
-			interrupts = <0 4 4>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 19>;
@@ -978,7 +980,7 @@
 		uart4: serial at 01c29000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29000 0x400>;
-			interrupts = <0 17 4>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 20>;
@@ -988,7 +990,7 @@
 		uart5: serial at 01c29400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29400 0x400>;
-			interrupts = <0 18 4>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 21>;
@@ -998,7 +1000,7 @@
 		uart6: serial at 01c29800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29800 0x400>;
-			interrupts = <0 19 4>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 22>;
@@ -1008,7 +1010,7 @@
 		uart7: serial at 01c29c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29c00 0x400>;
-			interrupts = <0 20 4>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 23>;
@@ -1018,7 +1020,7 @@
 		i2c0: i2c at 01c2ac00 {
 			compatible = "allwinner,sun7i-a20-i2c", "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
-			interrupts = <0 7 4>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 0>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -1028,7 +1030,7 @@
 		i2c1: i2c at 01c2b000 {
 			compatible = "allwinner,sun7i-a20-i2c", "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
-			interrupts = <0 8 4>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 1>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -1038,7 +1040,7 @@
 		i2c2: i2c at 01c2b400 {
 			compatible = "allwinner,sun7i-a20-i2c", "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
-			interrupts = <0 9 4>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 2>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -1048,7 +1050,7 @@
 		i2c3: i2c at 01c2b800 {
 			compatible = "allwinner,sun7i-a20-i2c", "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b800 0x400>;
-			interrupts = <0 88 4>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 3>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -1058,7 +1060,7 @@
 		i2c4: i2c at 01c2c000 {
 			compatible = "allwinner,sun7i-a20-i2c", "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2c000 0x400>;
-			interrupts = <0 89 4>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 15>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -1068,7 +1070,7 @@
 		gmac: ethernet at 01c50000 {
 			compatible = "allwinner,sun7i-a20-gmac";
 			reg = <0x01c50000 0x10000>;
-			interrupts = <0 85 4>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			clocks = <&ahb_gates 49>, <&gmac_tx_clk>;
 			clock-names = "stmmaceth", "allwinner_gmac_tx";
@@ -1083,10 +1085,10 @@
 		hstimer at 01c60000 {
 			compatible = "allwinner,sun7i-a20-hstimer";
 			reg = <0x01c60000 0x1000>;
-			interrupts = <0 81 4>,
-				     <0 82 4>,
-				     <0 83 4>,
-				     <0 84 4>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb_gates 28>;
 		};
 
@@ -1098,7 +1100,7 @@
 			      <0x01c86000 0x2000>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			interrupts = <1 9 0xf04>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 508efea9686f..e470dd5dbc70 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -49,6 +49,8 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -252,7 +254,7 @@
 		dma: dma-controller at 01c02000 {
 			compatible = "allwinner,sun8i-a23-dma";
 			reg = <0x01c02000 0x1000>;
-			interrupts = <0 50 4>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ahb1_gates 6>;
 			resets = <&ahb1_rst 6>;
 			#dma-cells = <1>;
@@ -265,7 +267,7 @@
 			clock-names = "ahb", "mmc";
 			resets = <&ahb1_rst 8>;
 			reset-names = "ahb";
-			interrupts = <0 60 4>;
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -276,7 +278,7 @@
 			clock-names = "ahb", "mmc";
 			resets = <&ahb1_rst 9>;
 			reset-names = "ahb";
-			interrupts = <0 61 4>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -287,16 +289,16 @@
 			clock-names = "ahb", "mmc";
 			resets = <&ahb1_rst 10>;
 			reset-names = "ahb";
-			interrupts = <0 62 4>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun8i-a23-pinctrl";
 			reg = <0x01c20800 0x400>;
-			interrupts = <0 11 4>,
-				     <0 15 4>,
-				     <0 17 4>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 5>;
 			gpio-controller;
 			interrupt-controller;
@@ -368,21 +370,21 @@
 		timer at 01c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0xa0>;
-			interrupts = <0 18 4>,
-				     <0 19 4>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&osc24M>;
 		};
 
 		wdt0: watchdog at 01c20ca0 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
-			interrupts = <0 25 4>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-			interrupts = <0 0 4>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 16>;
@@ -395,7 +397,7 @@
 		uart1: serial at 01c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
-			interrupts = <0 1 4>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 17>;
@@ -408,7 +410,7 @@
 		uart2: serial at 01c28800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28800 0x400>;
-			interrupts = <0 2 4>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 18>;
@@ -421,7 +423,7 @@
 		uart3: serial at 01c28c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28c00 0x400>;
-			interrupts = <0 3 4>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 19>;
@@ -434,7 +436,7 @@
 		uart4: serial at 01c29000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29000 0x400>;
-			interrupts = <0 4 4>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb2_gates 20>;
@@ -447,7 +449,7 @@
 		i2c0: i2c at 01c2ac00 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2ac00 0x400>;
-			interrupts = <0 6 4>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb2_gates 0>;
 			resets = <&apb2_rst 0>;
 			status = "disabled";
@@ -458,7 +460,7 @@
 		i2c1: i2c at 01c2b000 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b000 0x400>;
-			interrupts = <0 7 4>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb2_gates 1>;
 			resets = <&apb2_rst 1>;
 			status = "disabled";
@@ -469,7 +471,7 @@
 		i2c2: i2c at 01c2b400 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b400 0x400>;
-			interrupts = <0 8 4>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb2_gates 2>;
 			resets = <&apb2_rst 2>;
 			status = "disabled";
@@ -485,13 +487,14 @@
 			      <0x01c86000 0x2000>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			interrupts = <1 9 0xf04>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
 		rtc: rtc at 01f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
-			interrupts = <0 40 4>, <0 41 4>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		prcm at 01f01400 {
@@ -541,7 +544,7 @@
 		r_uart: serial at 01f02800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01f02800 0x400>;
-			interrupts = <0 38 4>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb0_gates 4>;
@@ -552,7 +555,7 @@
 		r_pio: pinctrl at 01f02c00 {
 			compatible = "allwinner,sun8i-a23-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-			interrupts = <0 45 4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb0_gates 0>;
 			resets = <&apb0_rst 0>;
 			gpio-controller;
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index de31b210e2c1..4b584cb9c2f0 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -49,6 +49,8 @@
 
 #include "skeleton64.dtsi"
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -293,7 +295,7 @@
 			      <0x01c46000 0x2000>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			interrupts = <1 9 0xf04>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
 		ahb0_resets: reset at 060005a0 {
@@ -329,12 +331,12 @@
 		timer at 06000c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x06000c00 0xa0>;
-			interrupts = <0 18 4>,
-				     <0 19 4>,
-				     <0 20 4>,
-				     <0 21 4>,
-				     <0 22 4>,
-				     <0 23 4>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 
 			clocks = <&osc24M>;
 		};
@@ -342,11 +344,11 @@
 		pio: pinctrl at 06000800 {
 			compatible = "allwinner,sun9i-a80-pinctrl";
 			reg = <0x06000800 0x400>;
-			interrupts = <0 11 4>,
-				     <0 15 4>,
-				     <0 16 4>,
-				     <0 17 4>,
-				     <0 120 4>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb0_gates 5>;
 			gpio-controller;
 			interrupt-controller;
@@ -379,7 +381,7 @@
 		uart0: serial at 07000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x07000000 0x400>;
-			interrupts = <0 0 4>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 16>;
@@ -390,7 +392,7 @@
 		uart1: serial at 07000400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x07000400 0x400>;
-			interrupts = <0 1 4>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 17>;
@@ -401,7 +403,7 @@
 		uart2: serial at 07000800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x07000800 0x400>;
-			interrupts = <0 2 4>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 18>;
@@ -412,7 +414,7 @@
 		uart3: serial at 07000c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x07000c00 0x400>;
-			interrupts = <0 3 4>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 19>;
@@ -423,7 +425,7 @@
 		uart4: serial at 07001000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x07001000 0x400>;
-			interrupts = <0 4 4>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 20>;
@@ -434,7 +436,7 @@
 		uart5: serial at 07001400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x07001400 0x400>;
-			interrupts = <0 5 4>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&apb1_gates 21>;
@@ -445,7 +447,7 @@
 		i2c0: i2c at 07002800 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07002800 0x400>;
-			interrupts = <0 6 4>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 0>;
 			resets = <&apb1_resets 0>;
 			status = "disabled";
@@ -456,7 +458,7 @@
 		i2c1: i2c at 07002c00 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07002c00 0x400>;
-			interrupts = <0 7 4>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 1>;
 			resets = <&apb1_resets 1>;
 			status = "disabled";
@@ -467,7 +469,7 @@
 		i2c2: i2c at 07003000 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07003000 0x400>;
-			interrupts = <0 8 4>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 2>;
 			resets = <&apb1_resets 2>;
 			status = "disabled";
@@ -478,7 +480,7 @@
 		i2c3: i2c at 07003400 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07003400 0x400>;
-			interrupts = <0 9 4>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 3>;
 			resets = <&apb1_resets 3>;
 			status = "disabled";
@@ -489,7 +491,7 @@
 		i2c4: i2c at 07003800 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07003800 0x400>;
-			interrupts = <0 10 4>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 4>;
 			resets = <&apb1_resets 4>;
 			status = "disabled";
@@ -500,13 +502,13 @@
 		r_wdt: watchdog at 08001000 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x08001000 0x20>;
-			interrupts = <0 36 4>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		r_uart: serial at 08002800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x08002800 0x400>;
-			interrupts = <0 38 4>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&osc24M>;
-- 
2.2.0
