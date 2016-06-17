From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 17 Jun 2016 16:14:00 +0100
Subject: [PATCH 03/16] arm64: dts: msm8996: add blsp2_uart2 pinctrl nodes.
In-Reply-To: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466176454-28084-4-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds blsp2_uart2 pinctrl nodes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
index 4d1dba7..03c1e0d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
@@ -62,4 +62,54 @@
 			bias-disable;
 		};
 	};
+
+	blsp2_uart2_2pins_default: blsp2_uart2_2pins {
+		pinmux {
+			function = "blsp_uart9";
+			pins = "gpio49", "gpio50";
+		};
+		pinconf {
+			pins = "gpio49", "gpio50";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart2_2pins_sleep: blsp2_uart2_2pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio49", "gpio50";
+		};
+		pinconf {
+			pins = "gpio49", "gpio50";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart2_4pins_default: blsp2_uart2_4pins {
+		pinmux {
+			function = "blsp_uart9";
+			pins = "gpio49", "gpio50", "gpio51", "gpio52";
+		};
+
+		pinconf {
+			pins = "gpio49", "gpio50", "gpio51", "gpio52";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	blsp2_uart2_4pins_sleep: blsp2_uart2_4pins_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio49", "gpio50", "gpio51", "gpio52";
+		};
+
+		pinconf {
+			pins = "gpio49", "gpio50", "gpio51", "gpio52";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 };
-- 
2.7.4
