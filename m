From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 1 Mar 2016 14:06:08 +0100
Subject: [PATCH 2/2] ARM: dts: at91-sama5d2_xplained: add classD node
In-Reply-To: <ce1de34a6c36c17ce46bc39b675749c151aafad0.1456837347.git.nicolas.ferre@atmel.com>
References: <ce1de34a6c36c17ce46bc39b675749c151aafad0.1456837347.git.nicolas.ferre@atmel.com>
Message-ID: <38149e55ab3e3dcf9938d6379debbe3d6706b707.1456837347.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Songjun Wu <songjun.wu@atmel.com>

Enable Class D audio amplifier on the SAMA5D2 Xplained board.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
[nicolas.ferre at atmel.com: split and adapt patch to newer kernel]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 75341eec2dfd..4b1cbc33cb02 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -268,6 +268,14 @@
 			};
 
 			pinctrl at fc038000 {
+				pinctrl_classd_default: classd_default {
+					pinmux = <PIN_PB1__CLASSD_R0>,
+						 <PIN_PB2__CLASSD_R1>,
+						 <PIN_PB3__CLASSD_R2>,
+						 <PIN_PB4__CLASSD_R3>;
+					bias-pull-up;
+				};
+
 				pinctrl_flx0_default: flx0_default {
 					pinmux = <PIN_PB28__FLEXCOM0_IO0>,
 						 <PIN_PB29__FLEXCOM0_IO1>;
@@ -377,6 +385,14 @@
 					bias-disable;
 				};
 			};
+
+			classd at fc048000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_classd_default>;
+				atmel,pwm-type = "diff";
+				atmel,non-overlap-time = <10>;
+				status = "okay";
+			};
 		};
 	};
 };
-- 
2.1.3
