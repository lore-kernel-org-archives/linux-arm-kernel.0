From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 28 Jan 2016 17:43:30 +0000
Subject: [PATCH v2 2/9] arm64: dts: qcom: add correct drive strenght on cs pins
In-Reply-To: <1454002960-3106-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454002960-3106-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1454003010-3204-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2mA drive strenght is not enough to drive chipselect low on hardware
configurations with level shifters, 16mA should give good range to
allow such configurations to work.

This issue was noticed while testing spi on db410c with sensor board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 3bd917e..8d05005 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -81,8 +81,8 @@
 			bias-disable;
 		};
 		pinconf_cs {
-			pins = "gpio2";
-			drive-strength = <2>;
+			pins = "gpio16";
+			drive-strength = <16>;
 			bias-disable;
 			output-high;
 		};
@@ -116,7 +116,7 @@
 		};
 		pinconf_cs {
 			pins = "gpio6";
-			drive-strength = <2>;
+			drive-strength = <16>;
 			bias-disable;
 			output-high;
 		};
@@ -150,7 +150,7 @@
 		};
 		pinconf_cs {
 			pins = "gpio10";
-			drive-strength = <2>;
+			drive-strength = <16>;
 			bias-disable;
 			output-high;
 		};
@@ -184,7 +184,7 @@
 		};
 		pinconf_cs {
 			pins = "gpio14";
-			drive-strength = <2>;
+			drive-strength = <16>;
 			bias-disable;
 			output-high;
 		};
@@ -218,7 +218,7 @@
 		};
 		pinconf_cs {
 			pins = "gpio18";
-			drive-strength = <2>;
+			drive-strength = <16>;
 			bias-disable;
 			output-high;
 		};
@@ -252,7 +252,7 @@
 		};
 		pinconf_cs {
 			pins = "gpio22";
-			drive-strength = <2>;
+			drive-strength = <16>;
 			bias-disable;
 			output-high;
 		};
-- 
1.9.1
