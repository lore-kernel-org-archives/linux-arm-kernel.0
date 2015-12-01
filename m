From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  1 Dec 2015 17:13:26 +0800
Subject: [PATCH 3/3] arm64: dts: rockchip: add the pwm node info for RK3368
 SoCs
In-Reply-To: <1448961206-23769-1-git-send-email-wxt@rock-chips.com>
References: <1448961206-23769-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1448961206-23769-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pulse-width modulator (PWM) feature is very common in
embedded systems. There exust 4 built-in PWM channels.

In general, the pwm pins can via the pinctrl to
configure iomux mode but the pwm2 since the pwm2 iomux mode from
the SoC control register.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 1f10b85..3b4cc84 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -472,6 +472,48 @@
 		status = "disabled";
 	};
 
+	pwm0: pwm at ff680000 {
+		compatible = "rockchip,rk3368-pwm", "rockchip,rk3288-pwm";
+		reg = <0x0 0xff680000 0x0 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm0_pin>;
+		clocks = <&cru PCLK_PWM1>;
+		clock-names = "pwm";
+		status = "disabled";
+	};
+
+	pwm1: pwm at ff680010 {
+		compatible = "rockchip,rk3368-pwm", "rockchip,rk3288-pwm";
+		reg = <0x0 0xff680010 0x0 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm1_pin>;
+		clocks = <&cru PCLK_PWM1>;
+		clock-names = "pwm";
+		status = "disabled";
+	};
+
+	pwm2: pwm at ff680020 {
+		compatible = "rockchip,rk3368-pwm", "rockchip,rk3288-pwm";
+		reg = <0x0 0xff680020 0x0 0x10>;
+		#pwm-cells = <3>;
+		clocks = <&cru PCLK_PWM1>;
+		clock-names = "pwm";
+		status = "disabled";
+	};
+
+	pwm3: pwm at ff680030 {
+		compatible = "rockchip,rk3368-pwm", "rockchip,rk3288-pwm";
+		reg = <0x0 0xff680030 0x0 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm3_pin>;
+		clocks = <&cru PCLK_PWM1>;
+		clock-names = "pwm";
+		status = "disabled";
+	};
+
 	uart2: serial at ff690000 {
 		compatible = "rockchip,rk3368-uart", "snps,dw-apb-uart";
 		reg = <0x0 0xff690000 0x0 0x100>;
@@ -713,6 +755,24 @@
 			};
 		};
 
+		pwm0 {
+			pwm0_pin: pwm0-pin {
+				rockchip,pins = <3 8 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		pwm1 {
+			pwm1_pin: pwm1-pin {
+				rockchip,pins = <0 8 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		pwm3 {
+			pwm3_pin: pwm3-pin {
+				rockchip,pins = <3 29 RK_FUNC_3 &pcfg_pull_none>;
+			};
+		};
+
 		sdio0 {
 			sdio0_bus1: sdio0-bus1 {
 				rockchip,pins = <2 28 RK_FUNC_1 &pcfg_pull_up>;
-- 
1.9.1
