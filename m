From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 17 Jun 2016 16:14:10 +0100
Subject: [PATCH 13/16] arm64: dts: msm8996: add support to blsp2_spi5 pinctrl
In-Reply-To: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466176454-28084-14-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinctrl required for blsp2_spi5 device.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
index 9fd37a0..551707a 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
@@ -218,4 +218,38 @@
 			bias-disable;
 		};
 	};
+
+	blsp2_spi5_default: blsp2_spi5_default {
+		pinmux {
+			function = "blsp_spi12";
+			pins = "gpio85", "gpio86", "gpio88";
+		};
+		pinmux_cs {
+			function = "gpio";
+			pins = "gpio87";
+		};
+		pinconf {
+			pins = "gpio85", "gpio86", "gpio88";
+			drive-strength = <12>;
+			bias-disable;
+		};
+		pinconf_cs {
+			pins = "gpio87";
+			drive-strength = <16>;
+			bias-disable;
+			output-high;
+		};
+	};
+
+	blsp2_spi5_sleep: blsp2_spi5_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio85", "gpio86", "gpio87", "gpio88";
+		};
+		pinconf {
+			pins = "gpio85", "gpio86", "gpio87", "gpio88";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
 };
-- 
2.7.4
