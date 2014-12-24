From: walter@vanguardiasur.com.ar (Walter Lozano)
Date: Wed, 24 Dec 2014 20:11:52 -0300
Subject: [PATCH v2] ARM: socfpga: dts: Add adxl34x
Message-ID: <1419462712-14151-1-git-send-email-walter@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the DTS bindings for the adxl34x digital
accelerometer.

Signed-off-by: Walter Lozano <walter@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index 16ea6f5..d343e03 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -60,6 +60,22 @@
 	rxc-skew-ps = <2000>;
 };
 
+&gpio2 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	accel1: accelerometer at 53 {
+		compatible = "adxl34x";
+		reg = <0x53>;
+
+		interrupt-parent = <&portc>;
+		interrupts = <3 2>;
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&regulator_3_3v>;
 	vqmmc-supply = <&regulator_3_3v>;
-- 
1.7.10.4
