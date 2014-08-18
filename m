From: dianders@chromium.org (Doug Anderson)
Date: Mon, 18 Aug 2014 10:09:08 -0700
Subject: [PATCH 3/4] ARM: dts: Add main PWM info to rk3288
In-Reply-To: <1408381749-14156-1-git-send-email-dianders@chromium.org>
References: <1408381749-14156-1-git-send-email-dianders@chromium.org>
Message-ID: <1408381749-14156-4-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the PWM info (other than the VOP PWM) to the main rk3288
dtsi file.

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/rk3288.dtsi | 68 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 36be7bb..9c9d9c5 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -261,6 +261,50 @@
 		status = "disabled";
 	};
 
+	pwm0: pwm at ff680000 {
+		compatible = "rockchip,rk3288-pwm";
+		reg = <0xff680000 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm0_pin>;
+		clocks = <&cru PCLK_PWM>;
+		clock-names = "pwm";
+		status = "disabled";
+	};
+
+	pwm1: pwm at ff680010 {
+		compatible = "rockchip,rk3288-pwm";
+		reg = <0xff680010 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm1_pin>;
+		clocks = <&cru PCLK_PWM>;
+		clock-names = "pwm";
+		status = "disabled";
+	};
+
+	pwm2: pwm at ff680020 {
+		compatible = "rockchip,rk3288-pwm";
+		reg = <0xff680020 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm2_pin>;
+		clocks = <&cru PCLK_PWM>;
+		clock-names = "pwm";
+		status = "disabled";
+	};
+
+	pwm3: pwm at ff680030 {
+		compatible = "rockchip,rk3288-pwm";
+		reg = <0xff680030 0x10>;
+		#pwm-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm3_pin>;
+		clocks = <&cru PCLK_PWM>;
+		clock-names = "pwm";
+		status = "disabled";
+	};
+
 	pmu: power-management at ff730000 {
 		compatible = "rockchip,rk3288-pmu", "syscon";
 		reg = <0xff730000 0x100>;
@@ -611,5 +655,29 @@
 				rockchip,pins = <5 15 3 &pcfg_pull_none>;
 			};
 		};
+
+		pwm0 {
+			pwm0_pin: pwm0-pin {
+				rockchip,pins = <7 0 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm1 {
+			pwm1_pin: pwm1-pin {
+				rockchip,pins = <7 1 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm2 {
+			pwm2_pin: pwm2-pin {
+				rockchip,pins = <7 22 RK_FUNC_3 &pcfg_pull_none>;
+			};
+		};
+
+		pwm3 {
+			pwm3_pin: pwm3-pin {
+				rockchip,pins = <7 23 RK_FUNC_3 &pcfg_pull_none>;
+			};
+		};
 	};
 };
-- 
2.1.0.rc2.206.gedb03e5
