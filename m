From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 12 Jul 2014 21:30:53 +0200
Subject: [PATCH 6/7] ARM: dts: rockchip: add pwm nodes
In-Reply-To: <16344051.ZPa9bzz4Fj@diego>
References: <16344051.ZPa9bzz4Fj@diego>
Message-ID: <2843369.sut5EbBWVp@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Beniamino Galvani <b.galvani@gmail.com>

This adds the necessary nodex and pinctrl settings for the Rockchip PWM-driver.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>

Modified to use the new clock defines and added rk3066 pins.
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/rk3188.dtsi  | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi  | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 3cfdb43..e8bbc29 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -216,6 +216,30 @@
 				};
 			};
 
+			pwm0 {
+				pwm0_pins: pwm0-pins {
+					rockchip,pins = <RK_GPIO0 3 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			pwm1 {
+				pwm1_pins: pwm1-pins {
+					rockchip,pins = <RK_GPIO0 4 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			pwm2 {
+				pwm2_pins: pwm2-pins {
+					rockchip,pins = <RK_GPIO0 30 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			pwm3 {
+				pwm3_pins: pwm3-pins {
+					rockchip,pins = <RK_GPIO0 31 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
 			uart0 {
 				uart0_xfer: uart0-xfer {
 					rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_default>,
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index fc3b0dd..004353d 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -191,6 +191,30 @@
 				};
 			};
 
+			pwm0 {
+				pwm0_pins: pwm0-pins {
+					rockchip,pins = <RK_GPIO3 27 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			pwm1 {
+				pwm1_pins: pwm1-pins {
+					rockchip,pins = <RK_GPIO3 28 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			pwm2 {
+				pwm2_pins: pwm2-pins {
+					rockchip,pins = <RK_GPIO3 29 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			pwm3 {
+				pwm3_pins: pwm3-pins {
+					rockchip,pins = <RK_GPIO3 30 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
 			uart0 {
 				uart0_xfer: uart0-xfer {
 					rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_up>,
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 8b083e8..1623e21 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -229,5 +229,37 @@
 
 			status = "disabled";
 		};
+
+		pwm0: pwm at 20030000 {
+			compatible = "rockchip,rk2928-pwm";
+			reg = <0x20030000 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cru PCLK_PWM01>;
+			status = "disabled";
+		};
+
+		pwm1: pwm at 20030010 {
+			compatible = "rockchip,rk2928-pwm";
+			reg = <0x20030010 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cru PCLK_PWM01>;
+			status = "disabled";
+		};
+
+		pwm2: pwm at 20050020 {
+			compatible = "rockchip,rk2928-pwm";
+			reg = <0x20050020 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cru PCLK_PWM23>;
+			status = "disabled";
+		};
+
+		pwm3: pwm at 20050030 {
+			compatible = "rockchip,rk2928-pwm";
+			reg = <0x20050030 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cru PCLK_PWM23>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.0
