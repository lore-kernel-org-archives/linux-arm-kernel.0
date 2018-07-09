From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Mon,  9 Jul 2018 16:57:40 +0530
Subject: [PATCH v5 7/7] arm64: dts: sdm845: Add tsens nodes
In-Reply-To: <cover.1531133611.git.amit.kucheria@linaro.org>
References: <cover.1531133611.git.amit.kucheria@linaro.org>
Message-ID: <742cf44d162523a66bb4ce60e15449dfbf88800a.1531133612.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SDM845 has two tsens blocks, one with 13 sensors and the other with 8
sensors. It uses version 2 of the TSENS IP, so use the fallback property to
allow more common code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cdaabeb..d97ee00 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -221,6 +221,22 @@
 			#interrupt-cells = <2>;
 		};
 
+		tsens0: tsens at c222000 {
+			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+			reg = <0xc263000 0x1ff>, /* TM */
+			      <0xc222000 0x1ff>; /* SROT */
+			#qcom,sensors = <13>;
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: tsens at c223000 {
+			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+			reg = <0xc265000 0x1ff>, /* TM */
+			      <0xc223000 0x1ff>; /* SROT */
+			#qcom,sensors = <8>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		spmi_bus: spmi at c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
2.7.4
