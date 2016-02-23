From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Feb 2016 16:50:53 +0000
Subject: [PATCH v3 8/8] arm64: dts: qcom: Fix MPP's function used for LED
 control
In-Reply-To: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456246253-18425-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>

The qcom-spmi-mpp driver is now using string "digital" to denote
old "normal" functionality. Update DTS file.
Also update the powersource.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
index e03c11d..f881437 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
@@ -33,7 +33,7 @@
 	pm8916_mpps_leds: pm8916_mpps_leds {
 		pinconf {
 			pins = "mpp2", "mpp3";
-			function = PMIC_GPIO_FUNC_NORMAL;
+			function = "digital";
 			output-low;
 		};
 	};
-- 
1.9.1
