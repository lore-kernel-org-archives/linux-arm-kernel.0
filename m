From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 May 2016 15:45:58 -0700
Subject: [PATCH 1/2] ARM: dts: qcom: Enable RPM regulators on apq8074
 dragonboard
Message-ID: <20160510224559.17568-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the appropriate min/max voltages for the regulators on the
apq8074 dragonboard so that they can be used by clients properly.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts | 199 +++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index c0e205315042..8d1011d289bc 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -75,4 +75,203 @@
 			};
 		};
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
+						regulator-min-microvolt = <1225000>;
+						regulator-max-microvolt = <1225000>;
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
+					l10 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+						regulator-always-on;
+					};
+
+					l11 {
+						regulator-min-microvolt = <1300000>;
+						regulator-max-microvolt = <1300000>;
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
+						regulator-always-on;
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
+						regulator-min-microvolt = <3000000>;
+						regulator-max-microvolt = <3000000>;
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
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
