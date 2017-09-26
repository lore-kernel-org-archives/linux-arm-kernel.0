From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 26 Sep 2017 09:22:21 +0200
Subject: [PATCH v3 01/14] ARM: dts: sunxi: h3/h5: Fix simple-bus unit address
 format error
In-Reply-To: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
Message-ID: <20170926072234.27481-2-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch remove leading 0 of unit address and so remove
lots of warning when building DT with W=1.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 74 +++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index a8e9b8f378ba..b37ed3461229 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -91,7 +91,7 @@
 			reg = <0x01c00000 0x1000>;
 		};
 
-		dma: dma-controller at 01c02000 {
+		dma: dma-controller at 1c02000 {
 			compatible = "allwinner,sun8i-h3-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
@@ -100,7 +100,7 @@
 			#dma-cells = <1>;
 		};
 
-		mmc0: mmc at 01c0f000 {
+		mmc0: mmc at 1c0f000 {
 			/* compatible and clocks are in per SoC .dtsi file */
 			reg = <0x01c0f000 0x1000>;
 			resets = <&ccu RST_BUS_MMC0>;
@@ -111,7 +111,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc1: mmc at 01c10000 {
+		mmc1: mmc at 1c10000 {
 			/* compatible and clocks are in per SoC .dtsi file */
 			reg = <0x01c10000 0x1000>;
 			resets = <&ccu RST_BUS_MMC1>;
@@ -122,7 +122,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc2: mmc at 01c11000 {
+		mmc2: mmc at 1c11000 {
 			/* compatible and clocks are in per SoC .dtsi file */
 			reg = <0x01c11000 0x1000>;
 			resets = <&ccu RST_BUS_MMC2>;
@@ -133,7 +133,7 @@
 			#size-cells = <0>;
 		};
 
-		usb_otg: usb at 01c19000 {
+		usb_otg: usb at 1c19000 {
 			compatible = "allwinner,sun8i-h3-musb";
 			reg = <0x01c19000 0x400>;
 			clocks = <&ccu CLK_BUS_OTG>;
@@ -158,7 +158,7 @@
 			status = "disabled";
 		};
 
-		usbphy: phy at 01c19400 {
+		usbphy: phy at 1c19400 {
 			compatible = "allwinner,sun8i-h3-usb-phy";
 			reg = <0x01c19400 0x2c>,
 			      <0x01c1a800 0x4>,
@@ -190,7 +190,7 @@
 			#phy-cells = <1>;
 		};
 
-		ehci0: usb at 01c1a000 {
+		ehci0: usb at 1c1a000 {
 			compatible = "allwinner,sun8i-h3-ehci", "generic-ehci";
 			reg = <0x01c1a000 0x100>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
@@ -199,7 +199,7 @@
 			status = "disabled";
 		};
 
-		ohci0: usb at 01c1a400 {
+		ohci0: usb at 1c1a400 {
 			compatible = "allwinner,sun8i-h3-ohci", "generic-ohci";
 			reg = <0x01c1a400 0x100>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
@@ -209,7 +209,7 @@
 			status = "disabled";
 		};
 
-		ehci1: usb at 01c1b000 {
+		ehci1: usb at 1c1b000 {
 			compatible = "allwinner,sun8i-h3-ehci", "generic-ehci";
 			reg = <0x01c1b000 0x100>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
@@ -220,7 +220,7 @@
 			status = "disabled";
 		};
 
-		ohci1: usb at 01c1b400 {
+		ohci1: usb at 1c1b400 {
 			compatible = "allwinner,sun8i-h3-ohci", "generic-ohci";
 			reg = <0x01c1b400 0x100>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
@@ -232,7 +232,7 @@
 			status = "disabled";
 		};
 
-		ehci2: usb at 01c1c000 {
+		ehci2: usb at 1c1c000 {
 			compatible = "allwinner,sun8i-h3-ehci", "generic-ehci";
 			reg = <0x01c1c000 0x100>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
@@ -243,7 +243,7 @@
 			status = "disabled";
 		};
 
-		ohci2: usb at 01c1c400 {
+		ohci2: usb at 1c1c400 {
 			compatible = "allwinner,sun8i-h3-ohci", "generic-ohci";
 			reg = <0x01c1c400 0x100>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
@@ -255,7 +255,7 @@
 			status = "disabled";
 		};
 
-		ehci3: usb at 01c1d000 {
+		ehci3: usb at 1c1d000 {
 			compatible = "allwinner,sun8i-h3-ehci", "generic-ehci";
 			reg = <0x01c1d000 0x100>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
@@ -266,7 +266,7 @@
 			status = "disabled";
 		};
 
-		ohci3: usb at 01c1d400 {
+		ohci3: usb at 1c1d400 {
 			compatible = "allwinner,sun8i-h3-ohci", "generic-ohci";
 			reg = <0x01c1d400 0x100>;
 			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
@@ -278,7 +278,7 @@
 			status = "disabled";
 		};
 
-		ccu: clock at 01c20000 {
+		ccu: clock at 1c20000 {
 			/* compatible is in per SoC .dtsi file */
 			reg = <0x01c20000 0x400>;
 			clocks = <&osc24M>, <&osc32k>;
@@ -287,7 +287,7 @@
 			#reset-cells = <1>;
 		};
 
-		pio: pinctrl at 01c20800 {
+		pio: pinctrl at 1c20800 {
 			/* compatible is in per SoC .dtsi file */
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
@@ -400,7 +400,7 @@
 			};
 		};
 
-		timer at 01c20c00 {
+		timer at 1c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0xa0>;
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
@@ -453,7 +453,7 @@
 			};
 		};
 
-		spi0: spi at 01c68000 {
+		spi0: spi at 1c68000 {
 			compatible = "allwinner,sun8i-h3-spi";
 			reg = <0x01c68000 0x1000>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
@@ -469,7 +469,7 @@
 			#size-cells = <0>;
 		};
 
-		spi1: spi at 01c69000 {
+		spi1: spi at 1c69000 {
 			compatible = "allwinner,sun8i-h3-spi";
 			reg = <0x01c69000 0x1000>;
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
@@ -485,13 +485,13 @@
 			#size-cells = <0>;
 		};
 
-		wdt0: watchdog at 01c20ca0 {
+		wdt0: watchdog at 1c20ca0 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		spdif: spdif at 01c21000 {
+		spdif: spdif at 1c21000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-spdif";
 			reg = <0x01c21000 0x400>;
@@ -504,7 +504,7 @@
 			status = "disabled";
 		};
 
-		pwm: pwm at 01c21400 {
+		pwm: pwm at 1c21400 {
 			compatible = "allwinner,sun8i-h3-pwm";
 			reg = <0x01c21400 0x8>;
 			clocks = <&osc24M>;
@@ -512,7 +512,7 @@
 			status = "disabled";
 		};
 
-		i2s0: i2s at 01c22000 {
+		i2s0: i2s at 1c22000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-i2s";
 			reg = <0x01c22000 0x400>;
@@ -525,7 +525,7 @@
 			status = "disabled";
 		};
 
-		i2s1: i2s at 01c22400 {
+		i2s1: i2s at 1c22400 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-i2s";
 			reg = <0x01c22400 0x400>;
@@ -538,7 +538,7 @@
 			status = "disabled";
 		};
 
-		codec: codec at 01c22c00 {
+		codec: codec at 1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-codec";
 			reg = <0x01c22c00 0x400>;
@@ -552,7 +552,7 @@
 			status = "disabled";
 		};
 
-		uart0: serial at 01c28000 {
+		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
@@ -565,7 +565,7 @@
 			status = "disabled";
 		};
 
-		uart1: serial at 01c28400 {
+		uart1: serial at 1c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
@@ -578,7 +578,7 @@
 			status = "disabled";
 		};
 
-		uart2: serial at 01c28800 {
+		uart2: serial at 1c28800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28800 0x400>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
@@ -591,7 +591,7 @@
 			status = "disabled";
 		};
 
-		uart3: serial at 01c28c00 {
+		uart3: serial at 1c28c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28c00 0x400>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
@@ -604,7 +604,7 @@
 			status = "disabled";
 		};
 
-		i2c0: i2c at 01c2ac00 {
+		i2c0: i2c at 1c2ac00 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
@@ -617,7 +617,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c1: i2c at 01c2b000 {
+		i2c1: i2c at 1c2b000 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
@@ -630,7 +630,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c2: i2c at 01c2b400 {
+		i2c2: i2c at 1c2b400 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
@@ -643,7 +643,7 @@
 			#size-cells = <0>;
 		};
 
-		gic: interrupt-controller at 01c81000 {
+		gic: interrupt-controller at 1c81000 {
 			compatible = "arm,gic-400";
 			reg = <0x01c81000 0x1000>,
 			      <0x01c82000 0x2000>,
@@ -654,7 +654,7 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
-		rtc: rtc at 01f00000 {
+		rtc: rtc at 1f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
@@ -671,12 +671,12 @@
 			#reset-cells = <1>;
 		};
 
-		codec_analog: codec-analog at 01f015c0 {
+		codec_analog: codec-analog at 1f015c0 {
 			compatible = "allwinner,sun8i-h3-codec-analog";
 			reg = <0x01f015c0 0x4>;
 		};
 
-		ir: ir at 01f02000 {
+		ir: ir at 1f02000 {
 			compatible = "allwinner,sun5i-a13-ir";
 			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
 			clock-names = "apb", "ir";
@@ -686,7 +686,7 @@
 			status = "disabled";
 		};
 
-		r_pio: pinctrl at 01f02c00 {
+		r_pio: pinctrl at 1f02c00 {
 			compatible = "allwinner,sun8i-h3-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.13.5
