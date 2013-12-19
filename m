From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Dec 2013 17:06:18 +0100
Subject: [PATCH 06/10] ARM: tegra: Add SPI controller nodes for Tegra124
In-Reply-To: <1387469182-14398-1-git-send-email-treding@nvidia.com>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
Message-ID: <1387469182-14398-7-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPI controllers on Tegra124 are compatible with those found on the
Tegra114 SoC.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 90 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 39d77aa936f9..cf4558257e8c 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -430,6 +430,96 @@
 		status = "disabled";
 	};
 
+	spi at 7000d400 {
+		compatible = "nvidia,tegra124-spi", "nvidia,tegra114-spi";
+		reg = <0x7000d400 0x200>;
+		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car TEGRA124_CLK_SBC1>;
+		clock-names = "spi";
+		resets = <&tegra_car 41>;
+		reset-names = "spi";
+		dmas = <&apbdma 15>, <&apbdma 15>;
+		dma-names = "rx", "tx";
+		status = "disabled";
+	};
+
+	spi at 7000d600 {
+		compatible = "nvidia,tegra124-spi", "nvidia,tegra114-spi";
+		reg = <0x7000d600 0x200>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car TEGRA124_CLK_SBC2>;
+		clock-names = "spi";
+		resets = <&tegra_car 44>;
+		reset-names = "spi";
+		dmas = <&apbdma 16>, <&apbdma 16>;
+		dma-names = "rx", "tx";
+		status = "disabled";
+	};
+
+	spi at 7000d800 {
+		compatible = "nvidia,tegra124-spi", "nvidia,tegra114-spi";
+		reg = <0x7000d800 0x200>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car TEGRA124_CLK_SBC3>;
+		clock-names = "spi";
+		resets = <&tegra_car 46>;
+		reset-names = "spi";
+		dmas = <&apbdma 17>, <&apbdma 17>;
+		dma-names = "rx", "tx";
+		status = "disabled";
+	};
+
+	spi at 7000da00 {
+		compatible = "nvidia,tegra124-spi", "nvidia,tegra114-spi";
+		reg = <0x7000da00 0x200>;
+		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car TEGRA124_CLK_SBC4>;
+		clock-names = "spi";
+		resets = <&tegra_car 68>;
+		reset-names = "spi";
+		dmas = <&apbdma 18>, <&apbdma 18>;
+		dma-names = "rx", "tx";
+		status = "disabled";
+	};
+
+	spi at 7000dc00 {
+		compatible = "nvidia,tegra124-spi", "nvidia,tegra114-spi";
+		reg = <0x7000dc00 0x200>;
+		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car TEGRA124_CLK_SBC5>;
+		clock-names = "spi";
+		resets = <&tegra_car 104>;
+		reset-names = "spi";
+		dmas = <&apbdma 27>, <&apbdma 27>;
+		dma-names = "rx", "tx";
+		status = "disabled";
+	};
+
+	spi at 7000de00 {
+		compatible = "nvidia,tegra124-spi", "nvidia,tegra114-spi";
+		reg = <0x7000de00 0x200>;
+		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car TEGRA124_CLK_SBC6>;
+		clock-names = "spi";
+		resets = <&tegra_car 105>;
+		reset-names = "spi";
+		dmas = <&apbdma 28>, <&apbdma 28>;
+		dma-names = "rx", "tx";
+		status = "disabled";
+	};
+
 	rtc at 7000e000 {
 		compatible = "nvidia,tegra124-rtc", "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
-- 
1.8.4.2
