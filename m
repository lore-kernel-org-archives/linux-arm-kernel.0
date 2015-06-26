From: bjorn@kryo.se (bjorn at kryo.se)
Date: Fri, 26 Jun 2015 14:50:19 -0700
Subject: [PATCH v2 11/11] ARM: dts: xperia-honami: Add regulator nodes for
 Honami
In-Reply-To: <1435355419-23602-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1435355419-23602-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1435355419-23602-12-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   | 199 +++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index bd35b06..49605ca 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -10,10 +10,209 @@
 		reg = <0 0x40000000>, <0x40000000 0x40000000>;
 		device_type = "memory";
 	};
+
+	smd {
+		rpm {
+			rpm_requests {
+				pm8941-regulators {
+					vdd_l1_l3-supply = <&pm8941_s1>;
+					vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
+					vdd_l4_l11-supply = <&pm8941_s1>;
+					vdd_l5_l7-supply = <&pm8941_s2>;
+					vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
+					vdd_l9_l10_l17_l22-supply = <&vreg_boost_bypass>;
+					vdd_l13_l20_l23_l24-supply = <&vreg_boost_bypass>;
+					vdd_l21-supply = <&vreg_boost_bypass>;
+					vin_5vs-supply = <&pm8941_5v>;
+
+					s1 {
+						regulator-min-microvolt = <1300000>;
+						regulator-max-microvolt = <1300000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					s2 {
+						regulator-min-microvolt = <2150000>;
+						regulator-max-microvolt = <2150000>;
+						regulator-boot-on;
+					};
+
+					s3 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					s4 {
+						regulator-min-microvolt = <5000000>;
+						regulator-max-microvolt = <5000000>;
+					};
+
+					l1 {
+						regulator-min-microvolt = <1225000>;
+						regulator-max-microvolt = <1225000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					l2 {
+						regulator-min-microvolt = <1200000>;
+						regulator-max-microvolt = <1200000>;
+					};
+
+					l3 {
+						regulator-min-microvolt = <1200000>;
+						regulator-max-microvolt = <1200000>;
+					};
+
+					l4 {
+						regulator-min-microvolt = <1225000>;
+						regulator-max-microvolt = <1225000>;
+					};
+
+					l5 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+					};
+
+					l6 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+						regulator-boot-on;
+					};
+
+					l7 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+						regulator-boot-on;
+					};
+
+					l8 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+					};
+
+					l9 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <2950000>;
+					};
+
+					l11 {
+						regulator-min-microvolt = <1300000>;
+						regulator-max-microvolt = <1350000>;
+					};
+
+					l12 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+						regulator-boot-on;
+					};
+
+					l13 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <2950000>;
+						regulator-boot-on;
+					};
+
+					l14 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+					};
+
+					l15 {
+						regulator-min-microvolt = <2050000>;
+						regulator-max-microvolt = <2050000>;
+					};
+
+					l16 {
+						regulator-min-microvolt = <2700000>;
+						regulator-max-microvolt = <2700000>;
+					};
+
+					l17 {
+						regulator-min-microvolt = <2700000>;
+						regulator-max-microvolt = <2700000>;
+					};
+
+					l18 {
+						regulator-min-microvolt = <2850000>;
+						regulator-max-microvolt = <2850000>;
+					};
+
+					l19 {
+						regulator-min-microvolt = <3300000>;
+						regulator-max-microvolt = <3300000>;
+					};
+
+					l20 {
+						regulator-min-microvolt = <2950000>;
+						regulator-max-microvolt = <2950000>;
+						regulator-boot-on;
+					};
+
+					l21 {
+						regulator-min-microvolt = <2950000>;
+						regulator-max-microvolt = <2950000>;
+						regulator-boot-on;
+					};
+
+					l22 {
+						regulator-min-microvolt = <3000000>;
+						regulator-max-microvolt = <3000000>;
+					};
+
+					l23 {
+						regulator-min-microvolt = <2800000>;
+						regulator-max-microvolt = <2800000>;
+					};
+
+					l24 {
+						regulator-min-microvolt = <3075000>;
+						regulator-max-microvolt = <3075000>;
+						regulator-boot-on;
+					};
+				};
+			};
+		};
+	};
+
+	vreg_boost_bypass: vreg-boost-bypass {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vreg-boost-bypass";
+		regulator-min-microvolt = <3150000>;
+		regulator-max-microvolt = <3150000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		gpio = <&pm8941_gpios 21 0>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&boost_bypass_en>;
+
+     };
 };
 
 &soc {
 	serial at f991e000 {
 		status = "ok";
 	};
+
+};
+
+&spmi_bus {
+	pm8941 at 0 {
+		gpios at c000 {
+			boost_bypass_en: boost-bypass-en {
+				always-on {
+					pins = "gpio21";
+					function = "normal";
+				};
+			};
+		};
+	};
 };
-- 
1.9.3 (Apple Git-50)
