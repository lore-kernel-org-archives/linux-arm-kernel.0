From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 18 Feb 2016 14:13:02 +0900
Subject: [PATCH v2 2/3] ARM: dts: Add cooling levels for CPUs on
 exynos5422/5800
In-Reply-To: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
References: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1455772383-20598-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos5422 and Exynos5800 we support 12 cpufreq steps (200-1300 MHz) for LITTLE
and 18 steps for big core (200-1700 MHz). Add respective cooling cells.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes since v1:
1. Add cooling properties to all CPUs (suggested by Viresh).
---
 arch/arm/boot/dts/exynos5422-cpus.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index 9b46b9fbac4e..bf3c6f1ec4ee 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -32,6 +32,9 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <11>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu1: cpu at 101 {
@@ -41,6 +44,9 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <11>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu2: cpu at 102 {
@@ -50,6 +56,9 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <11>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu3: cpu at 103 {
@@ -59,6 +68,9 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <11>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu4: cpu at 0 {
@@ -69,6 +81,9 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu5: cpu at 1 {
@@ -78,6 +93,9 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu6: cpu at 2 {
@@ -87,6 +105,9 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu7: cpu at 3 {
@@ -96,6 +117,9 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 };
-- 
2.5.0
