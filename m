From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 26 Oct 2012 18:34:08 +0800
Subject: [PATCH 1/2] ARM: tegra: dt: add L2 cache controller
Message-ID: <1351247649-15859-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add L2 cache controller binding into DT for Tegra.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |    9 +++++++++
 arch/arm/boot/dts/tegra30.dtsi |    9 +++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 6934bca..be18361 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -4,6 +4,15 @@
 	compatible = "nvidia,tegra20";
 	interrupt-parent = <&intc>;
 
+	L2: cache-controller at 50043000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x50043000 0x1000>;
+		arm,data-latency = <5 5 2>;
+		arm,tag-latency = <4 4 2>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	timer at 50004600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x50040600 0x20>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 81f5df4..71da933 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -4,6 +4,15 @@
 	compatible = "nvidia,tegra30";
 	interrupt-parent = <&intc>;
 
+	L2: cache-controller at 50043000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x50043000 0x1000>;
+		arm,data-latency = <6 6 2>;
+		arm,tag-latency = <5 5 2>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	timer at 50004600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x50040600 0x20>;
-- 
1.7.0.4
