From: vkoul@kernel.org (Vinod Koul)
Date: Fri,  9 Nov 2018 15:14:04 +0530
Subject: [PATCH v5 05/18] arm64: dts: qcom: qcs404: Add PMS405 RPM regulators
In-Reply-To: <20181109094417.12109-1-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
Message-ID: <20181109094417.12109-6-vkoul@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add the RPM regulators found in PMS405 which is used in qcs404-evb

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 97 ++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 91ecbdf0ecda..d1ba8b8ece46 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -11,4 +11,101 @@
 	chosen {
 		stdout-path = "serial0";
 	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&rpm_requests {
+	pms405-regulators {
+		compatible = "qcom,rpm-pms405-regulators";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-l1-l2-supply = <&vreg_s5_1p35>;
+		vdd-l3-l8-supply = <&vreg_s5_1p35>;
+		vdd-l4-supply = <&vreg_s5_1p35>;
+		vdd-l5-l6-supply = <&vreg_s4_1p8>;
+		vdd-l7-supply = <&vph_pwr>;
+		vdd-l9-supply = <&vreg_s5_1p35>;
+		vdd-l10-l11-l12-l13-supply = <&vph_pwr>;
+
+		vreg_s4_1p8: s4 {
+			regulator-min-microvolt = <1728000>;
+			regulator-max-microvolt = <1920000>;
+		};
+
+		vreg_s5_1p35: s5 {
+			regulator-min-microvolt = <>;
+			regulator-max-microvolt = <>;
+		};
+
+		vreg_l1_1p3: l1 {
+			regulator-min-microvolt = <1240000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_l2_1p275: l2 {
+			regulator-min-microvolt = <1048000>;
+			regulator-max-microvolt = <1280000>;
+		};
+
+		vreg_l3_1p05: l3 {
+			regulator-min-microvolt = <976000>;
+			regulator-max-microvolt = <1160000>;
+		};
+
+		vreg_l4_1p2: l4 {
+			regulator-min-microvolt = <1144000>;
+			regulator-max-microvolt = <1256000>;
+		};
+
+		vreg_l5_1p8: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l6_1p8: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		vreg_l7_1p8: l7 {
+			regulator-min-microvolt = <1616000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		vreg_l8_1p2: l8 {
+			regulator-min-microvolt = <1136000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_l10_3p3: l10 {
+			regulator-min-microvolt = <2936000>;
+			regulator-max-microvolt = <3088000>;
+		};
+
+		vreg_l11_sdc2: l11 {
+			regulator-min-microvolt = <2696000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l12_3p3: l12 {
+			regulator-min-microvolt = <2968000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		vreg_l13_3p3: l13 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
 };
-- 
2.14.4
