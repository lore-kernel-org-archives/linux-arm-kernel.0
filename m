From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 11 Jun 2014 13:58:10 +0200
Subject: [PATCH 1/2] ARM: tegra: Add device tree nodes for flow controller
Message-ID: <1402487891-6493-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

These nodes are required so that the flow controller driver can obtain
the I/O memory region from device tree rather than hard-coding it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 5 +++++
 arch/arm/boot/dts/tegra124.dtsi | 5 +++++
 arch/arm/boot/dts/tegra20.dtsi  | 5 +++++
 arch/arm/boot/dts/tegra30.dtsi  | 5 +++++
 4 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 90982679c161..1953113598b2 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -161,6 +161,11 @@
 		#reset-cells = <1>;
 	};
 
+	flow-controller at 60007000 {
+		compatible = "nvidia,tegra114-flowctrl";
+		reg = <0x60007000 0x1000>;
+	};
+
 	apbdma: dma at 6000a000 {
 		compatible = "nvidia,tegra114-apbdma";
 		reg = <0x6000a000 0x1400>;
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 057340b980dd..0f3c869a1673 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -205,6 +205,11 @@
 		#reset-cells = <1>;
 	};
 
+	flow-controller at 0,60007000 {
+		compatible = "nvidia,tegra124-flowctrl";
+		reg = <0x0 0x60007000 0x0 0x1000>;
+	};
+
 	gpio: gpio at 0,6000d000 {
 		compatible = "nvidia,tegra124-gpio", "nvidia,tegra30-gpio";
 		reg = <0x0 0x6000d000 0x0 0x1000>;
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 81815416e6d3..e47ae7472e7a 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -201,6 +201,11 @@
 		#reset-cells = <1>;
 	};
 
+	flow-controller at 60007000 {
+		compatible = "nvidia,tegra20-flowctrl";
+		reg = <0x60007000 0x1000>;
+	};
+
 	apbdma: dma at 6000a000 {
 		compatible = "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1200>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index e88e477bfb2c..d07baa3f840f 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -282,6 +282,11 @@
 		#reset-cells = <1>;
 	};
 
+	flow-controller at 60007000 {
+		compatible = "nvidia,tegra30-flowctrl";
+		reg = <0x60007000 0x1000>;
+	};
+
 	apbdma: dma at 6000a000 {
 		compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1400>;
-- 
1.9.2
