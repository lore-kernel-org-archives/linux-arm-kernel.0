From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Wed, 19 Sep 2018 15:39:53 +0300
Subject: [PATCH] ARM: dts: at91: sama5d27_som1_ek: add adc regulators
Message-ID: <1537360793-10264-1-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add fixed regulators for the ADC. This board does not have
a programmable PMIC, but fixed regulators.
Adding them to DT so the ADC can probe correctly.

Tested-by: Swapna Gurumani <swapna.gurumani@microchip.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index e86e0c0..363a43d 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -283,6 +283,13 @@
 				status = "okay";
 			};
 
+			adc: adc at fc030000 {
+				vddana-supply = <&vddana>;
+				vref-supply = <&advref>;
+
+				status = "disabled";
+			};
+
 			pinctrl at fc038000 {
 
 				pinctrl_can1_default: can1_default {
@@ -549,4 +556,39 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	vddin_3v3: fixed-regulator-vddin_3v3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VDDIN_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		status = "okay";
+	};
+
+	vddana: fixed-regulator-vddana {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VDDANA";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vddin_3v3>;
+		status = "okay";
+	};
+
+	advref: fixed-regulator-advref {
+		compatible = "regulator-fixed";
+
+		regulator-name = "advref";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vddana>;
+		status = "okay";
+	};
 };
-- 
2.7.4
