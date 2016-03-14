From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 14 Mar 2016 11:11:42 +0800
Subject: [PATCH 2/2] ARM: dts: rockchip: add i2c nodes RK3228 SoCs
In-Reply-To: <1457924955-29996-1-git-send-email-ykk@rock-chips.com>
References: <1457924955-29996-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1457925102-30476-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the i2c dt nodes for rk3228 SoCs.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 arch/arm/boot/dts/rk3228.dtsi | 80 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/rk3228.dtsi b/arch/arm/boot/dts/rk3228.dtsi
index 119ff12..a159296 100644
--- a/arch/arm/boot/dts/rk3228.dtsi
+++ b/arch/arm/boot/dts/rk3228.dtsi
@@ -185,6 +185,58 @@
 		status = "disabled";
 	};
 
+	i2c0: i2c at 11050000 {
+		compatible = "rockchip,rk3228-i2c";
+		reg = <0x11050000 0x1000>;
+		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "i2c";
+		clocks = <&cru PCLK_I2C0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c0_xfer>;
+		status = "disabled";
+	};
+
+	i2c1: i2c at 11060000 {
+		compatible = "rockchip,rk3228-i2c";
+		reg = <0x11060000 0x1000>;
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "i2c";
+		clocks = <&cru PCLK_I2C1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_xfer>;
+		status = "disabled";
+	};
+
+	i2c2: i2c at 11070000 {
+		compatible = "rockchip,rk3228-i2c";
+		reg = <0x11070000 0x1000>;
+		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "i2c";
+		clocks = <&cru PCLK_I2C2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c2_xfer>;
+		status = "disabled";
+	};
+
+	i2c3: i2c at 11080000 {
+		compatible = "rockchip,rk3228-i2c";
+		reg = <0x11080000 0x1000>;
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "i2c";
+		clocks = <&cru PCLK_I2C3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c3_xfer>;
+		status = "disabled";
+	};
+
 	pwm0: pwm at 110b0000 {
 		compatible = "rockchip,rk3288-pwm";
 		reg = <0x110b0000 0x10>;
@@ -349,6 +401,34 @@
 			bias-disable;
 		};
 
+		i2c0 {
+			i2c0_xfer: i2c0-xfer {
+				rockchip,pins = <0 0 RK_FUNC_1 &pcfg_pull_none>,
+						<0 1 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2c1 {
+			i2c1_xfer: i2c1-xfer {
+				rockchip,pins = <0 2 RK_FUNC_1 &pcfg_pull_none>,
+						<0 3 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2c2 {
+			i2c2_xfer: i2c2-xfer {
+				rockchip,pins = <2 20 RK_FUNC_1 &pcfg_pull_none>,
+						<2 21 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2c3 {
+			i2c3_xfer: i2c3-xfer {
+				rockchip,pins = <0 6 RK_FUNC_1 &pcfg_pull_none>,
+						<0 7 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		emmc {
 			emmc_clk: emmc-clk {
 				rockchip,pins = <2 7 RK_FUNC_2 &pcfg_pull_none>;
-- 
1.9.1
