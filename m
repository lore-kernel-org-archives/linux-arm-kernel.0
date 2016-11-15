From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 15 Nov 2016 12:01:52 +0000
Subject: [PATCH v3 2/2] ARM: dts: apq8064: add support to pm8821
In-Reply-To: <1479211312-1431-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1479211312-1431-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1479211312-1431-2-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 268bd47..f725e31 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -627,6 +627,33 @@
 			clock-names = "core";
 		};
 
+		ssbi at c00000 {
+			compatible = "qcom,ssbi";
+			reg = <0x00c00000 0x1000>;
+			qcom,controller-type = "pmic-arbiter";
+
+			pm8821: pmic at 1 {
+				compatible = "qcom,pm8821";
+				interrupt-parent = <&tlmm_pinmux>;
+				interrupts = <76 IRQ_TYPE_LEVEL_LOW>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pm8821_mpps: mpps at 50 {
+					compatible = "qcom,pm8821-mpp", "qcom,ssbi-mpp";
+					reg = <0x50>;
+					interrupts = <24 IRQ_TYPE_NONE>,
+						     <25 IRQ_TYPE_NONE>,
+						     <26 IRQ_TYPE_NONE>,
+						     <27 IRQ_TYPE_NONE>;
+					gpio-controller;
+					#gpio-cells = <2>;
+				};
+			};
+		};
+
 		qcom,ssbi at 500000 {
 			compatible = "qcom,ssbi";
 			reg = <0x00500000 0x1000>;
-- 
2.10.1
