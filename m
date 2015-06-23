From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 23 Jun 2015 17:29:02 +0530
Subject: [PATCH 17/17] ARM: dts: omap4: Use "syscon-otghs" instead of
 "ctrl-module" in USB node
In-Reply-To: <1435060743-5511-1-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
Message-ID: <1435060743-5511-18-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "syscon-otghs" property and remove the deprecated "ctrl-module"
property from MUSB devicetree node.

Since "omap_control_usbotg" devicetree node is no longer used, remove
it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d0e0960..3bc77b1 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -852,12 +852,6 @@
 			};
 		};
 
-		omap_control_usbotg: control-phy at 4a00233c {
-			compatible = "ti,control-phy-otghs";
-			reg = <0x4a00233c 0x4>;
-			reg-names = "otghs_control";
-		};
-
 		usb_otg_hs: usb_otg_hs at 4a0ab000 {
 			compatible = "ti,omap4-musb";
 			reg = <0x4a0ab000 0x7ff>;
@@ -870,7 +864,7 @@
 			multipoint = <1>;
 			num-eps = <16>;
 			ram-bits = <12>;
-			ctrl-module = <&omap_control_usbotg>;
+			syscon-otghs = <&scm_conf 0x33c>;
 		};
 
 		aes: aes at 4b501000 {
-- 
1.7.9.5
