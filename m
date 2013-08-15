From: rogerq@ti.com (Roger Quadros)
Date: Thu, 15 Aug 2013 16:15:12 +0300
Subject: [PATCH v2 8/8] ARM: dts: omap5: update omap-control-usb node
In-Reply-To: <1376572512-9561-1-git-send-email-rogerq@ti.com>
References: <1376572512-9561-1-git-send-email-rogerq@ti.com>
Message-ID: <1376572512-9561-9-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split USB2 PHY and USB3 PHY into separate omap-control-usb
nodes. Get rid of "ti,type" property.

CC: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 07be2cd..7cda18b 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -626,12 +626,16 @@
 			hw-caps-temp-alert;
 		};
 
-		omap_control_usb: omap-control-usb at 4a002300 {
-			compatible = "ti,omap-control-usb";
-			reg = <0x4a002300 0x4>,
-			      <0x4a002370 0x4>;
-			reg-names = "control_dev_conf", "phy_power_usb";
-			ti,type = <2>;
+		omap_control_usb2phy: omap-control-usb at 4a002300 {
+			compatible = "ti,usb2-control-usb";
+			reg = <0x4a002300 0x4>;
+			reg-names = "power";
+		};
+
+		omap_control_usb3phy: omap-control-usb at 0x4a002370 {
+			compatible = "ti,usb3-control-usb";
+			reg = <0x4a002370 0x4>;
+			reg-names = "power";
 		};
 
 		omap_dwc3 at 4a020000 {
@@ -661,7 +665,7 @@
 			usb2_phy: usb2phy at 4a084000 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x7c>;
-				ctrl-module = <&omap_control_usb>;
+				ctrl-module = <&omap_control_usb2phy>;
 			};
 
 			usb3_phy: usb3phy at 4a084400 {
@@ -670,7 +674,7 @@
 				      <0x4a084800 0x64>,
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-				ctrl-module = <&omap_control_usb>;
+				ctrl-module = <&omap_control_usb3phy>;
 			};
 		};
 
-- 
1.7.4.1
