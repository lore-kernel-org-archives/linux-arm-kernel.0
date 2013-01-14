From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 14 Jan 2013 10:21:39 -0700
Subject: [PATCH] ARM: tegra: swap cache-/interrupt-ctrlr nodes in DT
Message-ID: <1358184099-7249-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This ensures nodes are sorted in order of reg address. This makes it
easier to compare against e.g. the U-Boot device trees, and is simply
consistent and clean.

While we're at it, remove the unit address from the cache-controller
node name, since it's unique without it.

Reported-by: Allen Martin <amartin@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I intend to apply this immediately since it's trivial.

 arch/arm/boot/dts/tegra20.dtsi |   18 +++++++++---------
 arch/arm/boot/dts/tegra30.dtsi |   18 +++++++++---------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 1ddbefd..dcd220c 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -105,15 +105,6 @@
 		interrupts = <1 13 0x304>;
 	};
 
-	cache-controller at 50043000 {
-		compatible = "arm,pl310-cache";
-		reg = <0x50043000 0x1000>;
-		arm,data-latency = <5 5 2>;
-		arm,tag-latency = <4 4 2>;
-		cache-unified;
-		cache-level = <2>;
-	};
-
 	intc: interrupt-controller {
 		compatible = "arm,cortex-a9-gic";
 		reg = <0x50041000 0x1000
@@ -122,6 +113,15 @@
 		#interrupt-cells = <3>;
 	};
 
+	cache-controller {
+		compatible = "arm,pl310-cache";
+		reg = <0x50043000 0x1000>;
+		arm,data-latency = <5 5 2>;
+		arm,tag-latency = <4 4 2>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	timer at 60005000 {
 		compatible = "nvidia,tegra20-timer";
 		reg = <0x60005000 0x60>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index dc6dc51..63a0d9b 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -105,15 +105,6 @@
 		interrupts = <1 13 0xf04>;
 	};
 
-	cache-controller at 50043000 {
-		compatible = "arm,pl310-cache";
-		reg = <0x50043000 0x1000>;
-		arm,data-latency = <6 6 2>;
-		arm,tag-latency = <5 5 2>;
-		cache-unified;
-		cache-level = <2>;
-	};
-
 	intc: interrupt-controller {
 		compatible = "arm,cortex-a9-gic";
 		reg = <0x50041000 0x1000
@@ -122,6 +113,15 @@
 		#interrupt-cells = <3>;
 	};
 
+	cache-controller {
+		compatible = "arm,pl310-cache";
+		reg = <0x50043000 0x1000>;
+		arm,data-latency = <6 6 2>;
+		arm,tag-latency = <5 5 2>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	timer at 60005000 {
 		compatible = "nvidia,tegra30-timer", "nvidia,tegra20-timer";
 		reg = <0x60005000 0x400>;
-- 
1.7.10.4
