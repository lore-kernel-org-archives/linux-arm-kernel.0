From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Feb 2013 10:43:45 -0700
Subject: [PATCH] ARM: tegra: remove clock-frequency properties from serial
 nodes
Message-ID: <1360691025-8393-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Currently, the serial nodes define both a clock-frequency and a clocks
property. We should not provide both, since they might conflict.

In practice, this also causes problems since the of_serial driver uses
the clock-frequency property in preference to the clocks property, and
hence doesn't clk_prepare_enable() the clock, which may then leave it
with no known users, and hence the common clock framework will disable
it, thus breaking the port, which is usually the console.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |    5 -----
 arch/arm/boot/dts/tegra30.dtsi |    5 -----
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index cdb8da0..9a42893 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -247,7 +247,6 @@
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 36 0x04>;
-		clock-frequency = <216000000>;
 		nvidia,dma-request-selector = <&apbdma 8>;
 		clocks = <&tegra_car 6>;
 		status = "disabled";
@@ -258,7 +257,6 @@
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 37 0x04>;
-		clock-frequency = <216000000>;
 		nvidia,dma-request-selector = <&apbdma 9>;
 		clocks = <&tegra_car 96>;
 		status = "disabled";
@@ -269,7 +267,6 @@
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 46 0x04>;
-		clock-frequency = <216000000>;
 		nvidia,dma-request-selector = <&apbdma 10>;
 		clocks = <&tegra_car 55>;
 		status = "disabled";
@@ -280,7 +277,6 @@
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 90 0x04>;
-		clock-frequency = <216000000>;
 		nvidia,dma-request-selector = <&apbdma 19>;
 		clocks = <&tegra_car 65>;
 		status = "disabled";
@@ -291,7 +287,6 @@
 		reg = <0x70006400 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 91 0x04>;
-		clock-frequency = <216000000>;
 		nvidia,dma-request-selector = <&apbdma 20>;
 		clocks = <&tegra_car 66>;
 		status = "disabled";
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 572a45b..767803e 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -234,7 +234,6 @@
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 36 0x04>;
-		clock-frequency = <408000000>;
 		nvidia,dma-request-selector = <&apbdma 8>;
 		clocks = <&tegra_car 6>;
 		status = "disabled";
@@ -244,7 +243,6 @@
 		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
-		clock-frequency = <408000000>;
 		interrupts = <0 37 0x04>;
 		nvidia,dma-request-selector = <&apbdma 9>;
 		clocks = <&tegra_car 160>;
@@ -255,7 +253,6 @@
 		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
-		clock-frequency = <408000000>;
 		interrupts = <0 46 0x04>;
 		nvidia,dma-request-selector = <&apbdma 10>;
 		clocks = <&tegra_car 55>;
@@ -266,7 +263,6 @@
 		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
-		clock-frequency = <408000000>;
 		interrupts = <0 90 0x04>;
 		nvidia,dma-request-selector = <&apbdma 19>;
 		clocks = <&tegra_car 65>;
@@ -277,7 +273,6 @@
 		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
 		reg = <0x70006400 0x100>;
 		reg-shift = <2>;
-		clock-frequency = <408000000>;
 		interrupts = <0 91 0x04>;
 		nvidia,dma-request-selector = <&apbdma 20>;
 		clocks = <&tegra_car 66>;
-- 
1.7.10.4
