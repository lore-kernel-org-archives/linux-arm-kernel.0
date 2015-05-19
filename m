From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Tue, 19 May 2015 20:51:18 +0900
Subject: [RESEND PATCH 1/2] ARM: dts: tegra: Add labels to Tegra114 nodes
Message-ID: <1432036279-6318-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new labels to certain nodes on Tegra114 so they could be easily
referenced by board DTS files.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

---

Tested by comparison of generated DTB and decompiled DTB->DTS for each
commit. Each output was the same.
---
 arch/arm/boot/dts/tegra114.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index f58a3d9d5f13..1b31cefd1047 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -10,7 +10,7 @@
 	compatible = "nvidia,tegra114";
 	interrupt-parent = <&lic>;
 
-	host1x at 50000000 {
+	host1x: host1x at 50000000 {
 		compatible = "nvidia,tegra114-host1x", "simple-bus";
 		reg = <0x50000000 0x00028000>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>, /* syncpt */
@@ -318,7 +318,7 @@
 		status = "disabled";
 	};
 
-	i2c at 7000c000 {
+	i2c1: i2c at 7000c000 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000c000 0x100>;
 		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
@@ -363,7 +363,7 @@
 		status = "disabled";
 	};
 
-	i2c at 7000c700 {
+	i2c4: i2c at 7000c700 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000c700 0x100>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
@@ -378,7 +378,7 @@
 		status = "disabled";
 	};
 
-	i2c at 7000d000 {
+	i2c5: i2c at 7000d000 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000d000 0x100>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
@@ -438,7 +438,7 @@
 		status = "disabled";
 	};
 
-	spi at 7000da00 {
+	spi4: spi at 7000da00 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000da00 0x200>;
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
@@ -500,7 +500,7 @@
 		status = "disabled";
 	};
 
-	pmc at 7000e400 {
+	pmc: pmc at 7000e400 {
 		compatible = "nvidia,tegra114-pmc";
 		reg = <0x7000e400 0x400>;
 		clocks = <&tegra_car TEGRA114_CLK_PCLK>, <&clk32k_in>;
@@ -527,7 +527,7 @@
 		#iommu-cells = <1>;
 	};
 
-	ahub at 70080000 {
+	ahub: ahub at 70080000 {
 		compatible = "nvidia,tegra114-ahub";
 		reg = <0x70080000 0x200>,
 		      <0x70080200 0x100>,
@@ -648,7 +648,7 @@
 		status = "disabled";
 	};
 
-	sdhci at 78000400 {
+	sdhci3: sdhci at 78000400 {
 		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -658,7 +658,7 @@
 		status = "disabled";
 	};
 
-	sdhci at 78000600 {
+	sdhci4: sdhci at 78000600 {
 		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
@@ -668,7 +668,7 @@
 		status = "disabled";
 	};
 
-	usb at 7d000000 {
+	usb1: usb at 7d000000 {
 		compatible = "nvidia,tegra30-ehci", "usb-ehci";
 		reg = <0x7d000000 0x4000>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
@@ -704,7 +704,7 @@
 		status = "disabled";
 	};
 
-	usb at 7d008000 {
+	usb3: usb at 7d008000 {
 		compatible = "nvidia,tegra30-ehci", "usb-ehci";
 		reg = <0x7d008000 0x4000>;
 		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4
