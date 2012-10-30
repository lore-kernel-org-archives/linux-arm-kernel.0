From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 30 Oct 2012 12:35:23 +0530
Subject: [PATCH V3 1/4] ARM: tegra: dts: add slink controller dt entry
In-Reply-To: <1351580726-17350-1-git-send-email-ldewangan@nvidia.com>
References: <1351580726-17350-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1351580726-17350-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add slink controller details in the dts file of
Tegra20 and Tegra30.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
-rename the dma request prop to nvidia,dma-request-selector.

Changes from V2:
- Make node name as spi at .

 arch/arm/boot/dts/tegra20.dtsi |   41 +++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi |   60 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 6934bca..ecd3b4f 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -186,6 +186,47 @@
 		status = "disabled";
 	};
 
+	spi at 7000d400 {
+
+		compatible = "nvidia,tegra20-slink";
+		reg = <0x7000d400 0x200>;
+		interrupts = <0 59 0x04>;
+		nvidia,dma-request-selector = <&apbdma 15>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi at 7000d600 {
+		compatible = "nvidia,tegra20-slink";
+		reg = <0x7000d600 0x200>;
+		interrupts = <0 82 0x04>;
+		nvidia,dma-request-selector = <&apbdma 16>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi at 7000d800 {
+		compatible = "nvidia,tegra20-slink";
+		reg = <0x7000d480 0x200>;
+		interrupts = <0 83 0x04>;
+		nvidia,dma-request-selector = <&apbdma 17>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi at 7000da00 {
+		compatible = "nvidia,tegra20-slink";
+		reg = <0x7000da00 0x200>;
+		interrupts = <0 93 0x04>;
+		nvidia,dma-request-selector = <&apbdma 18>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	pmc {
 		compatible = "nvidia,tegra20-pmc";
 		reg = <0x7000e400 0x400>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 81f5df4..ab6cfb0 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -191,6 +191,66 @@
 		status = "disabled";
 	};
 
+	spi at 7000d400 {
+		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
+		reg = <0x7000d400 0x200>;
+		interrupts = <0 59 0x04>;
+		nvidia,dma-request-selector = <&apbdma 15>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi at 7000d600 {
+		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
+		reg = <0x7000d600 0x200>;
+		interrupts = <0 82 0x04>;
+		nvidia,dma-request-selector = <&apbdma 16>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi at 7000d800 {
+		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
+		reg = <0x7000d480 0x200>;
+		interrupts = <0 83 0x04>;
+		nvidia,dma-request-selector = <&apbdma 17>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi at 7000da00 {
+		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
+		reg = <0x7000da00 0x200>;
+		interrupts = <0 93 0x04>;
+		nvidia,dma-request-selector = <&apbdma 18>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi at 7000dc00 {
+		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
+		reg = <0x7000dc00 0x200>;
+		interrupts = <0 94 0x04>;
+		nvidia,dma-request-selector = <&apbdma 27>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi at 7000de00 {
+		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
+		reg = <0x7000de00 0x200>;
+		interrupts = <0 79 0x04>;
+		nvidia,dma-request-selector = <&apbdma 28>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	pmc {
 		compatible = "nvidia,tegra20-pmc", "nvidia,tegra30-pmc";
 		reg = <0x7000e400 0x400>;
-- 
1.7.1.1
