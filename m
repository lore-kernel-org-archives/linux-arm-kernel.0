From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  2 Dec 2015 22:35:22 +0100
Subject: [PATCH v2] ARM: mxs: dt: cfa10057: fix backlight PWM
Message-ID: <1449092122-7093-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The backlight PWM is actually pwm4.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Changes in v2:
 - remove default-brightness-level change

 arch/arm/boot/dts/imx28-cfa10057.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10057.dts b/arch/arm/boot/dts/imx28-cfa10057.dts
index 5df0b24eaf59..7a80bd686c40 100644
--- a/arch/arm/boot/dts/imx28-cfa10057.dts
+++ b/arch/arm/boot/dts/imx28-cfa10057.dts
@@ -115,7 +115,7 @@
 
 			pwm: pwm at 80064000 {
 				pinctrl-names = "default";
-				pinctrl-0 = <&pwm3_pins_b>;
+				pinctrl-0 = <&pwm4_pins_a>;
 				status = "okay";
 			};
 
@@ -170,7 +170,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 3 5000000>;
+		pwms = <&pwm 4 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 	};
-- 
2.5.0
