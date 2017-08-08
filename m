From: david.wu@rock-chips.com (David Wu)
Date: Tue,  8 Aug 2017 23:43:15 +0800
Subject: [PATCH v3 7/7] arm64: dts: rockchip: Add pwm nodes for rk3328
In-Reply-To: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1502206995-24418-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are 4 pwm channels built in rk3328 soc, need to configure
the both APB clock and bus clock.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 45 ++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 7e69f1f..1f945d3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -308,6 +308,51 @@
 		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	pwm0: pwm at ff1b0000 {
+		compatible = "rockchip,rk3328-pwm";
+		reg = <0x0 0xff1b0000 0x0 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm0_pin>;
+		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
+	pwm1: pwm at ff1b0010 {
+		compatible = "rockchip,rk3328-pwm";
+		reg = <0x0 0xff1b0010 0x0 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm1_pin>;
+		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
+	pwm2: pwm at ff1b0020 {
+		compatible = "rockchip,rk3328-pwm";
+		reg = <0x0 0xff1b0020 0x0 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm2_pin>;
+		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
+	pwm3: pwm at ff1b0030 {
+		compatible = "rockchip,rk3328-pwm";
+		reg = <0x0 0xff1b0030 0x0 0x10>;
+		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwmir_pin>;
+		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
 	saradc: adc at ff280000 {
 		compatible = "rockchip,rk3328-saradc", "rockchip,rk3399-saradc";
 		reg = <0x0 0xff280000 0x0 0x100>;
-- 
1.9.1
