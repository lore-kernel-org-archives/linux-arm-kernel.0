From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 27 Jul 2014 01:18:30 +0200
Subject: [PATCH v2 14/15] ARM: dts: rockchip: add pwm nodes
In-Reply-To: <1406416711-28006-1-git-send-email-heiko@sntech.de>
References: <1406416711-28006-1-git-send-email-heiko@sntech.de>
Message-ID: <1406416711-28006-15-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Beniamino Galvani <b.galvani@gmail.com>

This adds the necessary nodex and pinctrl settings for the Rockchip PWM-driver.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>

Modified to use the new clock defines and added rk3066 pins.
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3188.dtsi  | 44 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi  | 32 ++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 18e802c..9c34da4 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -214,6 +214,30 @@
 			};
 		};
 
+		pwm0 {
+			pwm0_out: pwm0-out {
+				rockchip,pins = <RK_GPIO0 3 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm1 {
+			pwm1_out: pwm1-out {
+				rockchip,pins = <RK_GPIO0 4 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm2 {
+			pwm2_out: pwm2-out {
+				rockchip,pins = <RK_GPIO0 30 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm3 {
+			pwm3_out: pwm3-out {
+				rockchip,pins = <RK_GPIO0 31 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		uart0 {
 			uart0_xfer: uart0-xfer {
 				rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_default>,
@@ -362,6 +386,26 @@
 	pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_cd &sd1_bus4>;
 };
 
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_out>;
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm1_out>;
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm2_out>;
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm3_out>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_xfer>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index ba1193c..27215e0 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -182,6 +182,30 @@
 			};
 		};
 
+		pwm0 {
+			pwm0_out: pwm0-out {
+				rockchip,pins = <RK_GPIO3 27 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm1 {
+			pwm1_out: pwm1-out {
+				rockchip,pins = <RK_GPIO3 28 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm2 {
+			pwm2_out: pwm2-out {
+				rockchip,pins = <RK_GPIO3 29 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm3 {
+			pwm3_out: pwm3-out {
+				rockchip,pins = <RK_GPIO3 30 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		uart0 {
 			uart0_xfer: uart0-xfer {
 				rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_up>,
@@ -337,6 +361,26 @@
 	pinctrl-0 = <&i2c4_xfer>;
 };
 
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_out>;
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm1_out>;
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm2_out>;
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm3_out>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_xfer>;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 989c337..c6f0561 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -158,6 +158,38 @@
 		status = "disabled";
 	};
 
+	pwm0: pwm at 20030000 {
+		compatible = "rockchip,rk2928-pwm";
+		reg = <0x20030000 0x10>;
+		#pwm-cells = <2>;
+		clocks = <&cru PCLK_PWM01>;
+		status = "disabled";
+	};
+
+	pwm1: pwm at 20030010 {
+		compatible = "rockchip,rk2928-pwm";
+		reg = <0x20030010 0x10>;
+		#pwm-cells = <2>;
+		clocks = <&cru PCLK_PWM01>;
+		status = "disabled";
+	};
+
+	pwm2: pwm at 20050020 {
+		compatible = "rockchip,rk2928-pwm";
+		reg = <0x20050020 0x10>;
+		#pwm-cells = <2>;
+		clocks = <&cru PCLK_PWM23>;
+		status = "disabled";
+	};
+
+	pwm3: pwm at 20050030 {
+		compatible = "rockchip,rk2928-pwm";
+		reg = <0x20050030 0x10>;
+		#pwm-cells = <2>;
+		clocks = <&cru PCLK_PWM23>;
+		status = "disabled";
+	};
+
 	i2c2: i2c at 20056000 {
 		compatible = "rockchip,rk3066-i2c";
 		reg = <0x20056000 0x1000>;
-- 
2.0.1
