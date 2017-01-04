From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jan 2017 13:34:13 +0000
Subject: [PATCH 3/4] ARM: dts: sd-600eval: enable 1.8v regulator on LS
 expansion
In-Reply-To: <1483536854-21389-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1483536854-21389-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1483536854-21389-3-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables 1.8v regulator on LS expansion, which should be
always on according to 96boards spec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
index 4e908af..40f7168 100644
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
@@ -132,6 +132,16 @@
 					bias-pull-down;
 				};
 
+				/**
+				 * 1.8v required on LS expansion
+				 * for mezzanine boards
+				 */
+				l15 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
 				l23 {
 					regulator-min-microvolt = <1700000>;
 					regulator-max-microvolt = <1900000>;
-- 
2.10.1
