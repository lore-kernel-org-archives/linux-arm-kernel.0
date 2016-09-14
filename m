From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Wed, 14 Sep 2016 12:05:04 +0530
Subject: [PATCH v1 2/3] ARM: dts: imx6q-apalis-ixora: Remove use of pwm-leds
In-Reply-To: <9d2c17aa2e00e6ff4349a53de8247860d2382607.1473833908.git.maitysanchayan@gmail.com>
References: <9d2c17aa2e00e6ff4349a53de8247860d2382607.1473833908.git.maitysanchayan@gmail.com>
Message-ID: <6111feb57b5fbaa29eeb6ba089bb2824bbf2f8ff.1473833908.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove use of pwm-leds and use the standard /sys/class/pwm
interface from PWM subsystem.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/imx6q-apalis-ixora.dts | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index d99979e..70a3da0 100644
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
