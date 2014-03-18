From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 19 Mar 2014 00:15:40 +0100
Subject: [PATCH 2/3] ARM: at91/dt: at91sam9m10g45ek: add ADC and touchscreen
 support
In-Reply-To: <1395184541-5787-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395184541-5787-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1395184541-5787-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 7ff665a8c708..7800931a4b16 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -130,6 +130,21 @@
 				status = "okay";
 			};
 
+			adc0: adc at fffb0000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <
+					&pinctrl_adc0_ad0
+					&pinctrl_adc0_ad1
+					&pinctrl_adc0_ad2
+					&pinctrl_adc0_ad3
+					&pinctrl_adc0_ad4
+					&pinctrl_adc0_ad5
+					&pinctrl_adc0_ad6
+					&pinctrl_adc0_ad7>;
+				atmel,adc-ts-wires = <4>;
+				status = "okay";
+			};
+
 			pwm0: pwm at fffb8000 {
 				status = "okay";
 
-- 
1.8.3.2
