From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  4 Apr 2014 16:09:39 +0200
Subject: [PATCH v2 11/11] ARM: mvebu: add SMP support in the Armada 38x device
 tree
In-Reply-To: <1396620579-15230-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396620579-15230-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1396620579-15230-12-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit improves the Armada 38x Device Tree to add the CPU reset
and PMSU Device Tree nodes as well as the declaration of the enabling
method for the CPUs. These are needed to get SMP working on Armada 38x
platforms.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-380.dtsi |  2 ++
 arch/arm/boot/dts/armada-385.dtsi |  2 ++
 arch/arm/boot/dts/armada-38x.dtsi | 10 ++++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
index 068031f..aa71718 100644
--- a/arch/arm/boot/dts/armada-380.dtsi
+++ b/arch/arm/boot/dts/armada-380.dtsi
@@ -21,6 +21,8 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "marvell,armada-380-smp";
+
 		cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
index e2919f0..2c7990d 100644
--- a/arch/arm/boot/dts/armada-385.dtsi
+++ b/arch/arm/boot/dts/armada-385.dtsi
@@ -21,6 +21,8 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "marvell,armada-380-smp";
+
 		cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index d28fbc2..4742915 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -272,11 +272,21 @@
 				clock-names = "nbclk", "fixed";
 			};
 
+			cpurst at 20800 {
+				compatible = "marvell,armada-370-cpu-reset";
+				reg = <0x20800 0x10>;
+			};
+
 			coherency-fabric at 21010 {
 				compatible = "marvell,armada-380-coherency-fabric";
 				reg = <0x21010 0x1c>;
 			};
 
+			pmsu at 22000 {
+				compatible = "marvell,armada-380-pmsu";
+				reg = <0x22000 0x1000>;
+			};
+
 			eth1: ethernet at 30000 {
 				compatible = "marvell,armada-370-neta";
 				reg = <0x30000 0x4000>;
-- 
1.8.3.2
