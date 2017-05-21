From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sun, 21 May 2017 14:48:55 +0200
Subject: [PATCH 06/13] ARM: dts: armada-385-linksys: usb3 label cleanup
In-Reply-To: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
Message-ID: <20170521124903.11050-7-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we use the reference for the USB3.0 port update the node name
and labels for the phy and vbus to match the label used by
armada-38x.dtsi.

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

---

Notes:

  Going by documentation regulator-name is only of informative nature so
  changing it should be a non issue.
---
 arch/arm/boot/dts/armada-385-linksys.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 932fca4..6cc1ec7 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -63,16 +63,16 @@
 			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
 	};
 
-	usb3_phy: usb3_phy {
+	usb3_1_phy: usb3_1-phy {
 		compatible = "usb-nop-xceiv";
-		vcc-supply = <&reg_xhci0_vbus>;
+		vcc-supply = <&usb3_1_vbus>;
 	};
 
-	reg_xhci0_vbus: xhci0-vbus {
+	usb3_1_vbus: usb3_1-vbus {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-		pinctrl-0 = <&xhci0_vbus_pins>;
-		regulator-name = "xhci0-vbus";
+		pinctrl-0 = <&usb3_1_vbus_pins>;
+		regulator-name = "usb3_1-vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
@@ -371,7 +371,7 @@
 		marvell,function = "gpio";
 	};
 
-	xhci0_vbus_pins: xhci0-vbus-pins {
+	usb3_1_vbus_pins: usb3_1-vbus-pins {
 		marvell,pins = "mpp50";
 		marvell,function = "gpio";
 	};
@@ -393,5 +393,5 @@
 
 &usb3_1 {
 	status = "okay";
-	usb-phy = <&usb3_phy>;
+	usb-phy = <&usb3_1_phy>;
 };
-- 
2.10.2
