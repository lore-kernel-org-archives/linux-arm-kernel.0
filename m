From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 20 Oct 2015 21:57:45 -0700
Subject: [PATCH 2/7] ARM: dts: qcom: msm8974-honami: Add regulator nodes for
 Honami
In-Reply-To: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1445403470-17434-2-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---

This patch was previously submitted standalone, minor updates has been
done to correct the 8841 voltage ranges and the logic surrounding
vreg_boost.

l20 is marked for 200mA current consumption to force the eMMC supply
into HPM, to allow reliable mounting.

 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   | 226 +++++++++++++++++++++
 1 file changed, 226 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index 6f7e4ef4ccf7..5768c97bb124 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -1,6 +1,8 @@
 #include "qcom-msm8974.dtsi"
 #include "qcom-pm8841.dtsi"
 #include "qcom-pm8941.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
 	model = "Sony Xperia Z1";
@@ -18,6 +20,223 @@
 		reg = <0 0x40000000>, <0x40000000 0x40000000>;
 		device_type = "memory";
 	};
+
+	smd {
+		rpm {
+			rpm_requests {
+				pm8841-regulators {
+					s1 {
+						regulator-min-microvolt = <675000>;
+						regulator-max-microvolt = <1050000>;
+					};
+
+					s2 {
+						regulator-min-microvolt = <500000>;
+						regulator-max-microvolt = <1050000>;
+					};
+
+					s3 {
+						regulator-min-microvolt = <500000>;
+						regulator-max-microvolt = <1050000>;
+					};
+
+					s4 {
+						regulator-min-microvolt = <500000>;
+						regulator-max-microvolt = <1050000>;
+					};
+				};
+
+				pm8941-regulators {
+					vdd_l1_l3-supply = <&pm8941_s1>;
+					vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
+					vdd_l4_l11-supply = <&pm8941_s1>;
+					vdd_l5_l7-supply = <&pm8941_s2>;
+					vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
+					vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
+					vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
+					vdd_l21-supply = <&vreg_boost>;
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
+
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
+
+						regulator-boot-on;
+					};
+
+					l7 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+
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
+
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					l13 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <2950000>;
+
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
+
+						regulator-allow-set-load;
+						regulator-boot-on;
+						regulator-system-load = <200000>;
+					};
+
+					l21 {
+						regulator-min-microvolt = <2950000>;
+						regulator-max-microvolt = <2950000>;
+
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
+
+						regulator-boot-on;
+					};
+				};
+			};
+		};
+	};
+
+	vreg_boost: vreg-boost {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vreg-boost";
+		regulator-min-microvolt = <3150000>;
+		regulator-max-microvolt = <3150000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		gpio = <&pm8941_gpios 21 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&boost_bypass_n_pin>;
+     };
 };
 
 &soc {
@@ -51,6 +270,13 @@
 
 &spmi_bus {
 	pm8941 at 0 {
+		gpios at c000 {
+			boost_bypass_n_pin: boost-bypass {
+				pins = "gpio21";
+				function = "normal";
+			};
+		};
+
 		coincell at 2800 {
 			status = "ok";
 			qcom,rset-ohms = <2100>;
-- 
2.4.2
