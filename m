From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 17 Jun 2016 16:14:06 +0100
Subject: [PATCH 09/16] arm64: dts: msm8996: add support to blsp2_i2c0 pinctrl
In-Reply-To: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466176454-28084-10-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to blsp2_i2c0 pinctrl.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
index 7017bb6..79ed98c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
@@ -37,6 +37,30 @@
 		};
 	};
 
+	blsp2_i2c0_default: blsp2_i2c0 {
+		pinmux {
+			function = "blsp_i2c7";
+			pins = "gpio55", "gpio56";
+		};
+		pinconf {
+			pins = "gpio55", "gpio56";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_i2c0_sleep: blsp2_i2c0_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio55", "gpio56";
+		};
+		pinconf {
+			pins = "gpio55", "gpio56";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
 	blsp2_uart1_2pins_default: blsp2_uart1_2pins {
 		pinmux {
 			function = "blsp_uart8";
-- 
2.7.4
