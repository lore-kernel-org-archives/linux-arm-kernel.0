From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 14:14:26 +0000
Subject: [PATCH 04/12] ARM: dts: apq8064: add i2c sleep pinctrl states.
In-Reply-To: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456236866-2588-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing i2c pinctrl sleep states.
Also add 16mA drive strength to the pins so that we can detect wide
range of i2c devices on the other side of level shifters.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi | 36 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi      |  8 +++----
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
index c711aca..ce15c67 100644
--- a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
@@ -19,6 +19,24 @@
 			pins = "gpio20", "gpio21";
 			function = "gsbi1";
 		};
+
+		pinconf {
+			pins = "gpio20", "gpio21";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	i2c1_pins_sleep: i2c1_pins_sleep {
+		mux {
+			pins = "gpio20", "gpio21";
+			function = "gpio";
+		};
+		pinconf {
+			pins = "gpio20", "gpio21";
+			drive-strength = <2>;
+			bias-disable = <0>;
+		};
 	};
 
 	i2c3_pins: i2c3 {
@@ -26,6 +44,24 @@
 			pins = "gpio8", "gpio9";
 			function = "gsbi3";
 		};
+
+		pinconf {
+			pins = "gpio8", "gpio9";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	i2c3_pins_sleep: i2c3_pins_sleep {
+		mux {
+			pins = "gpio8", "gpio9";
+			function = "gpio";
+		};
+		pinconf {
+			pins = "gpio8", "gpio9";
+			drive-strength = <2>;
+			bias-disable = <0>;
+		};
 	};
 
 	gsbi6_uart_2pins: gsbi6_uart_2pins {
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 3d95534b..3fb66b9 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -227,8 +227,8 @@
 
 			gsbi1_i2c: i2c at 12460000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
-				pinctrl-0 = <&i2c1_pins>;
-				pinctrl-names = "default";
+				pinctrl-0 = <&i2c1_pins &i2c1_pins_sleep>;
+				pinctrl-names = "default", "sleep";
 				reg = <0x12460000 0x1000>;
 				interrupts = <0 194 IRQ_TYPE_NONE>;
 				clocks = <&gcc GSBI1_QUP_CLK>, <&gcc GSBI1_H_CLK>;
@@ -274,8 +274,8 @@
 			ranges;
 			gsbi3_i2c: i2c at 16280000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
-				pinctrl-0 = <&i2c3_pins>;
-				pinctrl-names = "default";
+				pinctrl-0 = <&i2c3_pins &i2c3_pins_sleep>;
+				pinctrl-names = "default", "sleep";
 				reg = <0x16280000 0x1000>;
 				interrupts = <GIC_SPI 151 IRQ_TYPE_NONE>;
 				clocks = <&gcc GSBI3_QUP_CLK>,
-- 
1.9.1
