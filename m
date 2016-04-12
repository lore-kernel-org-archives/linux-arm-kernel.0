From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 12 Apr 2016 10:33:51 +0100
Subject: [PATCH v2 02/13] ARM: dts: apq8064: add support to gsbi1 uart
In-Reply-To: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1460453642-5809-3-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to gsbi1 uart and its pinctrls nodes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi      | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
index b57c59d..8bb5e5f 100644
--- a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
@@ -39,6 +39,20 @@
 		};
 	};
 
+	gsbi1_uart_2pins: gsbi1_uart_2pins {
+		mux {
+			pins = "gpio18", "gpio19";
+			function = "gsbi1";
+		};
+	};
+
+	gsbi1_uart_4pins: gsbi1_uart_4pins {
+		mux {
+			pins = "gpio18", "gpio19", "gpio20", "gpio21";
+			function = "gsbi1";
+		};
+	};
+
 	i2c2_pins: i2c2 {
 		mux {
 			pins = "gpio24", "gpio25";
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index c6ff8fc..81b4290 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -225,6 +225,16 @@
 
 			syscon-tcsr = <&tcsr>;
 
+			gsbi1_serial: serial at 12450000 {
+				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+				reg = <0x12450000 0x100>,
+				      <0x12400000 0x03>;
+				interrupts = <0 193 0x0>;
+				clocks = <&gcc GSBI1_UART_CLK>, <&gcc GSBI1_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+			};
+
 			gsbi1_i2c: i2c at 12460000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				pinctrl-0 = <&i2c1_pins>;
-- 
2.5.0
