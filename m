From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 27 Feb 2012 18:26:36 -0700
Subject: [PATCH] ARM: dt: Add ARM PMU to tegra*.dtsi
Message-ID: <1330392396-7919-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables HW performance measurements, and usage of the "perf" tool.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |    6 ++++++
 arch/arm/boot/dts/tegra30.dtsi |    8 ++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 550da98..52f83b7 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -23,6 +23,12 @@
 		      < 0x50040100 0x0100 >;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 56 0x04
+			      0 57 0x04>;
+	};
+
 	apbdma: dma at 6000a000 {
 		compatible = "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1200>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index ac4b75c..62a7b39 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -17,6 +17,14 @@
 		      < 0x50040100 0x0100 >;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 144 0x04
+			      0 145 0x04
+			      0 146 0x04
+			      0 147 0x04>;
+	};
+
 	apbdma: dma at 6000a000 {
 		compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1400>;
-- 
1.7.0.4
