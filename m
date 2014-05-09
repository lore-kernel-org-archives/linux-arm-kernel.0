From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 9 May 2014 15:44:28 +0200
Subject: [PATCH 2/2] ARM: at91: add 2 PWM outputs to SAMA5D3 Xplained
In-Reply-To: <a5a0a9b8090f80f40daf3a13849b3961d9d617d6.1399642907.git.nicolas.ferre@atmel.com>
References: <a5a0a9b8090f80f40daf3a13849b3961d9d617d6.1399642907.git.nicolas.ferre@atmel.com>
Message-ID: <bbcf36b3df7b07933820506020a7ce637bc18f81.1399642907.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PWM high output of channels 0 and 1 to PA20 PA22 pins.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index ff8a159bb600..0eacd92cd4b9 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -56,6 +56,12 @@
 				status = "okay";
 			};
 
+			pwm0: pwm at f002c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_pwm0_pwmh0_0 &pinctrl_pwm0_pwmh1_0>;
+				status = "okay";
+			};
+
 			usart0: serial at f001c000 {
 				status = "okay";
 			};
-- 
1.8.2.2
