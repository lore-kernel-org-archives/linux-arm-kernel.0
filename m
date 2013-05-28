From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 May 2013 11:43:51 -0600
Subject: [PATCH] ARM: tegra: add audio-related nodes to Tegra114 DT
Message-ID: <1369763031-13687-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Add nodes for the Tegra114 AHUB and I2S controllers.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi |   71 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 2eab52e..4ce77ba 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -327,6 +327,77 @@
 		nvidia,ahb = <&ahb>;
 	};
 
+	ahub {
+		compatible = "nvidia,tegra114-ahub";
+		reg = <0x70080000 0x200>,
+		      <0x70080200 0x100>,
+		      <0x70081000 0x200>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		nvidia,dma-request-selector = <&apbdma 1>, <&apbdma 2>,
+			<&apbdma 3>, <&apbdma 4>, <&apbdma 6>, <&apbdma 7>,
+			<&apbdma 12>, <&apbdma 13>, <&apbdma 14>,
+			<&apbdma 29>;
+		clocks = <&tegra_car TEGRA114_CLK_D_AUDIO>,
+			 <&tegra_car TEGRA114_CLK_APBIF>,
+			 <&tegra_car TEGRA114_CLK_I2S0>,
+			 <&tegra_car TEGRA114_CLK_I2S1>,
+			 <&tegra_car TEGRA114_CLK_I2S2>,
+			 <&tegra_car TEGRA114_CLK_I2S3>,
+			 <&tegra_car TEGRA114_CLK_I2S4>,
+			 <&tegra_car TEGRA114_CLK_DAM0>,
+			 <&tegra_car TEGRA114_CLK_DAM1>,
+			 <&tegra_car TEGRA114_CLK_DAM2>,
+			 <&tegra_car TEGRA114_CLK_SPDIF_IN>,
+			 <&tegra_car TEGRA114_CLK_AMX>,
+			 <&tegra_car TEGRA114_CLK_ADX>;
+		clock-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
+			      "i2s3", "i2s4", "dam0", "dam1", "dam2",
+			      "spdif_in", "amx", "adx";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		tegra_i2s0: i2s at 70080300 {
+			compatible = "nvidia,tegra114-i2s", "nvidia,tegra30-i2s";
+			reg = <0x70080300 0x100>;
+			nvidia,ahub-cif-ids = <4 4>;
+			clocks = <&tegra_car TEGRA114_CLK_I2S0>;
+			status = "disabled";
+		};
+
+		tegra_i2s1: i2s at 70080400 {
+			compatible = "nvidia,tegra114-i2s", "nvidia,tegra30-i2s";
+			reg = <0x70080400 0x100>;
+			nvidia,ahub-cif-ids = <5 5>;
+			clocks = <&tegra_car TEGRA114_CLK_I2S1>;
+			status = "disabled";
+		};
+
+		tegra_i2s2: i2s at 70080500 {
+			compatible = "nvidia,tegra114-i2s", "nvidia,tegra30-i2s";
+			reg = <0x70080500 0x100>;
+			nvidia,ahub-cif-ids = <6 6>;
+			clocks = <&tegra_car TEGRA114_CLK_I2S2>;
+			status = "disabled";
+		};
+
+		tegra_i2s3: i2s at 70080600 {
+			compatible = "nvidia,tegra114-i2s", "nvidia,tegra30-i2s";
+			reg = <0x70080600 0x100>;
+			nvidia,ahub-cif-ids = <7 7>;
+			clocks = <&tegra_car TEGRA114_CLK_I2S3>;
+			status = "disabled";
+		};
+
+		tegra_i2s4: i2s at 70080700 {
+			compatible = "nvidia,tegra114-i2s", "nvidia,tegra30-i2s";
+			reg = <0x70080700 0x100>;
+			nvidia,ahub-cif-ids = <8 8>;
+			clocks = <&tegra_car TEGRA114_CLK_I2S4>;
+			status = "disabled";
+		};
+	};
+
 	sdhci at 78000000 {
 		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
 		reg = <0x78000000 0x200>;
-- 
1.7.10.4
