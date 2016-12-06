From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 6 Dec 2016 11:56:00 +0100
Subject: [RFC PATCH 3/3] ARM: dts: at91: sama5d2_xplained: add pin muxing and
 enable classd
In-Reply-To: <cover.1481021115.git.nicolas.ferre@atmel.com>
References: <cover.1481021115.git.nicolas.ferre@atmel.com>
Message-ID: <80bec63cef3f150a98edd7054d392a96d86af92d.1481021115.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch adds the pin muxing for classd and enables it.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 0b9a59d5fdac..c9a8939ba1ef 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -332,6 +332,14 @@
 					bias-pull-up;
 				};
 
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
@@ -464,6 +472,14 @@
 				};
 
 			};
+
+			classd: classd at fc048000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_classd_default>;
+				atmel,pwm-type = "diff";
+				atmel,non-overlap-time = <10>;
+				status = "okay";
+			};
 		};
 	};
 
-- 
2.9.0
