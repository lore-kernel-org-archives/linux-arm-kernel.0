From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed,  2 Aug 2017 21:35:16 -0700
Subject: [PATCH v2 2/4] arm64: dts: qcom: db820c: Add pm8994 regulator node
In-Reply-To: <20170803043518.21408-1-bjorn.andersson@linaro.org>
References: <20170803043518.21408-1-bjorn.andersson@linaro.org>
Message-ID: <20170803043518.21408-3-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Add PM8994 RPM regulators with their min/max voltages to DB820c.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 148 +++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index d2196fc6d739..b4817d6c0d50 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -106,4 +106,152 @@
 			gpios = <&pm8994_gpios 2 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	rpm-glink {
+		rpm_requests {
+			pm8994-regulators {
+				vdd_l1-supply = <&pm8994_s3>;
+				vdd_l2_l26_l28-supply = <&pm8994_s3>;
+				vdd_l3_l11-supply = <&pm8994_s3>;
+				vdd_l4_l27_l31-supply = <&pm8994_s3>;
+				vdd_l5_l7-supply = <&pm8994_s5>;
+				vdd_l14_l15-supply = <&pm8994_s5>;
+				vdd_l20_l21-supply = <&pm8994_s5>;
+				vdd_l25-supply = <&pm8994_s3>;
+
+				s3 {
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1300000>;
+				};
+				s4 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+				s5 {
+					regulator-min-microvolt = <2150000>;
+					regulator-max-microvolt = <2150000>;
+				};
+				s7 {
+					regulator-min-microvolt = <800000>;
+					regulator-max-microvolt = <800000>;
+				};
+
+				l1 {
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+				};
+				l2 {
+					regulator-min-microvolt = <1250000>;
+					regulator-max-microvolt = <1250000>;
+				};
+				l3 {
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <850000>;
+				};
+				l4 {
+					regulator-min-microvolt = <1225000>;
+					regulator-max-microvolt = <1225000>;
+				};
+				l6 {
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+				l8 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+				l9 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+				l10 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+				l11 {
+					regulator-min-microvolt = <1150000>;
+					regulator-max-microvolt = <1150000>;
+				};
+				l12 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+				l13 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <2950000>;
+				};
+				l14 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+				l15 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+				l16 {
+					regulator-min-microvolt = <2700000>;
+					regulator-max-microvolt = <2700000>;
+				};
+				l17 {
+					regulator-min-microvolt = <2500000>;
+					regulator-max-microvolt = <2500000>;
+				};
+				l18 {
+					regulator-min-microvolt = <2700000>;
+					regulator-max-microvolt = <2900000>;
+				};
+				l19 {
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+				};
+				l20 {
+					regulator-min-microvolt = <2950000>;
+					regulator-max-microvolt = <2950000>;
+					regulator-allow-set-load;
+				};
+				l21 {
+					regulator-min-microvolt = <2950000>;
+					regulator-max-microvolt = <2950000>;
+				};
+				l22 {
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+				l23 {
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+				};
+				l24 {
+					regulator-min-microvolt = <3075000>;
+					regulator-max-microvolt = <3075000>;
+				};
+				l25 {
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-allow-set-load;
+				};
+				l27 {
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+				};
+				l28 {
+					regulator-min-microvolt = <925000>;
+					regulator-max-microvolt = <925000>;
+					regulator-allow-set-load;
+				};
+				l29 {
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+				};
+				l30 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+				l32 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+			};
+		};
+	};
 };
-- 
2.12.0
