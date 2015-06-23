From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 23 Jun 2015 17:28:58 +0530
Subject: [PATCH 13/17] ARM: dts: am4372: Use "syscon-phy-power" instead of
 "ctrl-module" in USB PHY node
In-Reply-To: <1435060743-5511-1-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
Message-ID: <1435060743-5511-14-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
property from USB PHY device tree node.

Since "am43xx_control_usb2phy1" and "am43xx_control_usb2phy2"
devicetree nodes are no longer used, remove it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c80a3e2..0754e0da 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -796,18 +796,6 @@
 			status = "disabled";
 		};
 
-		am43xx_control_usb2phy1: control-phy at 44e10620 {
-			compatible = "ti,control-phy-usb2-am437";
-			reg = <0x44e10620 0x4>;
-			reg-names = "power";
-		};
-
-		am43xx_control_usb2phy2: control-phy at 0x44e10628 {
-			compatible = "ti,control-phy-usb2-am437";
-			reg = <0x44e10628 0x4>;
-			reg-names = "power";
-		};
-
 		ocp2scp0: ocp2scp at 483a8000 {
 			compatible = "ti,am437x-ocp2scp", "ti,omap-ocp2scp";
 			#address-cells = <1>;
@@ -818,7 +806,7 @@
 			usb2_phy1: phy at 483a8000 {
 				compatible = "ti,am437x-usb2";
 				reg = <0x483a8000 0x8000>;
-				ctrl-module = <&am43xx_control_usb2phy1>;
+				syscon-phy-power = <&scm_conf 0x620>;
 				clocks = <&usb_phy0_always_on_clk32k>,
 					 <&usb_otg_ss0_refclk960m>;
 				clock-names = "wkupclk", "refclk";
@@ -837,7 +825,7 @@
 			usb2_phy2: phy at 483e8000 {
 				compatible = "ti,am437x-usb2";
 				reg = <0x483e8000 0x8000>;
-				ctrl-module = <&am43xx_control_usb2phy2>;
+				syscon-phy-power = <&scm_conf 0x628>;
 				clocks = <&usb_phy1_always_on_clk32k>,
 					 <&usb_otg_ss1_refclk960m>;
 				clock-names = "wkupclk", "refclk";
-- 
1.7.9.5
