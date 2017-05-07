From: ayaka@soulik.info (Randy Li)
Date: Sun,  7 May 2017 22:34:46 +0800
Subject: [PATCH] ARM: dts: rockchip: add missing grf phandle for rk3288
Message-ID: <20170507143446.11502-1-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PWM devices need to access the grf to switch the PWM IP.
And tsadc uses it to shutdown the system.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm/boot/dts/rk3288.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 26b8886..c1d3b1f 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -546,6 +546,7 @@
 		pinctrl-2 = <&otp_gpio>;
 		#thermal-sensor-cells = <1>;
 		rockchip,hw-tshut-temp = <95000>;
+		rockchip,grf = <&grf>;
 		status = "disabled";
 	};
 
@@ -654,6 +655,7 @@
 		pinctrl-0 = <&pwm0_pin>;
 		clocks = <&cru PCLK_PWM>;
 		clock-names = "pwm";
+		rockchip,grf = <&grf>;
 		status = "disabled";
 	};
 
@@ -665,6 +667,7 @@
 		pinctrl-0 = <&pwm1_pin>;
 		clocks = <&cru PCLK_PWM>;
 		clock-names = "pwm";
+		rockchip,grf = <&grf>;
 		status = "disabled";
 	};
 
@@ -676,6 +679,7 @@
 		pinctrl-0 = <&pwm2_pin>;
 		clocks = <&cru PCLK_PWM>;
 		clock-names = "pwm";
+		rockchip,grf = <&grf>;
 		status = "disabled";
 	};
 
@@ -687,6 +691,7 @@
 		pinctrl-0 = <&pwm3_pin>;
 		clocks = <&cru PCLK_PWM>;
 		clock-names = "pwm";
+		rockchip,grf = <&grf>;
 		status = "disabled";
 	};
 
-- 
2.9.3
