From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 17 Jun 2016 16:14:04 +0100
Subject: [PATCH 07/16] arm64: dts: msm8996: add blsp2_i2c1 pinctrl
In-Reply-To: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466176454-28084-8-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to blsp2_i2c1 pinctrl nodes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
index 1f6a0a4..7017bb6 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
@@ -87,6 +87,30 @@
 		};
 	};
 
+	blsp2_i2c1_default: blsp2_i2c1 {
+		pinmux {
+			function = "blsp_i2c8";
+			pins = "gpio6", "gpio7";
+		};
+		pinconf {
+			pins = "gpio6", "gpio7";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_i2c1_sleep: blsp2_i2c1_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio6", "gpio7";
+		};
+		pinconf {
+			pins = "gpio6", "gpio7";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
 	blsp2_uart2_2pins_default: blsp2_uart2_2pins {
 		pinmux {
 			function = "blsp_uart9";
-- 
2.7.4
