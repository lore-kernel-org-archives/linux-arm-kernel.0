From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 28 Mar 2013 11:13:27 +0530
Subject: [PATCH v4 5/6] ARM: dts: omap: update usb_otg_hs data
In-Reply-To: <1364449408-9510-1-git-send-email-kishon@ti.com>
References: <1364449408-9510-1-git-send-email-kishon@ti.com>
Message-ID: <1364449408-9510-6-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updated the usb_otg_hs dt data to include the *phy* and *phy-names*
binding in order for the driver to use the new generic PHY framework.
Also updated the Documentation to include the binding information.
The PHY binding information can be found at
Documentation/devicetree/bindings/phy/phy-bindings.txt

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/usb/omap-usb.txt |    5 +++++
 arch/arm/boot/dts/omap3.dtsi                       |    2 ++
 arch/arm/boot/dts/omap4.dtsi                       |    2 ++
 3 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
index abce256..9324e79 100644
--- a/Documentation/devicetree/bindings/usb/omap-usb.txt
+++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
@@ -19,6 +19,9 @@ OMAP MUSB GLUE
  - power : Should be "50". This signifies the controller can supply upto
    100mA when operating in host mode.
  - usb-phy : the phandle for the PHY device
+ - phys : the phandle for the PHY device (used by generic PHY framework)
+ - phy-names : the names of the PHY corresponding to the PHYs present in the
+   *phy* phandle.
 
 Optional properties:
  - ctrl-module : phandle of the control module this glue uses to write to
@@ -33,6 +36,8 @@ usb_otg_hs: usb_otg_hs at 4a0ab000 {
 	num_eps = <16>;
 	ram_bits = <12>;
 	ctrl-module = <&omap_control_usb>;
+	phys = <&usb2_phy>;
+	phy-names = "usb2-phy";
 };
 
 Board specific device node entry
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1e21565..dd7d2ff 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -405,6 +405,8 @@
 			interrupt-names = "mc", "dma";
 			ti,hwmods = "usb_otg_hs";
 			usb-phy = <&usb2_phy>;
+			phys = <&usb2_phy>;
+			phy-names = "usb2-phy";
 			multipoint = <1>;
 			num-eps = <16>;
 			ram-bits = <12>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 06d044e..b673f0f 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -550,6 +550,8 @@
 			interrupt-names = "mc", "dma";
 			ti,hwmods = "usb_otg_hs";
 			usb-phy = <&usb2_phy>;
+			phys = <&usb2_phy>;
+			phy-names = "usb2-phy";
 			multipoint = <1>;
 			num-eps = <16>;
 			ram-bits = <12>;
-- 
1.7.10.4
