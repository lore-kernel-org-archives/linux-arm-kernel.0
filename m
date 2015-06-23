From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 23 Jun 2015 17:28:59 +0530
Subject: [PATCH 14/17] ARM: dts: OMAP5: Use "syscon-phy-power" instead of
 "ctrl-module" in USB PHY node
In-Reply-To: <1435060743-5511-1-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
Message-ID: <1435060743-5511-15-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
property from USB PHY devicetree node.

Since "omap_control_usb2phy" and "omap_control_usb3phy" devicetree nodes
are no longer used, remove it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 7d24ae0..9b50314 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -846,18 +846,6 @@
 			hw-caps-temp-alert;
 		};
 
-		omap_control_usb2phy: control-phy at 4a002300 {
-			compatible = "ti,control-phy-usb2";
-			reg = <0x4a002300 0x4>;
-			reg-names = "power";
-		};
-
-		omap_control_usb3phy: control-phy at 4a002370 {
-			compatible = "ti,control-phy-pipe3";
-			reg = <0x4a002370 0x4>;
-			reg-names = "power";
-		};
-
 		usb3: omap_dwc3 at 4a020000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss";
@@ -888,7 +876,7 @@
 			usb2_phy: usb2phy at 4a084000 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x7c>;
-				ctrl-module = <&omap_control_usb2phy>;
+				syscon-phy-power = <&scm_conf 0x300>;
 				clocks = <&usb_phy_cm_clk32k>, <&usb_otg_ss_refclk960m>;
 				clock-names = "wkupclk", "refclk";
 				#phy-cells = <0>;
@@ -900,7 +888,7 @@
 				      <0x4a084800 0x64>,
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-				ctrl-module = <&omap_control_usb3phy>;
+				syscon-phy-power = <&scm_conf 0x370>;
 				clocks = <&usb_phy_cm_clk32k>,
 					 <&sys_clkin>,
 					 <&usb_otg_ss_refclk960m>;
-- 
1.7.9.5
