From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 22 Jun 2016 10:16:05 +0800
Subject: [PATCH v2 2/4] ARM: dts: rockchip: add i2s nodes for RK322x SoCs
In-Reply-To: <1466561768-29770-1-git-send-email-zhengxing@rock-chips.com>
References: <1466561768-29770-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1466561768-29770-3-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the i2s dt nodes for rk322x SoCs.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v2: None

 arch/arm/boot/dts/rk322x.dtsi |   55 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index a68fdcaf..d5626705 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -237,6 +237,47 @@
 		status = "disabled";
 	};
 
+	i2s1: i2s1 at 100b0000 {
+		compatible = "rockchip,rk3228-i2s", "rockchip,rk3066-i2s";
+		reg = <0x100b0000 0x4000>;
+		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		clocks = <&cru SCLK_I2S1>, <&cru HCLK_I2S1_8CH>;
+		dmas = <&pdma 14>, <&pdma 15>;
+		dma-names = "tx", "rx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s1_bus>;
+		status = "disabled";
+	};
+
+	i2s0: i2s0 at 100c0000 {
+		compatible = "rockchip,rk3228-i2s", "rockchip,rk3066-i2s";
+		reg = <0x100c0000 0x4000>;
+		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0_8CH>;
+		dmas = <&pdma 11>, <&pdma 12>;
+		dma-names = "tx", "rx";
+		status = "disabled";
+	};
+
+	i2s2: i2s2 at 100e0000 {
+		compatible = "rockchip,rk3228-i2s", "rockchip,rk3066-i2s";
+		reg = <0x100e0000 0x4000>;
+		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		clocks = <&cru SCLK_I2S2>, <&cru HCLK_I2S2_2CH>;
+		dmas = <&pdma 0>, <&pdma 1>;
+		dma-names = "tx", "rx";
+		status = "disabled";
+	};
+
 	pwm0: pwm at 110b0000 {
 		compatible = "rockchip,rk3288-pwm";
 		reg = <0x110b0000 0x10>;
@@ -507,6 +548,20 @@
 			};
 		};
 
+		i2s1 {
+			i2s1_bus: i2s1-bus {
+				rockchip,pins = <0 8 RK_FUNC_1 &pcfg_pull_none>,
+						<0 9 RK_FUNC_1 &pcfg_pull_none>,
+						<0 11 RK_FUNC_1 &pcfg_pull_none>,
+						<0 12 RK_FUNC_1 &pcfg_pull_none>,
+						<0 13 RK_FUNC_1 &pcfg_pull_none>,
+						<0 14 RK_FUNC_1 &pcfg_pull_none>,
+						<1 2 RK_FUNC_1 &pcfg_pull_none>,
+						<1 4 RK_FUNC_1 &pcfg_pull_none>,
+						<1 5 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		pwm0 {
 			pwm0_pin: pwm0-pin {
 				rockchip,pins = <3 21 RK_FUNC_1 &pcfg_pull_none>;
-- 
1.7.9.5
