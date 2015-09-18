From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 18 Sep 2015 13:30:13 +0100
Subject: [PATCH 01/14] ARM: dts: apq8064: remove redundant i2c pinctrl
 properties
In-Reply-To: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1442579413-19865-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes i2c pinctrl properties from board which which are now
mentioned in the SOC specific file. This will avoid redundant properties
across multiple board fiiles.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 11 -----------
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts  |  5 -----
 arch/arm/boot/dts/qcom-apq8064.dtsi         |  4 ++++
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index 47c0282..80ab5b8 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -13,15 +13,6 @@
 	};
 
 	soc {
-		pinctrl at 800000 {
-			i2c1_pins: i2c1 {
-				mux {
-					pins = "gpio20", "gpio21";
-					function = "gsbi1";
-				};
-			};
-		};
-
 		rpm at 108000 {
 			regulators {
 				vin_lvs1_3_6-supply = <&pm8921_s4>;
@@ -96,8 +87,6 @@
 			i2c at 12460000 {
 				status = "okay";
 				clock-frequency = <200000>;
-				pinctrl-0 = <&i2c1_pins>;
-				pinctrl-names = "default";
 
 				eeprom: eeprom at 50 {
 					compatible = "24c02";
diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index f3100da..b701f33 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -119,8 +119,6 @@
 			qcom,mode = <GSBI_PROT_I2C>;
 			i2c3: i2c at 16280000 {
 				status = "okay";
-				pinctrl-0 = <&i2c3_pins>;
-				pinctrl-names = "default";
 			};
 		};
 
@@ -131,8 +129,6 @@
 			i2c at 12460000 {
 				status = "okay";
 				clock-frequency = <200000>;
-				pinctrl-0 = <&i2c1_pins>;
-				pinctrl-names = "default";
 
 				eeprom: eeprom at 52 {
 					compatible = "atmel,24c128";
@@ -148,7 +144,6 @@
 
 			serial at 16540000 {
 				status = "ok";
-
 				pinctrl-names = "default";
 				pinctrl-0 = <&uart_pins>;
 			};
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index d2e94d6..53d5311 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -213,6 +213,8 @@
 
 			i2c1: i2c at 12460000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
+				pinctrl-0 = <&i2c1_pins>;
+				pinctrl-names = "default";
 				reg = <0x12460000 0x1000>;
 				interrupts = <0 194 IRQ_TYPE_NONE>;
 				clocks = <&gcc GSBI1_QUP_CLK>, <&gcc GSBI1_H_CLK>;
@@ -258,6 +260,8 @@
 			ranges;
 			i2c3: i2c at 16280000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
+				pinctrl-0 = <&i2c3_pins>;
+				pinctrl-names = "default";
 				reg = <0x16280000 0x1000>;
 				interrupts = <GIC_SPI 151 IRQ_TYPE_NONE>;
 				clocks = <&gcc GSBI3_QUP_CLK>,
-- 
1.9.1
