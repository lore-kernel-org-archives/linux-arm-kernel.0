From: robh@kernel.org (Rob Herring)
Date: Thu,  9 Nov 2017 16:26:14 -0600
Subject: [PATCH 6/6] arm: dts: am33xx: Add missing #phy-cells to ti,
 am335x-usb-phy
In-Reply-To: <20171109222614.5719-1-robh@kernel.org>
References: <20171109222614.5719-1-robh@kernel.org>
Message-ID: <20171109222614.5719-6-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"ti,am335x-usb-phy" is using the phy binding, but is missing #phy-cells
property. Fixes the following warning in TI dts files:

Warning (phys_property): Missing property '#phy-cells' in node ...

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org
---
Please apply to TI tree.

 Documentation/devicetree/bindings/usb/am33xx-usb.txt | 2 ++
 arch/arm/boot/dts/am33xx.dtsi                        | 2 ++
 arch/arm/boot/dts/dm814x.dtsi                        | 1 +
 3 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index 7a33f22c815a..7a198a30408a 100644
--- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
@@ -95,6 +95,7 @@ usb: usb at 47400000 {
 		reg = <0x47401300 0x100>;
 		reg-names = "phy";
 		ti,ctrl_mod = <&ctrl_mod>;
+		#phy-cells = <0>;
 	};
 
 	usb0: usb at 47401000 {
@@ -141,6 +142,7 @@ usb: usb at 47400000 {
 		reg = <0x47401b00 0x100>;
 		reg-names = "phy";
 		ti,ctrl_mod = <&ctrl_mod>;
+		#phy-cells = <0>;
 	};
 
 	usb1: usb at 47401800 {
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 7d7ca054c557..a39465a67ca2 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -626,6 +626,7 @@
 				reg-names = "phy";
 				status = "disabled";
 				ti,ctrl_mod = <&usb_ctrl_mod>;
+				#phy-cells = <0>;
 			};
 
 			usb0: usb at 47401000 {
@@ -674,6 +675,7 @@
 				reg-names = "phy";
 				status = "disabled";
 				ti,ctrl_mod = <&usb_ctrl_mod>;
+				#phy-cells = <0>;
 			};
 
 			usb1: usb at 47401800 {
diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 9708157f5daf..b7a11c1168d1 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -75,6 +75,7 @@
 				reg = <0x47401300 0x100>;
 				reg-names = "phy";
 				ti,ctrl_mod = <&usb_ctrl_mod>;
+				#phy-cells = <0>;
 			};
 
 			usb0: usb at 47401000 {
-- 
2.14.1
