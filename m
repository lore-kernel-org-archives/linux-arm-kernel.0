From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 26 Jan 2017 16:47:24 -0800
Subject: [PATCH 1/5] ARM: dts: qcom: Remove s4/5vs1,2 from RPM pm8941 control
In-Reply-To: <20170127004728.22490-1-stephen.boyd@linaro.org>
References: <20170127004728.22490-1-stephen.boyd@linaro.org>
Message-ID: <20170127004728.22490-2-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These regulators are controlled by the SPMI regulator driver
instead of the RPM regulator driver in the downstream android
kernel sources. Let's remove them from the DTS here because
they'll never be used by the RPM regulator driver.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts | 1 -
 arch/arm/boot/dts/qcom-msm8974.dtsi                   | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index e7c1577d56f4..50966378f9e4 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -92,7 +92,6 @@
 					vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
 					vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
 					vdd_l21-supply = <&vreg_boost>;
-					vin_5vs-supply = <&pm8941_5v>;
 
 					s1 {
 						regulator-min-microvolt = <1300000>;
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 0e9bbede860d..6c167c031368 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -735,7 +735,6 @@
 					pm8941_s1: s1 {};
 					pm8941_s2: s2 {};
 					pm8941_s3: s3 {};
-					pm8941_5v: s4 {};
 
 					pm8941_l1: l1 {};
 					pm8941_l2: l2 {};
@@ -765,9 +764,6 @@
 					pm8941_lvs1: lvs1 {};
 					pm8941_lvs2: lvs2 {};
 					pm8941_lvs3: lvs3 {};
-
-					pm8941_5vs1: 5vs1 {};
-					pm8941_5vs2: 5vs2 {};
 				};
 			};
 		};
-- 
2.10.0.297.gf6727b0
