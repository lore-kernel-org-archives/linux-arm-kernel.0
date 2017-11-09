From: robh@kernel.org (Rob Herring)
Date: Thu,  9 Nov 2017 16:26:11 -0600
Subject: [PATCH 3/6] arm: dts: marvell: Add missing #phy-cells to usb-nop-xceiv
In-Reply-To: <20171109222614.5719-1-robh@kernel.org>
References: <20171109222614.5719-1-robh@kernel.org>
Message-ID: <20171109222614.5719-3-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"usb-nop-xceiv" is using the phy binding, but is missing #phy-cells
property. This is probably because the binding was the precursor to the phy
binding.

Fixes the following warning in Marvell dts files:

Warning (phys_property): Missing property '#phy-cells' in node ...

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Please apply to Marvell tree.

 arch/arm/boot/dts/armada-385-db-ap.dts          | 1 +
 arch/arm/boot/dts/armada-385-linksys.dtsi       | 1 +
 arch/arm/boot/dts/armada-385-synology-ds116.dts | 2 ++
 arch/arm/boot/dts/armada-388-gp.dts             | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
index 25d2d720dc0e..678aa023335d 100644
--- a/arch/arm/boot/dts/armada-385-db-ap.dts
+++ b/arch/arm/boot/dts/armada-385-db-ap.dts
@@ -236,6 +236,7 @@
 	usb3_phy: usb3_phy {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&reg_xhci0_vbus>;
+		#phy-cells = <0>;
 	};
 
 	reg_xhci0_vbus: xhci0-vbus {
diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index e1f355ffc8f7..434dc9aaa5e4 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -66,6 +66,7 @@
 	usb3_1_phy: usb3_1-phy {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&usb3_1_vbus>;
+		#phy-cells = <0>;
 	};
 
 	usb3_1_vbus: usb3_1-vbus {
diff --git a/arch/arm/boot/dts/armada-385-synology-ds116.dts b/arch/arm/boot/dts/armada-385-synology-ds116.dts
index 31510eb56f10..55a3c4870b8c 100644
--- a/arch/arm/boot/dts/armada-385-synology-ds116.dts
+++ b/arch/arm/boot/dts/armada-385-synology-ds116.dts
@@ -191,11 +191,13 @@
 	usb3_0_phy: usb3_0_phy {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&reg_usb3_0_vbus>;
+		#phy-cells = <0>;
 	};
 
 	usb3_1_phy: usb3_1_phy {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&reg_usb3_1_vbus>;
+		#phy-cells = <0>;
 	};
 
 	reg_usb3_0_vbus: usb3-vbus0 {
diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index f503955dbd3b..51b4ee6df130 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -276,11 +276,13 @@
 	usb2_1_phy: usb2_1_phy {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&reg_usb2_1_vbus>;
+		#phy-cells = <0>;
 	};
 
 	usb3_phy: usb3_phy {
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&reg_usb3_vbus>;
+		#phy-cells = <0>;
 	};
 
 	reg_usb3_vbus: usb3-vbus {
-- 
2.14.1
