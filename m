From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 12 Jul 2014 21:28:25 +0200
Subject: [PATCH 1/7] ARM: dts: add rk3066 and rk3188 i2c device nodes and
 pinctrl settings
In-Reply-To: <16344051.ZPa9bzz4Fj@diego>
References: <16344051.ZPa9bzz4Fj@diego>
Message-ID: <11246141.nU5kkFjLV0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The controller settings themself are identical, only the pinctrl settings differ.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 35 ++++++++++++++++++
 arch/arm/boot/dts/rk3188.dtsi  | 55 +++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi  | 84 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index b705a60..3cfdb43 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -181,6 +181,41 @@
 				bias-disable;
 			};
 
+			i2c0 {
+				i2c0_pins: i2c0-pins {
+					rockchip,pins = <RK_GPIO2 28 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO2 29 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			i2c1 {
+				i2c1_pins: i2c1-pins {
+					rockchip,pins = <RK_GPIO2 30 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO2 31 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			i2c2 {
+				i2c2_pins: i2c2-pins {
+					rockchip,pins = <RK_GPIO3 0 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO3 1 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			i2c3 {
+				i2c3_pins: i2c3-pins {
+					rockchip,pins = <RK_GPIO3 2 RK_FUNC_2 &pcfg_pull_none>,
+							<RK_GPIO3 3 RK_FUNC_2 &pcfg_pull_none>;
+				};
+			};
+
+			i2c4 {
+				i2c4_pins: i2c4-pins {
+					rockchip,pins = <RK_GPIO3 4 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO3 5 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
 			uart0 {
 				uart0_xfer: uart0-xfer {
 					rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_default>,
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index ddca355..fc3b0dd 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -156,6 +156,41 @@
 				bias-disable;
 			};
 
+			i2c0 {
+				i2c0_pins: i2c0-pins {
+					rockchip,pins = <RK_GPIO1 24 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO1 25 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			i2c1 {
+				i2c1_pins: i2c1-pins {
+					rockchip,pins = <RK_GPIO1 26 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO1 27 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			i2c2 {
+				i2c2_pins: i2c2-pins {
+					rockchip,pins = <RK_GPIO1 28 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO1 29 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			i2c3 {
+				i2c3_pins: i2c3-pins {
+					rockchip,pins = <RK_GPIO3 14 RK_FUNC_2 &pcfg_pull_none>,
+							<RK_GPIO3 15 RK_FUNC_2 &pcfg_pull_none>;
+				};
+			};
+
+			i2c4 {
+				i2c4_pins: i2c4-pins {
+					rockchip,pins = <RK_GPIO1 30 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO1 31 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
 			uart0 {
 				uart0_xfer: uart0-xfer {
 					rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_up>,
@@ -271,5 +306,25 @@
 				};
 			};
 		};
+
+		i2c0: i2c at 2002d000 {
+			compatible = "rockchip,rk3188-i2c";
+		};
+
+		i2c1: i2c at 2002f000 {
+			compatible = "rockchip,rk3188-i2c";
+		};
+
+		i2c2: i2c at 20056000 {
+			compatible = "rockchip,rk3188-i2c";
+		};
+
+		i2c3: i2c at 2005a000 {
+			compatible = "rockchip,rk3188-i2c";
+		};
+
+		i2c4: i2c at 2005e000 {
+			compatible = "rockchip,rk3188-i2c";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 0de3f06..86062a0 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -20,6 +20,14 @@
 / {
 	interrupt-parent = <&gic>;
 
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -141,5 +149,81 @@
 
 			status = "disabled";
 		};
+
+		i2c0: i2c at 2002d000 {
+			compatible = "rockchip,rk3066-i2c";
+			reg = <0x2002d000 0x1000>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rockchip,grf = <&grf>;
+			rockchip,bus-index = <0>;
+
+			clock-names = "i2c";
+			clocks = <&cru PCLK_I2C0>;
+
+			status = "disabled";
+		};
+
+		i2c1: i2c at 2002f000 {
+			compatible = "rockchip,rk3066-i2c";
+			reg = <0x2002f000 0x1000>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rockchip,grf = <&grf>;
+
+			clocks = <&cru PCLK_I2C1>;
+			clock-names = "i2c";
+
+			status = "disabled";
+		};
+
+		i2c2: i2c at 20056000 {
+			compatible = "rockchip,rk3066-i2c";
+			reg = <0x20056000 0x1000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rockchip,grf = <&grf>;
+
+			clocks = <&cru PCLK_I2C2>;
+			clock-names = "i2c";
+
+			status = "disabled";
+		};
+
+		i2c3: i2c at 2005a000 {
+			compatible = "rockchip,rk3066-i2c";
+			reg = <0x2005a000 0x1000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rockchip,grf = <&grf>;
+
+			clocks = <&cru PCLK_I2C3>;
+			clock-names = "i2c";
+
+			status = "disabled";
+		};
+
+		i2c4: i2c at 2005e000 {
+			compatible = "rockchip,rk3066-i2c";
+			reg = <0x2005e000 0x1000>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rockchip,grf = <&grf>;
+
+			clocks = <&cru PCLK_I2C4>;
+			clock-names = "i2c";
+
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.0
