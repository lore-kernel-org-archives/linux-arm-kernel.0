From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Wed, 19 Nov 2014 11:25:54 +0800
Subject: [PATCH] ARM: dts: fix PWM clock found on RK3288 Socs
Message-ID: <1416367554-15185-1-git-send-email-caesar.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use the new PWM IP on RK3288,but the PWM's clock indeed incorrect.

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index cb18bb4..76bff02 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -418,7 +418,7 @@
 		#pwm-cells = <3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm0_pin>;
-		clocks = <&cru PCLK_PWM>;
+		clocks = <&cru PCLK_RKPWM>;
 		clock-names = "pwm";
 		status = "disabled";
 	};
@@ -429,7 +429,7 @@
 		#pwm-cells = <3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm1_pin>;
-		clocks = <&cru PCLK_PWM>;
+		clocks = <&cru PCLK_RKPWM>;
 		clock-names = "pwm";
 		status = "disabled";
 	};
@@ -440,7 +440,7 @@
 		#pwm-cells = <3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm2_pin>;
-		clocks = <&cru PCLK_PWM>;
+		clocks = <&cru PCLK_RKPWM>;
 		clock-names = "pwm";
 		status = "disabled";
 	};
@@ -451,7 +451,7 @@
 		#pwm-cells = <2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm3_pin>;
-		clocks = <&cru PCLK_PWM>;
+		clocks = <&cru PCLK_RKPWM>;
 		clock-names = "pwm";
 		status = "disabled";
 	};
-- 
1.9.1
