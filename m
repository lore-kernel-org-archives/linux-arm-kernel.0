From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 23 Jun 2015 17:28:57 +0530
Subject: [PATCH 12/17] ARM: dts: dra7: Use "syscon-phy-power" instead of
 "ctrl-module" in USB PHY node
In-Reply-To: <1435060743-5511-1-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
Message-ID: <1435060743-5511-13-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
property from USB PHY devicetree nodes.

Since "omap_control_usb2phy1", "omap_control_usb3phy1" and
"omap_control_usb2phy2" devicetree nodes are no longer used, remove it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |   24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index a8ee829..e82ac00 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1196,24 +1196,6 @@
 			clocks = <&sys_32k_ck>;
 		};
 
-		omap_control_usb2phy1: control-phy at 4a002300 {
-			compatible = "ti,control-phy-usb2";
-			reg = <0x4a002300 0x4>;
-			reg-names = "power";
-		};
-
-		omap_control_usb3phy1: control-phy at 4a002370 {
-			compatible = "ti,control-phy-pipe3";
-			reg = <0x4a002370 0x4>;
-			reg-names = "power";
-		};
-
-		omap_control_usb2phy2: control-phy at 0x4a002e74 {
-			compatible = "ti,control-phy-usb2-dra7";
-			reg = <0x4a002e74 0x4>;
-			reg-names = "power";
-		};
-
 		/* OCP2SCP1 */
 		ocp2scp at 4a080000 {
 			compatible = "ti,omap-ocp2scp";
@@ -1226,7 +1208,7 @@
 			usb2_phy1: phy at 4a084000 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x400>;
-				ctrl-module = <&omap_control_usb2phy1>;
+				syscon-phy-power = <&dra7_ctrl_core 0x300>;
 				clocks = <&usb_phy1_always_on_clk32k>,
 					 <&usb_otg_ss1_refclk960m>;
 				clock-names =	"wkupclk",
@@ -1237,7 +1219,7 @@
 			usb2_phy2: phy at 4a085000 {
 				compatible = "ti,dra7x-usb2-phy2", "ti,omap-usb2";
 				reg = <0x4a085000 0x400>;
-				ctrl-module = <&omap_control_usb2phy2>;
+				syscon-phy-power = <&dra7_ctrl_general 0x74>;
 				clocks = <&usb_phy2_always_on_clk32k>,
 					 <&usb_otg_ss2_refclk960m>;
 				clock-names =	"wkupclk",
@@ -1251,7 +1233,7 @@
 				      <0x4a084800 0x64>,
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-				ctrl-module = <&omap_control_usb3phy1>;
+				syscon-phy-power = <&dra7_ctrl_core 0x370>;
 				clocks = <&usb_phy3_always_on_clk32k>,
 					 <&sys_clkin1>,
 					 <&usb_otg_ss1_refclk960m>;
-- 
1.7.9.5
