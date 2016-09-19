From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon, 19 Sep 2016 10:41:52 +0530
Subject: [PATCH v2 2/3] ARM: dts: imx6q-apalis-ixora: Remove use of pwm-leds
In-Reply-To: <2263d508999ada9476268138b2922702eb50131f.1474260360.git.maitysanchayan@gmail.com>
References: <2263d508999ada9476268138b2922702eb50131f.1474260360.git.maitysanchayan@gmail.com>
Message-ID: <1c9c910104414bdfbad077ccc3baca57974ba8c7.1474260360.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove use of pwm-leds and use the standard /sys/class/pwm
interface from PWM subsystem.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
v1: https://lkml.org/lkml/2016/9/14/55
---
 arch/arm/boot/dts/imx6q-apalis-ixora.dts | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 82b81e0..383192c 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -146,28 +146,6 @@
 			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
 		};
 	};
-
-	pwmleds {
-		compatible = "pwm-leds";
-
-		ledpwm1 {
-			label = "PWM1";
-			pwms = <&pwm1 0 50000>;
-			max-brightness = <255>;
-		};
-
-		ledpwm2 {
-			label = "PWM2";
-			pwms = <&pwm2 0 50000>;
-			max-brightness = <255>;
-		};
-
-		ledpwm3 {
-			label = "PWM3";
-			pwms = <&pwm3 0 50000>;
-			max-brightness = <255>;
-		};
-	};
 };
 
 &backlight {
-- 
2.9.3
