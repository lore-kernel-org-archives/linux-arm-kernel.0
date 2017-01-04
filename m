From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jan 2017 13:35:00 +0000
Subject: [PATCH 4/6] arm64: dts: apq8016-sbc: Limit MPP4 high state to 1.8V
In-Reply-To: <1483536902-21450-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1483536902-21450-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1483536902-21450-5-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>

96Boards specs require all GPIO signals to be at 1.8V.
Limit MPP4, which is PIN28 on J8, to 1.8V(L5).

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
index f881437..d946408 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
@@ -1,4 +1,5 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
 
 &pm8916_gpios {
 
@@ -30,6 +31,18 @@
 
 &pm8916_mpps {
 
+	pinctrl-names = "default";
+	pinctrl-0 = <&ls_exp_gpio_f>;
+
+	ls_exp_gpio_f: pm8916_mpp4 {
+		pinconf {
+			pins = "mpp4";
+			function = "digital";
+			output-low;
+			power-source = <PM8916_MPP_L5>;	// 1.8V
+		};
+	};
+
 	pm8916_mpps_leds: pm8916_mpps_leds {
 		pinconf {
 			pins = "mpp2", "mpp3";
-- 
2.10.1
