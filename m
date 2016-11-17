From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Nov 2016 18:11:26 +0100
Subject: [PATCH 4/9] arm64: tegra: Add I2C controllers on Tegra186
In-Reply-To: <20161117171131.20062-1-thierry.reding@gmail.com>
References: <20161117171131.20062-1-thierry.reding@gmail.com>
Message-ID: <20161117171131.20062-4-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Tegra186 has a total of nine I2C controllers that are compatible with
the I2C controllers introduced in Tegra114. Two of these controllers
share pads with two DPAUX controllers (for AUX transactions).

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 120 +++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 911f288966ba..b1a77d78d202 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -69,6 +69,100 @@
 		status = "disabled";
 	};
 
+	gen1_i2c: i2c at 3160000 {
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x03160000 0x0 0x10000>;
+		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA186_CLK_I2C1>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA186_RESET_I2C1>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	cam_i2c: i2c at 3180000 {
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x03180000 0x0 0x10000>;
+		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA186_CLK_I2C3>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA186_RESET_I2C3>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	/* shares pads with dpaux1 */
+	dp_aux_ch1_i2c: i2c at 3190000 {
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x03190000 0x0 0x10000>;
+		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA186_CLK_I2C4>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA186_RESET_I2C4>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	/* controlled by BPMP, should not be enabled */
+	pwr_i2c: i2c at 31a0000 {
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x031a0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA186_CLK_I2C5>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA186_RESET_I2C5>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	/* shares pads with dpaux0 */
+	dp_aux_ch0_i2c: i2c at 31b0000 {
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x031b0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA186_CLK_I2C6>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA186_RESET_I2C6>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	gen7_i2c: i2c at 31c0000 {
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x031c0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA186_CLK_I2C7>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA186_RESET_I2C7>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	gen9_i2c: i2c at 31e0000 {
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x031e0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA186_CLK_I2C9>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA186_RESET_I2C9>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
 	gic: interrupt-controller at 3881000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
@@ -89,6 +183,32 @@
 		status = "disabled";
 	};
 
+	gen2_i2c: i2c at c240000 {
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x0c240000 0x0 0x10000>;
+		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA186_CLK_I2C2>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA186_RESET_I2C2>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	gen8_i2c: i2c at c250000 {
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x0c250000 0x0 0x10000>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA186_CLK_I2C8>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA186_RESET_I2C8>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
 	uartc: serial at c280000 {
 		compatible = "nvidia,tegra186-uart", "nvidia,tegra20-uart";
 		reg = <0x0 0x0c280000 0x0 0x40>;
-- 
2.10.2
