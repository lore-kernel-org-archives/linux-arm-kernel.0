From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 10 Sep 2014 20:46:53 +0200
Subject: [PATCH 4/6] ARM: dts: rockchip: add Cortex-A9 SPI controller nodes
In-Reply-To: <1410374815-20208-1-git-send-email-heiko@sntech.de>
References: <1410374815-20208-1-git-send-email-heiko@sntech.de>
Message-ID: <1410374815-20208-5-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds basic spi nodes and pinctrl settings to the rk3066 and rk3188
devicetree files.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 46 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3188.dtsi  | 48 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi  | 24 +++++++++++++++++++++
 3 files changed, 118 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 879a818..8021eed 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -238,6 +238,42 @@
 			};
 		};
 
+		spi0 {
+			spi0_clk: spi0-clk {
+				rockchip,pins = <RK_GPIO1 5 RK_FUNC_2 &pcfg_pull_default>;
+			};
+			spi0_cs0: spi0-cs0 {
+				rockchip,pins = <RK_GPIO1 4 RK_FUNC_2 &pcfg_pull_default>;
+			};
+			spi0_tx: spi0-tx {
+				rockchip,pins = <RK_GPIO1 7 RK_FUNC_2 &pcfg_pull_default>;
+			};
+			spi0_rx: spi0-rx {
+				rockchip,pins = <RK_GPIO1 6 RK_FUNC_2 &pcfg_pull_default>;
+			};
+			spi0_cs1: spi0-cs1 {
+				rockchip,pins = <RK_GPIO4 15 RK_FUNC_1 &pcfg_pull_default>;
+			};
+		};
+
+		spi1 {
+			spi1_clk: spi1-clk {
+				rockchip,pins = <RK_GPIO2 19 RK_FUNC_2 &pcfg_pull_default>;
+			};
+			spi1_cs0: spi1-cs0 {
+				rockchip,pins = <RK_GPIO2 20 RK_FUNC_2 &pcfg_pull_default>;
+			};
+			spi1_rx: spi1-rx {
+				rockchip,pins = <RK_GPIO2 22 RK_FUNC_2 &pcfg_pull_default>;
+			};
+			spi1_tx: spi1-tx {
+				rockchip,pins = <RK_GPIO2 21 RK_FUNC_2 &pcfg_pull_default>;
+			};
+			spi1_cs1: spi1-cs1 {
+				rockchip,pins = <RK_GPIO2 23 RK_FUNC_2 &pcfg_pull_default>;
+			};
+		};
+
 		uart0 {
 			uart0_xfer: uart0-xfer {
 				rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_default>,
@@ -406,6 +442,16 @@
 	pinctrl-0 = <&pwm3_out>;
 };
 
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0>;
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_clk &spi1_tx &spi1_rx &spi1_cs0>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_xfer>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index ee801a9..573ef61 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -206,6 +206,42 @@
 			};
 		};
 
+		spi0 {
+			spi0_clk: spi0-clk {
+				rockchip,pins = <RK_GPIO1 6 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi0_cs0: spi0-cs0 {
+				rockchip,pins = <RK_GPIO1 7 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi0_tx: spi0-tx {
+				rockchip,pins = <RK_GPIO1 5 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi0_rx: spi0-rx {
+				rockchip,pins = <RK_GPIO1 4 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi0_cs1: spi0-cs1 {
+				rockchip,pins = <RK_GPIO1 15 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
+		spi1 {
+			spi1_clk: spi1-clk {
+				rockchip,pins = <RK_GPIO0 30 RK_FUNC_1 &pcfg_pull_up>;
+			};
+			spi1_cs0: spi1-cs0 {
+				rockchip,pins = <RK_GPIO0 31 RK_FUNC_1 &pcfg_pull_up>;
+			};
+			spi1_rx: spi1-rx {
+				rockchip,pins = <RK_GPIO0 28 RK_FUNC_1 &pcfg_pull_up>;
+			};
+			spi1_tx: spi1-tx {
+				rockchip,pins = <RK_GPIO0 29 RK_FUNC_1 &pcfg_pull_up>;
+			};
+			spi1_cs1: spi1-cs1 {
+				rockchip,pins = <RK_GPIO1 14 RK_FUNC_2 &pcfg_pull_up>;
+			};
+		};
+
 		uart0 {
 			uart0_xfer: uart0-xfer {
 				rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_up>,
@@ -381,6 +417,18 @@
 	pinctrl-0 = <&pwm3_out>;
 };
 
+&spi0 {
+	compatible = "rockchip,rk3188-spi", "rockchip,rk3066-spi";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0>;
+};
+
+&spi1 {
+	compatible = "rockchip,rk3188-spi", "rockchip,rk3066-spi";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_clk &spi1_tx &spi1_rx &spi1_cs0>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_xfer>;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index c873624..7bcd698 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -26,6 +26,8 @@
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
+		spi0 = &spi0;
+		spi1 = &spi1;
 	};
 
 	xin24m: oscillator {
@@ -291,4 +293,26 @@
 		clock-names = "saradc", "apb_pclk";
 		status = "disabled";
 	};
+
+	spi0: spi at 20070000 {
+		compatible = "rockchip,rk3066-spi";
+		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
+		clock-names = "spiclk", "apb_pclk";
+		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x20070000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi1: spi at 20074000 {
+		compatible = "rockchip,rk3066-spi";
+		clocks = <&cru SCLK_SPI1>, <&cru PCLK_SPI1>;
+		clock-names = "spiclk", "apb_pclk";
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x20074000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 };
-- 
2.0.1
