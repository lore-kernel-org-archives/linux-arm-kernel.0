From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 8 Mar 2013 19:23:02 +0530
Subject: [PATCH 5/5] ARM: DT: tegra114: Add spi controller DT entry
In-Reply-To: <1362750782-15174-1-git-send-email-ldewangan@nvidia.com>
References: <1362750782-15174-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1362750782-15174-6-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVIDIA's Tegra114 has 6 spi controllers. These controllers are
redesign on T114 with different register interface.

Add DT entry for spi controllers and make it compatible with
"nvidia,tegra114-spi".

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi |   72 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 18fbd49..5f5c403 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -209,6 +209,78 @@
 		clock-names = "div-clk";
 	};
 
+	spi at 7000d400 {
+		compatible = "nvidia,tegra114-spi";
+		reg = <0x7000d400 0x200>;
+		interrupts = <0 59 0x04>;
+		nvidia,dma-request-selector = <&apbdma 15>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car 41>;
+		clock-names = "spi";
+		status = "disabled";
+	};
+
+	spi at 7000d600 {
+		compatible = "nvidia,tegra114-spi";
+		reg = <0x7000d600 0x200>;
+		interrupts = <0 82 0x04>;
+		nvidia,dma-request-selector = <&apbdma 16>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car 44>;
+		clock-names = "spi";
+		status = "disabled";
+	};
+
+	spi at 7000d800 {
+		compatible = "nvidia,tegra114-spi";
+		reg = <0x7000d480 0x200>;
+		interrupts = <0 83 0x04>;
+		nvidia,dma-request-selector = <&apbdma 17>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car 46>;
+		clock-names = "spi";
+		status = "disabled";
+	};
+
+	spi at 7000da00 {
+		compatible = "nvidia,tegra114-spi";
+		reg = <0x7000da00 0x200>;
+		interrupts = <0 93 0x04>;
+		nvidia,dma-request-selector = <&apbdma 18>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car 68>;
+		clock-names = "spi";
+		status = "disabled";
+	};
+
+	spi at 7000dc00 {
+		compatible = "nvidia,tegra114-spi";
+		reg = <0x7000dc00 0x200>;
+		interrupts = <0 94 0x04>;
+		nvidia,dma-request-selector = <&apbdma 27>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car 104>;
+		clock-names = "spi";
+		status = "disabled";
+	};
+
+	spi at 7000de00 {
+		compatible = "nvidia,tegra114-spi";
+		reg = <0x7000de00 0x200>;
+		interrupts = <0 79 0x04>;
+		nvidia,dma-request-selector = <&apbdma 28>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car 105>;
+		clock-names = "spi";
+		status = "disabled";
+	};
+
 	sdhci at 78000000 {
 		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
 		reg = <0x78000000 0x200>;
-- 
1.7.1.1
