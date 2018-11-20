From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 20 Nov 2018 14:53:10 +0800
Subject: [PATCH 2/3] arm64: dts: allwinner: h6: orangepi: Enable USB 2.0 host
 and OTG ports
In-Reply-To: <20181120065311.30009-1-wens@csie.org>
References: <20181120065311.30009-1-wens@csie.org>
Message-ID: <20181120065311.30009-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Orange Pi Lite 2 and Orange Pi One Plus share the same design for
their USB 2.0 ports. VBUS is directly tied to the board wide 5V rail,
which is also directly tied to the DC jack. There is no current limiting
in this design.

This patch enables all the USB 2.0 related device nodes, and sets the
VBUS regulator supplies and OTG ID detection GPIO.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index f910d5eb9267..f16b7ffbe797 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -32,6 +32,14 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -41,6 +49,14 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
 &r_i2c {
 	status = "okay";
 
@@ -165,3 +181,15 @@
 	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
+
+&usb2otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb2phy {
+	usb0_id_det-gpios = <&pio 2 6 GPIO_ACTIVE_HIGH>; /* PC6 */
+	usb0_vbus-supply = <&reg_vcc5v>;
+	usb3_vbus-supply = <&reg_vcc5v>;
+	status = "okay";
+};
-- 
2.19.1
