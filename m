From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Mon, 20 Apr 2015 10:45:41 +0300
Subject: [PATCH v2 7/7] arm64: dts: qcom: Add initial set of PMIC and SoC pins
 for APQ8016 SBC board
In-Reply-To: <1429515941-15334-1-git-send-email-ivan.ivanov@linaro.org>
References: <1429515941-15334-1-git-send-email-ivan.ivanov@linaro.org>
Message-ID: <1429515941-15334-8-git-send-email-ivan.ivanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial device configuration nodes for APQ8016 and PM8916 GPIO's.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 .../arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi | 30 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi | 21 +++++++++++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  2 ++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  2 +-
 4 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
new file mode 100644
index 0000000..535532b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
@@ -0,0 +1,30 @@
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+&pm8916_gpios {
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pm8916_gpios_default>;
+
+	pm8916_gpios_default: default {
+		usb_hub_reset_pm {
+			pins = "gpio1";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+		};
+		usb_sw_sel_pm {
+			pins = "gpio2";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			input-disable;
+		};
+		usr_led_3_ctrl {
+			pins = "gpio3";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+		};
+		usr_led_4_ctrl {
+			pins = "gpio4";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
new file mode 100644
index 0000000..5f7023f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
@@ -0,0 +1,21 @@
+
+#include <dt-bindings/gpio/gpio.h>
+
+&msmgpio {
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&soc_gpios_default>;
+
+	soc_gpios_default: default {
+		usr_led_1_ctrl_default: usr_led_1_ctrl_default {
+			pins = "gpio21";
+			function = "gpio";
+			output-low;
+		};
+		usr_led_2_ctrl_default: usr_led_2_ctrl_default {
+			pins = "gpio120";
+			function = "gpio";
+			output-low;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 58f0055f..98abece 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -13,6 +13,8 @@

 #include "msm8916.dtsi"
 #include "pm8916.dtsi"
+#include "apq8016-sbc-soc-pins.dtsi"
+#include "apq8016-sbc-pmic-pins.dtsi"

 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7887588..0f49ebd 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -82,7 +82,7 @@
 			reg = <0x4ab000 0x4>;
 		};

-		pinctrl at 1000000 {
+		msmgpio: pinctrl at 1000000 {
 			compatible = "qcom,msm8916-pinctrl";
 			reg = <0x1000000 0x300000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
--
1.9.1
