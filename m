From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  4 Dec 2013 15:26:53 -0700
Subject: [PATCH 1/4] ARM: tegra: add I2C controllers to Tegra124 DT
Message-ID: <1386196016-25128-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra124 has 6 I2C controllers. The first 5 have identical configuration
to Tegra114, but the sixth obviously has different interrupt/... IDs.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 90 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 200373236aaa..7017e7ae0176 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -176,6 +176,96 @@
 		status = "disabled";
 	};
 
+	i2c at 7000c000 {
+		compatible = "nvidia,tegra114-i2c";
+		reg = <0x7000c000 0x100>;
+		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car TEGRA124_CLK_I2C1>;
+		clock-names = "div-clk";
+		resets = <&tegra_car 12>;
+		reset-names = "i2c";
+		dmas = <&apbdma 21>, <&apbdma 21>;
+		dma-names = "rx", "tx";
+		status = "disabled";
+	};
+
+	i2c at 7000c400 {
+		compatible = "nvidia,tegra114-i2c";
+		reg = <0x7000c400 0x100>;
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car TEGRA124_CLK_I2C2>;
+		clock-names = "div-clk";
+		resets = <&tegra_car 54>;
+		reset-names = "i2c";
+		dmas = <&apbdma 22>, <&apbdma 22>;
+		dma-names = "rx", "tx";
+		status = "disabled";
+	};
+
+	i2c at 7000c500 {
+		compatible = "nvidia,tegra114-i2c";
+		reg = <0x7000c500 0x100>;
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car TEGRA124_CLK_I2C3>;
+		clock-names = "div-clk";
+		resets = <&tegra_car 67>;
+		reset-names = "i2c";
+		dmas = <&apbdma 23>, <&apbdma 23>;
+		dma-names = "rx", "tx";
+		status = "disabled";
+	};
+
+	i2c at 7000c700 {
+		compatible = "nvidia,tegra114-i2c";
+		reg = <0x7000c700 0x100>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car TEGRA124_CLK_I2C4>;
+		clock-names = "div-clk";
+		resets = <&tegra_car 103>;
+		reset-names = "i2c";
+		dmas = <&apbdma 26>, <&apbdma 26>;
+		dma-names = "rx", "tx";
+		status = "disabled";
+	};
+
+	i2c at 7000d000 {
+		compatible = "nvidia,tegra114-i2c";
+		reg = <0x7000d000 0x100>;
+		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car TEGRA124_CLK_I2C5>;
+		clock-names = "div-clk";
+		resets = <&tegra_car 47>;
+		reset-names = "i2c";
+		dmas = <&apbdma 24>, <&apbdma 24>;
+		dma-names = "rx", "tx";
+		status = "disabled";
+	};
+
+	i2c at 7000d100 {
+		compatible = "nvidia,tegra114-i2c";
+		reg = <0x7000d100 0x100>;
+		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car TEGRA124_CLK_I2C6>;
+		clock-names = "div-clk";
+		resets = <&tegra_car 166>;
+		reset-names = "i2c";
+		dmas = <&apbdma 30>, <&apbdma 30>;
+		dma-names = "rx", "tx";
+		status = "disabled";
+	};
+
 	rtc at 7000e000 {
 		compatible = "nvidia,tegra124-rtc", "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
-- 
1.8.1.5
