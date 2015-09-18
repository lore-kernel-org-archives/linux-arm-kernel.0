From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 18 Sep 2015 13:31:34 +0100
Subject: [PATCH 07/14] ARM: dts: apq8064: Prefix the gsbi6 uart pins correctly
In-Reply-To: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1442579494-20229-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of generic names like "uart_pins" is confusing to the reader, given
the fact that there could be more than one uart on APQ8064.
This patch adds gsbi prefix to uart pinctrl nodes so as to avoid such
confusion.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 2 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 2ad2ab8..56eaf5a 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -145,7 +145,7 @@
 			serial at 16540000 {
 				status = "ok";
 				pinctrl-names = "default";
-				pinctrl-0 = <&uart_pins>;
+				pinctrl-0 = <&gsbi6_uart_4pins>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 4a2f159..eb629c7 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -127,7 +127,14 @@
 				};
 			};
 
-			uart_pins: uart_pins {
+			gsbi6_uart_2pins: gsbi6_uart_2pins {
+				mux {
+					pins = "gpio14", "gpio15";
+					function = "gsbi6";
+				};
+			};
+
+			gsbi6_uart_4pins: gsbi6_uart_4pins {
 				mux {
 					pins = "gpio14", "gpio15", "gpio16", "gpio17";
 					function = "gsbi6";
-- 
1.9.1
