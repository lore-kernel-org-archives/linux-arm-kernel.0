From: huibin.hong@rock-chips.com (Huibin Hong)
Date: Mon,  7 Aug 2017 09:45:11 +0800
Subject: [PATCH] RM: dts: rockchip: rk322x: add spi node and spi pinctrl
Message-ID: <1502070311-19663-1-git-send-email-huibin.hong@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add spi node and spi pinctrl for rk322x

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
---

 arch/arm/boot/dts/rk322x.dtsi | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index f3e4ffd..1a7afef 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -55,6 +55,7 @@
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
+		spi0 = &spi0;
 	};
 
 	cpus {
@@ -361,6 +362,19 @@
 		status = "disabled";
 	};
 
+	spi0: spi at 11090000 {
+		compatible = "rockchip,rk3228-spi";
+		reg = <0x11090000 0x1000>;
+		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0 &spi0_cs1>;
+		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
+		clock-names = "spiclk", "apb_pclk";
+		status = "disabled";
+	};
+
 	wdt: watchdog at 110a0000 {
 		compatible = "snps,dw-wdt";
 		reg = <0x110a0000 0x100>;
@@ -797,6 +811,42 @@
 			};
 		};
 
+		spi-0 {
+			spi0_clk: spi0-clk {
+				rockchip,pins = <0 9 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi0_cs0: spi0-cs0 {
+				rockchip,pins = <0 14 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi0_tx: spi0-tx {
+				rockchip,pins = <0 11 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi0_rx: spi0-rx {
+				rockchip,pins = <0 13 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi0_cs1: spi0-cs1 {
+				rockchip,pins = <1 12 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
+		spi-1 {
+			spi1_clk: spi1-clk {
+				rockchip,pins = <0 23 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi1_cs0: spi1-cs0 {
+				rockchip,pins = <2 2 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi1_rx: spi1-rx {
+				rockchip,pins = <2 0 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi1_tx: spi1-tx {
+				rockchip,pins = <2 1 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi1_cs1: spi1-cs1 {
+				rockchip,pins = <2 3 RK_FUNC_2 &pcfg_pull_up>;
+			};
+		};
+
 		i2s1 {
 			i2s1_bus: i2s1-bus {
 				rockchip,pins = <0 8 RK_FUNC_1 &pcfg_pull_none>,
-- 
1.9.1
