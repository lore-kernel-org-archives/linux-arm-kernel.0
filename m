From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 23 Jun 2015 17:29:01 +0530
Subject: [PATCH 16/17] ARM: dts: omap4: Use "syscon-phy-power" instead of
 "ctrl-module" in USB PHY node
In-Reply-To: <1435060743-5511-1-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
Message-ID: <1435060743-5511-17-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
property from USB PHY dt node.

Since "omap_control_usb2phy" devicetree node is no longer used,
remove it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index f884d6a..d0e0960 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -701,7 +701,7 @@
 			usb2_phy: usb2phy at 4a0ad080 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a0ad080 0x58>;
-				ctrl-module = <&omap_control_usb2phy>;
+				syscon-phy-power = <&scm_conf 0x300>;
 				clocks = <&usb_phy_cm_clk32k>;
 				clock-names = "wkupclk";
 				#phy-cells = <0>;
@@ -852,12 +852,6 @@
 			};
 		};
 
-		omap_control_usb2phy: control-phy at 4a002300 {
-			compatible = "ti,control-phy-usb2";
-			reg = <0x4a002300 0x4>;
-			reg-names = "power";
-		};
-
 		omap_control_usbotg: control-phy at 4a00233c {
 			compatible = "ti,control-phy-otghs";
 			reg = <0x4a00233c 0x4>;
-- 
1.7.9.5
