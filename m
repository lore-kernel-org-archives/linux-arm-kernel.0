From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 18 Sep 2015 13:31:40 +0100
Subject: [PATCH 08/14] ARM: dts: apq8064: add missing gsbi7 uart pinctrl
In-Reply-To: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1442579500-20271-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing gsbi7 uart pinctrl, this is the default debug
uart on most boards.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index eb629c7..42286c6 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -140,6 +140,20 @@
 					function = "gsbi6";
 				};
 			};
+
+			gsbi7_uart_2pins: gsbi7_uart_2pins {
+				mux {
+					pins = "gpio82", "gpio83";
+					function = "gsbi7";
+				};
+			};
+
+			gsbi7_uart_4pins: gsbi7_uart_4pins {
+				mux {
+					pins = "gpio82", "gpio83", "gpio84", "gpio85";
+					function = "gsbi7";
+				};
+			};
 		};
 
 		intc: interrupt-controller at 2000000 {
-- 
1.9.1
