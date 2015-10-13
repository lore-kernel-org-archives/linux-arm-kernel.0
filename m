From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 13 Oct 2015 22:11:42 +0200
Subject: [PATCH] ARM: socfpga: dts: sort nodes alphabetically
Message-ID: <1444767102-25242-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sorting policy for this file is alphabetically.
Reorder all nodes, that are out of place.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 128 ++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 0f50ae8e7e63..39c470e291f9 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -556,46 +556,6 @@
 			status = "disabled";
 		};
 
-		i2c0: i2c at ffc04000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,designware-i2c";
-			reg = <0xffc04000 0x1000>;
-			clocks = <&l4_sp_clk>;
-			interrupts = <0 158 0x4>;
-			status = "disabled";
-		};
-
-		i2c1: i2c at ffc05000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,designware-i2c";
-			reg = <0xffc05000 0x1000>;
-			clocks = <&l4_sp_clk>;
-			interrupts = <0 159 0x4>;
-			status = "disabled";
-		};
-
-		i2c2: i2c at ffc06000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,designware-i2c";
-			reg = <0xffc06000 0x1000>;
-			clocks = <&l4_sp_clk>;
-			interrupts = <0 160 0x4>;
-			status = "disabled";
-		};
-
-		i2c3: i2c at ffc07000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "snps,designware-i2c";
-			reg = <0xffc07000 0x1000>;
-			clocks = <&l4_sp_clk>;
-			interrupts = <0 161 0x4>;
-			status = "disabled";
-		};
-
 		gpio0: gpio at ff708000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -656,15 +616,44 @@
 			};
 		};
 
-		sdr: sdr at ffc25000 {
-			compatible = "syscon";
-			reg = <0xffc25000 0x1000>;
+		i2c0: i2c at ffc04000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc04000 0x1000>;
+			clocks = <&l4_sp_clk>;
+			interrupts = <0 158 0x4>;
+			status = "disabled";
 		};
 
-		sdramedac {
-			compatible = "altr,sdram-edac";
-			altr,sdr-syscon = <&sdr>;
-			interrupts = <0 39 4>;
+		i2c1: i2c at ffc05000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc05000 0x1000>;
+			clocks = <&l4_sp_clk>;
+			interrupts = <0 159 0x4>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at ffc06000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc06000 0x1000>;
+			clocks = <&l4_sp_clk>;
+			interrupts = <0 160 0x4>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at ffc07000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc07000 0x1000>;
+			clocks = <&l4_sp_clk>;
+			interrupts = <0 161 0x4>;
+			status = "disabled";
 		};
 
 		L2: l2-cache at fffef000 {
@@ -695,6 +684,29 @@
 			reg = <0xffff0000 0x10000>;
 		};
 
+		rst: rstmgr at ffd05000 {
+			#reset-cells = <1>;
+			compatible = "altr,rst-mgr";
+			reg = <0xffd05000 0x1000>;
+			altr,modrst-offset = <0x10>;
+		};
+
+		scu: snoop-control-unit at fffec000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0xfffec000 0x100>;
+		};
+
+		sdr: sdr at ffc25000 {
+			compatible = "syscon";
+			reg = <0xffc25000 0x1000>;
+		};
+
+		sdramedac {
+			compatible = "altr,sdram-edac";
+			altr,sdr-syscon = <&sdr>;
+			interrupts = <0 39 4>;
+		};
+
 		spi0: spi at fff00000 {
 			compatible = "snps,dw-apb-ssi";
 			#address-cells = <1>;
@@ -706,11 +718,6 @@
 			status = "disabled";
 		};
 
-		scu: snoop-control-unit at fffec000 {
-			compatible = "arm,cortex-a9-scu";
-			reg = <0xfffec000 0x100>;
-		};
-
 		spi1: spi at fff01000 {
 			compatible = "snps,dw-apb-ssi";
 			#address-cells = <1>;
@@ -722,6 +729,11 @@
 			status = "disabled";
 		};
 
+		sysmgr: sysmgr at ffd08000 {
+			compatible = "altr,sys-mgr", "syscon";
+			reg = <0xffd08000 0x4000>;
+		};
+
 		/* Local timer */
 		timer at fffec600 {
 			compatible = "arm,cortex-a9-twd-timer";
@@ -786,13 +798,6 @@
 			dma-names = "tx", "rx";
 		};
 
-		rst: rstmgr at ffd05000 {
-			#reset-cells = <1>;
-			compatible = "altr,rst-mgr";
-			reg = <0xffd05000 0x1000>;
-			altr,modrst-offset = <0x10>;
-		};
-
 		usbphy0: usbphy at 0 {
 			#phy-cells = <0>;
 			compatible = "usb-nop-xceiv";
@@ -836,10 +841,5 @@
 			clocks = <&osc1>;
 			status = "disabled";
 		};
-
-		sysmgr: sysmgr at ffd08000 {
-			compatible = "altr,sys-mgr", "syscon";
-			reg = <0xffd08000 0x4000>;
-		};
 	};
 };
-- 
2.6.1
