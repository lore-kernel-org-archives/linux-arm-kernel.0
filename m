From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 10 Apr 2015 21:43:14 +0100
Subject: [PATCH v3 02/11] ARM: dts: apq8064-ifc6410: Add basic regulators
In-Reply-To: <1428698491-11881-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1428698491-11881-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1428698594-11988-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to basic regulators wiredup on IFC6410 board.

All these regulators are tested as part of USB, SATA and HDMI.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 67 ++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index e641001..ca2d7ba 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -23,6 +23,73 @@
 			};
 		};
 
+		rpm at 108000 {
+			regulators {
+				vin_lvs1_3_6-supply = <&pm8921_s4>;
+				vin_lvs2-supply = <&pm8921_s1>;
+				vin_lvs4_5_7-supply = <&pm8921_s4>;
+
+				vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
+				vdd_l24-supply = <&pm8921_s1>;
+				vdd_l25-supply = <&pm8921_s1>;
+				vdd_l26-supply = <&pm8921_s7>;
+				vdd_l27-supply = <&pm8921_s7>;
+				vdd_l28-supply = <&pm8921_s7>;
+
+
+				/* Buck SMPS */
+				pm8921_s1: s1 {
+					regulator-always-on;
+					regulator-min-microvolt = <1225000>;
+					regulator-max-microvolt = <1225000>;
+					qcom,switch-mode-frequency = <3200000>;
+					bias-pull-down;
+				};
+
+				pm8921_s3: s3 {
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1400000>;
+					qcom,switch-mode-frequency = <4800000>;
+				};
+
+				pm8921_s4: s4 {
+					regulator-min-microvolt	= <1800000>;
+					regulator-max-microvolt	= <1800000>;
+					qcom,switch-mode-frequency = <3200000>;
+				};
+
+				pm8921_s7: s7 {
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1300000>;
+					qcom,switch-mode-frequency = <3200000>;
+				};
+
+				pm8921_l3: l3 {
+					regulator-min-microvolt = <3050000>;
+					regulator-max-microvolt = <3300000>;
+					bias-pull-down;
+				};
+
+				pm8921_l4: l4 {
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1800000>;
+					bias-pull-down;
+				};
+
+				pm8921_l6: l6 {
+					regulator-min-microvolt = <2950000>;
+					regulator-max-microvolt = <2950000>;
+					bias-pull-down;
+				};
+
+				pm8921_l23: l23 {
+					regulator-min-microvolt = <1700000>;
+					regulator-max-microvolt = <1900000>;
+					bias-pull-down;
+				};
+			};
+		};
+
 		gsbi at 12440000 {
 			status = "okay";
 			qcom,mode = <GSBI_PROT_I2C>;
-- 
1.9.1
