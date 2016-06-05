From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun,  5 Jun 2016 13:51:06 +0000
Subject: [PATCH RFT 2/4] ARM: dts: imx28-eukrea-mbmx28lc: add missing reg
 properties
Message-ID: <1465134666-13459-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing reg properties for the regulator nodes
in order to fix the dtc warnings.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi b/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
index 8859474..581e85f 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
@@ -84,6 +84,7 @@
 
 		reg_3p3v: regulator at 0 {
 			compatible = "regulator-fixed";
+			reg = <0>;
 			regulator-name = "3P3V";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
@@ -92,6 +93,7 @@
 
 		reg_lcd_3v3: regulator at 1 {
 			compatible = "regulator-fixed";
+			reg = <1>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&reg_lcd_3v3_pins_mbmx28lc>;
 			regulator-name = "lcd-3v3";
@@ -103,6 +105,7 @@
 
 		reg_usb0_vbus: regulator at 2 {
 			compatible = "regulator-fixed";
+			reg = <2>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&reg_usb0_vbus_pins_mbmx28lc>;
 			regulator-name = "usb0_vbus";
@@ -114,6 +117,7 @@
 
 		reg_usb1_vbus: regulator at 3 {
 			compatible = "regulator-fixed";
+			reg = <3>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&reg_usb1_vbus_pins_mbmx28lc>;
 			regulator-name = "usb1_vbus";
-- 
1.7.9.5
