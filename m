From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 11 Dec 2015 18:13:12 +0000
Subject: [PATCH 2/2] arm64: dts: set the default i2c pin drive strength to 16mA
In-Reply-To: <1449857504-11365-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1449857504-11365-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1449857592-11530-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2mA drive strength is not enough when we connect multiple i2c devices
on the bus with different pull up resistors.

This issue was detected when multiple i2c devices connected on the other side
of level shifters on Linaro sensor board. Maxing up to 16mA made i2c much stable.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 49ec55a..1991af7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -272,7 +272,7 @@
 		};
 		pinconf {
 			pins = "gpio6", "gpio7";
-			drive-strength = <2>;
+			drive-strength = <16>;
 			bias-disable = <0>;
 		};
 	};
@@ -296,7 +296,7 @@
 		};
 		pinconf {
 			pins = "gpio14", "gpio15";
-			drive-strength = <2>;
+			drive-strength = <16>;
 			bias-disable = <0>;
 		};
 	};
@@ -320,7 +320,7 @@
 		};
 		pinconf {
 			pins = "gpio22", "gpio23";
-			drive-strength = <2>;
+			drive-strength = <16>;
 			bias-disable = <0>;
 		};
 	};
-- 
1.9.1
