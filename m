From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 26 Sep 2017 09:22:30 +0200
Subject: [PATCH v3 10/14] arm64: allwinner: a64: Fix simple-bus unit address
 format error
In-Reply-To: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
Message-ID: <20170926072234.27481-11-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch remove leading 0 of unit address and so remove
lots of warning when building DT with W=1.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index e30476f05802..662e8b7981b5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -190,7 +190,7 @@
 			status = "disabled";
 		};
 
-		usb_otg: usb at 01c19000 {
+		usb_otg: usb at 1c19000 {
 			compatible = "allwinner,sun8i-a33-musb";
 			reg = <0x01c19000 0x0400>;
 			clocks = <&ccu CLK_BUS_OTG>;
@@ -203,7 +203,7 @@
 			status = "disabled";
 		};
 
-		usbphy: phy at 01c19400 {
+		usbphy: phy at 1c19400 {
 			compatible = "allwinner,sun50i-a64-usb-phy";
 			reg = <0x01c19400 0x14>,
 			      <0x01c1a800 0x4>,
@@ -223,7 +223,7 @@
 			#phy-cells = <1>;
 		};
 
-		ehci0: usb at 01c1a000 {
+		ehci0: usb at 1c1a000 {
 			compatible = "allwinner,sun50i-a64-ehci", "generic-ehci";
 			reg = <0x01c1a000 0x100>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
@@ -235,7 +235,7 @@
 			status = "disabled";
 		};
 
-		ohci0: usb at 01c1a400 {
+		ohci0: usb at 1c1a400 {
 			compatible = "allwinner,sun50i-a64-ohci", "generic-ohci";
 			reg = <0x01c1a400 0x100>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
@@ -245,7 +245,7 @@
 			status = "disabled";
 		};
 
-		ehci1: usb at 01c1b000 {
+		ehci1: usb at 1c1b000 {
 			compatible = "allwinner,sun50i-a64-ehci", "generic-ehci";
 			reg = <0x01c1b000 0x100>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
@@ -259,7 +259,7 @@
 			status = "disabled";
 		};
 
-		ohci1: usb at 01c1b400 {
+		ohci1: usb at 1c1b400 {
 			compatible = "allwinner,sun50i-a64-ohci", "generic-ohci";
 			reg = <0x01c1b400 0x100>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
@@ -271,7 +271,7 @@
 			status = "disabled";
 		};
 
-		ccu: clock at 01c20000 {
+		ccu: clock at 1c20000 {
 			compatible = "allwinner,sun50i-a64-ccu";
 			reg = <0x01c20000 0x400>;
 			clocks = <&osc24M>, <&osc32k>;
@@ -472,7 +472,7 @@
 		};
 
 
-		spi0: spi at 01c68000 {
+		spi0: spi at 1c68000 {
 			compatible = "allwinner,sun8i-h3-spi";
 			reg = <0x01c68000 0x1000>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
@@ -487,7 +487,7 @@
 			#size-cells = <0>;
 		};
 
-		spi1: spi at 01c69000 {
+		spi1: spi at 1c69000 {
 			compatible = "allwinner,sun8i-h3-spi";
 			reg = <0x01c69000 0x1000>;
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
@@ -560,7 +560,7 @@
 			#reset-cells = <1>;
 		};
 
-		r_pio: pinctrl at 01f02c00 {
+		r_pio: pinctrl at 1f02c00 {
 			compatible = "allwinner,sun50i-a64-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.13.5
