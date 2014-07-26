From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 27 Jul 2014 01:18:25 +0200
Subject: [PATCH v2 09/15] ARM: dts: add rk3066 and rk3188 i2c device nodes and
 pinctrl settings
In-Reply-To: <1406416711-28006-1-git-send-email-heiko@sntech.de>
References: <1406416711-28006-1-git-send-email-heiko@sntech.de>
Message-ID: <1406416711-28006-10-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core controller settings themself are identical, only the compatible and
pinctrl settings differ.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 60 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3188.dtsi  | 65 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi  | 84 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 21b87de..18e802c 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -179,6 +179,41 @@
 			bias-disable;
 		};
 
+		i2c0 {
+			i2c0_xfer: i2c0-xfer {
+				rockchip,pins = <RK_GPIO2 28 RK_FUNC_1 &pcfg_pull_none>,
+						<RK_GPIO2 29 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2c1 {
+			i2c1_xfer: i2c1-xfer {
+				rockchip,pins = <RK_GPIO2 30 RK_FUNC_1 &pcfg_pull_none>,
+						<RK_GPIO2 31 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2c2 {
+			i2c2_xfer: i2c2-xfer {
+				rockchip,pins = <RK_GPIO3 0 RK_FUNC_1 &pcfg_pull_none>,
+						<RK_GPIO3 1 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2c3 {
+			i2c3_xfer: i2c3-xfer {
+				rockchip,pins = <RK_GPIO3 2 RK_FUNC_2 &pcfg_pull_none>,
+						<RK_GPIO3 3 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		i2c4 {
+			i2c4_xfer: i2c4-xfer {
+				rockchip,pins = <RK_GPIO3 4 RK_FUNC_1 &pcfg_pull_none>,
+						<RK_GPIO3 5 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		uart0 {
 			uart0_xfer: uart0-xfer {
 				rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_default>,
@@ -292,6 +327,31 @@
 	};
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_xfer>;
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_xfer>;
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_xfer>;
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_xfer>;
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_xfer>;
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index dd7f61f..ba1193c 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -147,6 +147,41 @@
 			bias-disable;
 		};
 
+		i2c0 {
+			i2c0_xfer: i2c0-xfer {
+				rockchip,pins = <RK_GPIO1 24 RK_FUNC_1 &pcfg_pull_none>,
+						<RK_GPIO1 25 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2c1 {
+			i2c1_xfer: i2c1-xfer {
+				rockchip,pins = <RK_GPIO1 26 RK_FUNC_1 &pcfg_pull_none>,
+						<RK_GPIO1 27 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2c2 {
+			i2c2_xfer: i2c2-xfer {
+				rockchip,pins = <RK_GPIO1 28 RK_FUNC_1 &pcfg_pull_none>,
+						<RK_GPIO1 29 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2c3 {
+			i2c3_xfer: i2c3-xfer {
+				rockchip,pins = <RK_GPIO3 14 RK_FUNC_2 &pcfg_pull_none>,
+						<RK_GPIO3 15 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		i2c4 {
+			i2c4_xfer: i2c4-xfer {
+				rockchip,pins = <RK_GPIO1 30 RK_FUNC_1 &pcfg_pull_none>,
+						<RK_GPIO1 31 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		uart0 {
 			uart0_xfer: uart0-xfer {
 				rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_up>,
@@ -272,6 +307,36 @@
 	interrupts = <GIC_PPI 13 0xf04>;
 };
 
+&i2c0 {
+	compatible = "rockchip,rk3188-i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_xfer>;
+};
+
+&i2c1 {
+	compatible = "rockchip,rk3188-i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_xfer>;
+};
+
+&i2c2 {
+	compatible = "rockchip,rk3188-i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_xfer>;
+};
+
+&i2c3 {
+	compatible = "rockchip,rk3188-i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_xfer>;
+};
+
+&i2c4 {
+	compatible = "rockchip,rk3188-i2c";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_xfer>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_xfer>;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index ad204da..d3fa4d1 100644
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
 	xin24m: oscillator {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
@@ -117,6 +125,82 @@
 		reg = <0x20008000 0x200>;
 	};
 
+	i2c0: i2c at 2002d000 {
+		compatible = "rockchip,rk3066-i2c";
+		reg = <0x2002d000 0x1000>;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rockchip,grf = <&grf>;
+		rockchip,bus-index = <0>;
+
+		clock-names = "i2c";
+		clocks = <&cru PCLK_I2C0>;
+
+		status = "disabled";
+	};
+
+	i2c1: i2c at 2002f000 {
+		compatible = "rockchip,rk3066-i2c";
+		reg = <0x2002f000 0x1000>;
+		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rockchip,grf = <&grf>;
+
+		clocks = <&cru PCLK_I2C1>;
+		clock-names = "i2c";
+
+		status = "disabled";
+	};
+
+	i2c2: i2c at 20056000 {
+		compatible = "rockchip,rk3066-i2c";
+		reg = <0x20056000 0x1000>;
+		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rockchip,grf = <&grf>;
+
+		clocks = <&cru PCLK_I2C2>;
+		clock-names = "i2c";
+
+		status = "disabled";
+	};
+
+	i2c3: i2c at 2005a000 {
+		compatible = "rockchip,rk3066-i2c";
+		reg = <0x2005a000 0x1000>;
+		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rockchip,grf = <&grf>;
+
+		clocks = <&cru PCLK_I2C3>;
+		clock-names = "i2c";
+
+		status = "disabled";
+	};
+
+	i2c4: i2c at 2005e000 {
+		compatible = "rockchip,rk3066-i2c";
+		reg = <0x2005e000 0x1000>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rockchip,grf = <&grf>;
+
+		clocks = <&cru PCLK_I2C4>;
+		clock-names = "i2c";
+
+		status = "disabled";
+	};
+
 	uart2: serial at 20064000 {
 		compatible = "snps,dw-apb-uart";
 		reg = <0x20064000 0x400>;
-- 
2.0.1
