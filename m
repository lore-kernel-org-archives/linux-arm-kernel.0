From: aniruddhab@nvidia.com (Aniruddha Banerjee)
Date: Mon, 3 Apr 2017 11:19:54 +0000
Subject: [PATCH 1/1] arm64: tegra: fix PPI interrupt flag
Message-ID: <7fad40fbcaa94c1ea46328e78b46443b@bgmail102.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupt flag for PPI should not be set to any value, since the
register is read-only. Fix the flags for the PPI interrupts to
IRQ_TYPE_NONE, so that there is no write to the read-only register.

Signed-off-by: Aniruddha Banerjee <aniruddhab@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 8 ++++----
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 8 ++++----
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 3f3a46a4bd01..219fb3c6a273 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -1093,13 +1093,13 @@
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_NONE)>,
 			     <GIC_PPI 14
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_NONE)>,
 			     <GIC_PPI 11
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_NONE)>,
 			     <GIC_PPI 10
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_NONE)>;
 		interrupt-parent = <&gic>;
 	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 62fa85ae0271..e602299f7694 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -390,13 +390,13 @@
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_NONE)>,
 			     <GIC_PPI 14
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_NONE)>,
 			     <GIC_PPI 11
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_NONE)>,
 			     <GIC_PPI 10
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_NONE)>;
 		interrupt-parent = <&gic>;
 	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 2f832df29da8..6f3060b40a40 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1214,13 +1214,13 @@
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_NONE)>,
 			     <GIC_PPI 14
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_NONE)>,
 			     <GIC_PPI 11
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_NONE)>,
 			     <GIC_PPI 10
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_NONE)>;
 		interrupt-parent = <&gic>;
 	};
 
-- 
2.11.0
