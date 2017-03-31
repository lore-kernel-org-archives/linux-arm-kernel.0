From: alex@asyring.de (Alexander Syring)
Date: Fri, 31 Mar 2017 15:58:37 +0200
Subject: [PATCH] ARM: sun7i: Cubietruck: enable ACIN und USB power supply
 subnode
Message-ID: <20170331135837.24763-1-alex@asyring.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cubietruck has an AXP209 PMIC and can be power-supplied by ACIN via
 the CHG-IN pin or by USB.

This enables the ACIN and the USB power supply subnode in the DT.

Signed-off-by: Alexander Syring <alex@asyring.de>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index feb995d29799..98431ef15bc9 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -267,6 +267,10 @@

 #include "axp209.dtsi"

+&ac_power_supply {
+	status = "okay";
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
@@ -323,6 +327,10 @@
 	status = "okay";
 };

+&usb_power_supply {
+	status = "okay";
+};
+
 &usbphy {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
@@ -333,3 +341,4 @@
 	usb2_vbus-supply = <&reg_usb2_vbus>;
 	status = "okay";
 };
+
--
2.11.0
