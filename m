From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 May 2012 18:38:00 -0600
Subject: [PATCH 8/9] ARM: dt: tegra: consistent basic property ordering
In-Reply-To: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
References: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1336783081-16978-9-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Put properties in order compatible, reg, interrupts, then anything else
the node has.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-paz00.dts |    4 ++--
 arch/arm/boot/dts/tegra20.dtsi    |   24 ++++++++++++------------
 arch/arm/boot/dts/tegra30.dtsi    |   24 ++++++++++++------------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
index b500212..6539e89 100644
--- a/arch/arm/boot/dts/tegra-paz00.dts
+++ b/arch/arm/boot/dts/tegra-paz00.dts
@@ -270,11 +270,11 @@
 	};
 
 	nvec {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nvidia,nvec";
 		reg = <0x7000c500 0x100>;
 		interrupts = <0 92 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		clock-frequency = <80000>;
 		request-gpios = <&gpio 170 0>; /* gpio PV2 */
 		slave-addr = <138>;
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 0e371f9..df34def 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -6,10 +6,10 @@
 
 	intc: interrupt-controller {
 		compatible = "arm,cortex-a9-gic";
-		interrupt-controller;
-		#interrupt-cells = <3>;
 		reg = <0x50041000 0x1000
 		       0x50040100 0x0100>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
 	};
 
 	apbdma: dma {
@@ -117,35 +117,35 @@
 	};
 
 	i2c at 7000c000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000c000 0x100>;
 		interrupts = <0 38 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	i2c at 7000c400 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000c400 0x100>;
 		interrupts = <0 84 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	i2c at 7000c500 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000c500 0x100>;
 		interrupts = <0 92 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	i2c at 7000d000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c-dvc";
 		reg = <0x7000d000 0x200>;
 		interrupts = <0 53 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	pmc {
@@ -167,10 +167,10 @@
 	};
 
 	emc {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	usb at c5000000 {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 9fb47ad..5a1c85f 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -6,10 +6,10 @@
 
 	intc: interrupt-controller {
 		compatible = "arm,cortex-a9-gic";
-		interrupt-controller;
-		#interrupt-cells = <3>;
 		reg = <0x50041000 0x1000
 		       0x50040100 0x0100>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
 	};
 
 	apbdma: dma {
@@ -113,43 +113,43 @@
 	};
 
 	i2c at 7000c000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible =  "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c000 0x100>;
 		interrupts = <0 38 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	i2c at 7000c400 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c400 0x100>;
 		interrupts = <0 84 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	i2c at 7000c500 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c500 0x100>;
 		interrupts = <0 92 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	i2c at 7000c700 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c700 0x100>;
 		interrupts = <0 120 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	i2c at 7000d000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000d000 0x100>;
 		interrupts = <0 53 0x04>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	pmc {
-- 
1.7.0.4
