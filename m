From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 08:14:03 +0200
Subject: [PATCH v3 2/3] ARM: tegra: Add device tree nodes for flow controller
In-Reply-To: <1409033644-24376-1-git-send-email-thierry.reding@gmail.com>
References: <1409033644-24376-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1409033644-24376-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

These nodes are required so that the flow controller driver can obtain
the I/O memory region from device tree rather than hard-coding it.

Acked-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 5 +++++
 arch/arm/boot/dts/tegra124.dtsi | 5 +++++
 arch/arm/boot/dts/tegra20.dtsi  | 5 +++++
 arch/arm/boot/dts/tegra30.dtsi  | 5 +++++
 4 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 08442d9abec7..430f85ac27f6 100644
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
index a2e3e25fe736..5d1b32225dc2 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -210,6 +210,11 @@
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
index e44cb596c589..c6a2d078bdf4 100644
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
index c0136bf2c5da..f4693c9c070e 100644
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
2.0.4
