From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 12 Apr 2016 10:33:54 +0100
Subject: [PATCH v2 05/13] ARM: dts: db600c: add pmic regulator supplies
In-Reply-To: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1460453642-5809-6-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pmic regulator supplies connected on the board.
Rest of the invidual regulators would be added as and when required by
the devices.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts | 62 +++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
index 57d4500..6695b00 100644
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
@@ -9,7 +9,69 @@
 		serial1 = &gsbi1_serial;
 	};
 
+	regulators {
+		compatible = "simple-bus";
+		vph: regulator-fixed at 1 {
+			compatible = "regulator-fixed";
+			regulator-min-microvolt = <4500000>;
+			regulator-max-microvolt = <4500000>;
+			regulator-name = "VPH";
+			regulator-type = "voltage";
+			regulator-boot-on;
+		};
+	};
+
 	soc {
+		rpm at 108000 {
+			regulators {
+				vdd_s1-supply = <&vph>;
+				vdd_s2-supply = <&vph>;
+				vdd_s3-supply = <&vph>;
+				vdd_s4-supply = <&vph>;
+				vdd_s5-supply = <&vph>;
+				vdd_s6-supply = <&vph>;
+				vdd_s7-supply = <&vph>;
+				vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
+				vdd_l3_l15_l17-supply = <&vph>;
+				vdd_l4_l14-supply = <&vph>;
+				vdd_l5_l8_l16-supply = <&vph>;
+				vdd_l6_l7-supply = <&vph>;
+				vdd_l9_l11-supply = <&vph>;
+				vdd_l10_l22-supply = <&vph>;
+				vdd_l21_l23_l29-supply = <&vph>;
+				vdd_l24-supply = <&pm8921_s1>;
+				vdd_l25-supply = <&pm8921_s1>;
+				vdd_l26-supply = <&pm8921_s7>;
+				vdd_l27-supply = <&pm8921_s7>;
+				vdd_l28-supply = <&pm8921_s7>;
+				vin_lvs1_3_6-supply = <&pm8921_s4>;
+				vin_lvs2-supply = <&pm8921_s1>;
+				vin_lvs4_5_7-supply = <&pm8921_s4>;
+
+				s1 {
+					regulator-always-on;
+					regulator-min-microvolt = <1225000>;
+					regulator-max-microvolt = <1225000>;
+					qcom,switch-mode-frequency = <3200000>;
+					bias-pull-down;
+				};
+
+				s4 {
+					regulator-min-microvolt	= <1800000>;
+					regulator-max-microvolt	= <1800000>;
+					qcom,switch-mode-frequency = <3200000>;
+					bias-pull-down;
+					regulator-always-on;
+				};
+
+				s7 {
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1300000>;
+					qcom,switch-mode-frequency = <3200000>;
+				 };
+			};
+		};
+
 		gsbi at 12440000 {
 			status = "okay";
 			qcom,mode = <GSBI_PROT_UART_W_FC>;
-- 
2.5.0
