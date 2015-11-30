From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 30 Nov 2015 02:22:37 +0100
Subject: [PATCH] ARM: mxs: dt: cfa10057: fix backlight PWM
Message-ID: <1448846557-26594-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The backlight PWM is actually pwm4.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10057.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10057.dts b/arch/arm/boot/dts/imx28-cfa10057.dts
index 5df0b24eaf59..3bc34cdb9269 100644
--- a/arch/arm/boot/dts/imx28-cfa10057.dts
+++ b/arch/arm/boot/dts/imx28-cfa10057.dts
@@ -115,7 +115,7 @@
 
 			pwm: pwm at 80064000 {
 				pinctrl-names = "default";
-				pinctrl-0 = <&pwm3_pins_b>;
+				pinctrl-0 = <&pwm4_pins_a>;
 				status = "okay";
 			};
 
@@ -170,8 +170,8 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 3 5000000>;
+		pwms = <&pwm 4 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <7>;
+		default-brightness-level = <6>;
 	};
 };
-- 
2.5.0
