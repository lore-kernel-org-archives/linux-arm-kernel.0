From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 Jan 2013 09:57:02 -0700
Subject: [PATCH] ARM: tegra: move serial clock-frequency attr into the Tegra30
 dtsi
Message-ID: <1358960222-22705-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

No Tegra30 Platform is running PLL_P at another rate than 408MHz, nor is
any using any other PLL as UART source clock. Move attribute into SoC
level dtsi file to slim down board DT files.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra30-beaver.dts  |    1 -
 arch/arm/boot/dts/tegra30-cardhu.dtsi |    2 --
 arch/arm/boot/dts/tegra30.dtsi        |    5 +++++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 0f296a4..8ff2ff2 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -90,7 +90,6 @@
 
 	serial at 70006000 {
 		status = "okay";
-		clock-frequency = <408000000>;
 	};
 
 	i2c at 7000c000 {
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index ff6b68f..1749927 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -120,13 +120,11 @@
 
 	serial at 70006000 {
 		status = "okay";
-		clock-frequency = <408000000>;
 	};
 
 	serial at 70006200 {
 		compatible = "nvidia,tegra30-hsuart";
 		status = "okay";
-		clock-frequency = <408000000>;
 	};
 
 	i2c at 7000c000 {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index ff4a0ca..313fa71 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -234,6 +234,7 @@
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 36 0x04>;
+		clock-frequency = <408000000>;
 		nvidia,dma-request-selector = <&apbdma 8>;
 		clocks = <&tegra_car 6>;
 		status = "disabled";
@@ -243,6 +244,7 @@
 		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
+		clock-frequency = <408000000>;
 		interrupts = <0 37 0x04>;
 		nvidia,dma-request-selector = <&apbdma 9>;
 		clocks = <&tegra_car 160>;
@@ -253,6 +255,7 @@
 		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
+		clock-frequency = <408000000>;
 		interrupts = <0 46 0x04>;
 		nvidia,dma-request-selector = <&apbdma 10>;
 		clocks = <&tegra_car 55>;
@@ -263,6 +266,7 @@
 		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
+		clock-frequency = <408000000>;
 		interrupts = <0 90 0x04>;
 		nvidia,dma-request-selector = <&apbdma 19>;
 		clocks = <&tegra_car 65>;
@@ -273,6 +277,7 @@
 		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
 		reg = <0x70006400 0x100>;
 		reg-shift = <2>;
+		clock-frequency = <408000000>;
 		interrupts = <0 91 0x04>;
 		nvidia,dma-request-selector = <&apbdma 20>;
 		clocks = <&tegra_car 66>;
-- 
1.7.10.4
