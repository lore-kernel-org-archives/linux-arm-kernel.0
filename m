From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Tue, 10 Oct 2017 13:09:48 +0300
Subject: [PATCH v2 13/14] ARM: dts: at91: at91sam9x25ek: add pwm0
In-Reply-To: <1507630189-15504-1-git-send-email-claudiu.beznea@microchip.com>
References: <1507630189-15504-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1507630189-15504-14-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add the PWM0 interface and one output of channel 0 (on PC10) on this headless
board. The output conflicts with LCD and ISI, so only enable it for this
particular board of the series (ISI is enabled on at91sam9g25ek, as an example
but we can do the other way around).

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91sam9x25ek.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x25ek.dts b/arch/arm/boot/dts/at91sam9x25ek.dts
index f8360fb23107..f705a3165656 100644
--- a/arch/arm/boot/dts/at91sam9x25ek.dts
+++ b/arch/arm/boot/dts/at91sam9x25ek.dts
@@ -29,6 +29,12 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			pwm0: pwm at f8034000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_pwm0_pwm0_1>;
+				status = "okay";
+			};
 		};
 	};
 };
-- 
2.7.4
