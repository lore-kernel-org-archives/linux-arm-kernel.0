From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Mon, 21 Nov 2016 17:49:11 +0100
Subject: [PATCH] ARM: dts: sunxi: Enable UEXT related nodes for Olimex A20 SOM
 EVB
Message-ID: <20161121164911.76900-1-manu@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UEXT are Universal EXTension connector from Olimex. They embed i2c, spi
and uart pins along power in one connector and are found on most,
if not all, Olimex boards.
The Olimex A20 SOM EVB have two UEXT connector so enable the nodes found on
those two connectors.

Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>
---
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index 23aacce..e879c119 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -116,6 +116,18 @@
 	};
 };
 
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+};
+
 &lradc {
 	vref-supply = <&reg_vcc3v0>;
 	status = "okay";
@@ -284,12 +296,36 @@
 	status = "okay";
 };
 
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins_a>,
+		<&spi1_cs0_pins_a>;
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins_a>,
+		<&spi2_cs0_pins_a>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
 	status = "okay";
 };
 
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart6_pins_a>;
+	status = "okay";
+};
+
+&uart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart7_pins_a>;
+	status = "okay";
+};
+
 &usb_otg {
 	dr_mode = "otg";
 	status = "okay";
-- 
2.9.2
