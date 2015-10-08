From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu,  8 Oct 2015 12:19:17 +0100
Subject: [PATCH 1/4] arm64: dts: fix i2c pinconf sleep state function
In-Reply-To: <1444303124-32402-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1444303124-32402-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1444303157-32447-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the i2c pinctrl sleep state by changing the pinconf
function to be in gpio mode rather than i2c.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 42941b9..a6105d7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -279,7 +279,7 @@
 
 	i2c4_sleep: i2c4_sleep {
 		pinmux {
-			function = "blsp_i2c4";
+			function = "gpio";
 			pins = "gpio14", "gpio15";
 		};
 		pinconf {
-- 
1.9.1
