From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  9 Jul 2014 17:45:12 +0200
Subject: [PATCHv3 4/7] ARM: mvebu: update Armada XP DT for dynamic frequency
 scaling
In-Reply-To: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1404920715-19834-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support dynamic frequency scaling:

 * the cpuclk Device Tree node needs to be updated to describe a
   second set of registers describing the PMU DFS registers.

 * the clock-latency property of the CPUs must be filled, otherwise
   the ondemand and conservative cpufreq governors refuse to work. The
   latency is high because the cost of a frequency transition is quite
   high on those CPUs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 2 ++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 2 ++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 4 ++++
 arch/arm/boot/dts/armada-xp.dtsi         | 2 +-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 1257ff1..2592e1c 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -34,6 +34,7 @@
 			compatible = "marvell,sheeva-v7";
 			reg = <0>;
 			clocks = <&cpuclk 0>;
+			clock-latency = <1000000>;
 		};
 
 		cpu at 1 {
@@ -41,6 +42,7 @@
 			compatible = "marvell,sheeva-v7";
 			reg = <1>;
 			clocks = <&cpuclk 1>;
+			clock-latency = <1000000>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 3396b25..480e237 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -36,6 +36,7 @@
 			compatible = "marvell,sheeva-v7";
 			reg = <0>;
 			clocks = <&cpuclk 0>;
+			clock-latency = <1000000>;
 		};
 
 		cpu at 1 {
@@ -43,6 +44,7 @@
 			compatible = "marvell,sheeva-v7";
 			reg = <1>;
 			clocks = <&cpuclk 1>;
+			clock-latency = <1000000>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 6da84bf..2c7b1fe 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -37,6 +37,7 @@
 			compatible = "marvell,sheeva-v7";
 			reg = <0>;
 			clocks = <&cpuclk 0>;
+			clock-latency = <1000000>;
 		};
 
 		cpu at 1 {
@@ -44,6 +45,7 @@
 			compatible = "marvell,sheeva-v7";
 			reg = <1>;
 			clocks = <&cpuclk 1>;
+			clock-latency = <1000000>;
 		};
 
 		cpu at 2 {
@@ -51,6 +53,7 @@
 			compatible = "marvell,sheeva-v7";
 			reg = <2>;
 			clocks = <&cpuclk 2>;
+			clock-latency = <1000000>;
 		};
 
 		cpu at 3 {
@@ -58,6 +61,7 @@
 			compatible = "marvell,sheeva-v7";
 			reg = <3>;
 			clocks = <&cpuclk 3>;
+			clock-latency = <1000000>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 5902e83..bff9f6c 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -99,7 +99,7 @@
 			cpuclk: clock-complex at 18700 {
 				#clock-cells = <1>;
 				compatible = "marvell,armada-xp-cpu-clock";
-				reg = <0x18700 0xA0>;
+				reg = <0x18700 0xA0>, <0x1c054 0x10>;
 				clocks = <&coreclk 1>;
 			};
 
-- 
2.0.0
