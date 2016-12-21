From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 21 Dec 2016 03:49:38 -0800
Subject: [PATCH 4/5] ARM: dts: qcom: sd600-eval: pm8921_s2 regulator properties
In-Reply-To: <20161221114939.19973-1-bjorn.andersson@linaro.org>
References: <20161221114939.19973-1-bjorn.andersson@linaro.org>
Message-ID: <20161221114939.19973-4-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing properties for pm8921 smps2.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

My SD600eval broke, so this is untested.

 arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
index 39ae2bc8cb08..b7dcab28642d 100644
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
@@ -74,6 +74,14 @@
 					bias-pull-down;
 				};
 
+				s2 {
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1300000>;
+					qcom,switch-mode-frequency = <1600000>;
+					bias-pull-down;
+					regulator-always-on;
+				};
+
 				s3 {
 					regulator-min-microvolt = <1000000>;
 					regulator-max-microvolt = <1400000>;
-- 
2.11.0
