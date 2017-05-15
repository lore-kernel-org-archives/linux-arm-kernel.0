From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 15 May 2017 16:39:58 +0800
Subject: [PATCH 1/4] ARM: sun8i: v3s: restore the usage of CCU definitions
Message-ID: <20170515084001.63123-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the used CCU definitions are stripped from the V3s DTSI file when
it's merged, as the DTSI file and the CCU device tree binding headers
went to different trees.

As they're all in Linus's tree now, restore the usage of the
definitions.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 64 +++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 71075969e5e6..3b50fa580261 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -41,6 +41,8 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/sun8i-v3s-ccu.h>
+#include <dt-bindings/reset/sun8i-v3s-ccu.h>
 
 / {
 	#address-cells = <1>;
@@ -55,7 +57,7 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
-			clocks = <&ccu 14>;
+			clocks = <&ccu CLK_CPU>;
 		};
 	};
 
@@ -96,15 +98,15 @@
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ccu 22>,
-				 <&ccu 45>,
-				 <&ccu 47>,
-				 <&ccu 46>;
+			clocks = <&ccu CLK_BUS_MMC0>,
+				 <&ccu CLK_MMC0>,
+				 <&ccu CLK_MMC0_OUTPUT>,
+				 <&ccu CLK_MMC0_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
 				      "sample";
-			resets = <&ccu 7>;
+			resets = <&ccu RST_BUS_MMC0>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -115,15 +117,15 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ccu 23>,
-				 <&ccu 48>,
-				 <&ccu 50>,
-				 <&ccu 49>;
+			clocks = <&ccu CLK_BUS_MMC1>,
+				 <&ccu CLK_MMC1>,
+				 <&ccu CLK_MMC1_OUTPUT>,
+				 <&ccu CLK_MMC1_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
 				      "sample";
-			resets = <&ccu 8>;
+			resets = <&ccu RST_BUS_MMC1>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -134,15 +136,15 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ccu 24>,
-				 <&ccu 51>,
-				 <&ccu 53>,
-				 <&ccu 52>;
+			clocks = <&ccu CLK_BUS_MMC2>,
+				 <&ccu CLK_MMC2>,
+				 <&ccu CLK_MMC2_OUTPUT>,
+				 <&ccu CLK_MMC2_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
 				      "sample";
-			resets = <&ccu 9>;
+			resets = <&ccu RST_BUS_MMC2>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -153,8 +155,8 @@
 		usb_otg: usb at 01c19000 {
 			compatible = "allwinner,sun8i-h3-musb";
 			reg = <0x01c19000 0x0400>;
-			clocks = <&ccu 29>;
-			resets = <&ccu 17>;
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mc";
 			phys = <&usbphy 0>;
@@ -169,9 +171,9 @@
 			      <0x01c1a800 0x4>;
 			reg-names = "phy_ctrl",
 				    "pmu0";
-			clocks = <&ccu 56>;
+			clocks = <&ccu CLK_USB_PHY0>;
 			clock-names = "usb0_phy";
-			resets = <&ccu 0>;
+			resets = <&ccu RST_USB_PHY0>;
 			reset-names = "usb0_reset";
 			status = "disabled";
 			#phy-cells = <1>;
@@ -198,7 +200,7 @@
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 37>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
@@ -244,8 +246,8 @@
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 40>;
-			resets = <&ccu 49>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
 			status = "disabled";
 		};
 
@@ -255,8 +257,8 @@
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 41>;
-			resets = <&ccu 50>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
 			status = "disabled";
 		};
 
@@ -266,8 +268,8 @@
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 42>;
-			resets = <&ccu 51>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
 			status = "disabled";
 		};
 
@@ -275,8 +277,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 38>;
-			resets = <&ccu 46>;
+			clocks = <&ccu CLK_BUS_I2C0>;
+			resets = <&ccu RST_BUS_I2C0>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins>;
 			status = "disabled";
@@ -288,8 +290,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu 39>;
-			resets = <&ccu 47>;
+			clocks = <&ccu CLK_BUS_I2C1>;
+			resets = <&ccu RST_BUS_I2C1>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.12.2
