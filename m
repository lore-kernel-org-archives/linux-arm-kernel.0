From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Thu,  4 Jun 2015 12:19:05 +0300
Subject: [PATCH 6/7] arm64: dts: qcom: Fix apq8016-sbc board USB related pin
 definitions
In-Reply-To: <1433409546-23995-1-git-send-email-ivan.ivanov@linaro.org>
References: <1433409546-23995-1-git-send-email-ivan.ivanov@linaro.org>
Message-ID: <1433409546-23995-7-git-send-email-ivan.ivanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB2513B HUB reset line is connected to PMIC GPIO3 not GPIO1.

Fix TC7USB40MU Dual SPDT Switch select input line control, which is
connected to PMIC GPIO4 not GPIO2 and disable the pin. It is not used
for now.

Remove user LEDs definitions, because they clash with above numbers.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 .../arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
index 37ca2ed..b568c49 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
@@ -2,26 +2,20 @@

 &pm8916_gpios {

-	pm8916_gpios_default: default {
-		usb_hub_reset_pm {
-			pins = "gpio1";
-			function = PMIC_GPIO_FUNC_NORMAL;
-			output-low;
-		};
-		usb_sw_sel_pm {
-			pins = "gpio2";
-			function = PMIC_GPIO_FUNC_NORMAL;
-			input-disable;
-		};
-		usr_led_3_ctrl {
+	usb_hub_reset_pm: usb_hub_reset_pm {
+		pinconf {
 			pins = "gpio3";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			output-low;
 		};
-		usr_led_4_ctrl {
+	};
+
+	usb_sw_sel_pm: usb_sw_sel_pm {
+		pinconf {
 			pins = "gpio4";
 			function = PMIC_GPIO_FUNC_NORMAL;
-			output-low;
+			power-source = <PM8916_GPIO_VPH>;
+			input-disable;
 		};
 	};
 };
--
1.9.1
