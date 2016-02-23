From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 14:14:45 +0000
Subject: [PATCH 07/12] ARM: dts: apq8064: add missing i2c2 pinctrl info
In-Reply-To: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456236639-1379-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456236885-2741-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing i2c2 pinctrl information in i2c2 node.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi      |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
index 0b7b10e..0a342d3 100644
--- a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
@@ -39,6 +39,32 @@
 		};
 	};
 
+	i2c2_pins: i2c2 {
+		mux {
+			pins = "gpio24", "gpio25";
+			function = "gsbi2";
+		};
+
+		pinconf {
+			pins = "gpio24", "gpio25";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	i2c2_pins_sleep: i2c2_pins_sleep {
+		mux {
+			pins = "gpio24", "gpio25";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio24", "gpio25";
+			drive-strength = <2>;
+			bias-disable = <0>;
+		};
+	};
+
 	i2c3_pins: i2c3 {
 		mux {
 			pins = "gpio8", "gpio9";
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 3fefb2e..2367adc 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -255,6 +255,8 @@
 			gsbi2_i2c: i2c at 124a0000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x124a0000 0x1000>;
+				pinctrl-0 = <&i2c2_pins &i2c2_pins_sleep>;
+				pinctrl-names = "default", "sleep";
 				interrupts = <0 196 IRQ_TYPE_NONE>;
 				clocks = <&gcc GSBI2_QUP_CLK>, <&gcc GSBI2_H_CLK>;
 				clock-names = "core", "iface";
-- 
1.9.1
