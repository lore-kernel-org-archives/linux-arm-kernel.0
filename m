From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 19 Mar 2014 00:15:41 +0100
Subject: [PATCH 3/3] ARM: at91/dt: at91sam9m10g45ek PWM leds polarity is
 inversed
In-Reply-To: <1395184541-5787-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395184541-5787-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1395184541-5787-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The real polarity of the LEDs is inversed. The led is between 3.3v and the PWM.
It was working before because the driver was getting the duty cycle calculation
wrong.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 7800931a4b16..9f5b0a674995 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -8,6 +8,7 @@
  */
 /dts-v1/;
 #include "at91sam9g45.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Atmel AT91SAM9M10G45-EK";
@@ -231,14 +232,14 @@
 
 		d6 {
 			label = "d6";
-			pwms = <&pwm0 3 5000 0>;
+			pwms = <&pwm0 3 5000 PWM_POLARITY_INVERTED>;
 			max-brightness = <255>;
 			linux,default-trigger = "nand-disk";
 		};
 
 		d7 {
 			label = "d7";
-			pwms = <&pwm0 1 5000 0>;
+			pwms = <&pwm0 1 5000 PWM_POLARITY_INVERTED>;
 			max-brightness = <255>;
 			linux,default-trigger = "mmc0";
 		};
-- 
1.8.3.2
