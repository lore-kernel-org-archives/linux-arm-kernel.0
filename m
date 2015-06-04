From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu,  4 Jun 2015 21:50:33 +0530
Subject: [PATCH V7 3/3] OPP: Add binding for 'opp-suspend'
In-Reply-To: <cover.1433434659.git.viresh.kumar@linaro.org>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
Message-ID: <dedf8c02fdd9dbf169f43de74ead4c1434d89b45.1433434659.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On few platforms, for power efficiency, we want the device to be
configured for a specific OPP while we put the device in suspend state.

Add an optional property in operating-points-v2 bindings for that.

Acked-by: Nishanth Menon <nm@ti.com>
Suggested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 2938c52dbf84..6c245d87dd50 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -74,6 +74,8 @@ This describes the OPPs belonging to a device. This node can have following
   Missing property means devices have independent clock/voltage/current lines,
   but they share OPP tables.
 
+- opp-suspend: Phandle of the OPP to set while device is suspended.
+
 
 * OPP Node
 
@@ -145,9 +147,10 @@ Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 
 	cpu0_opp_table: opp_table0 {
 		compatible = "operating-points-v2";
+		opp-suspend = <&suspend_opp>;
 		opp-shared;
 
-		opp00 {
+		suspend-opp: opp00 {
 			opp-hz = <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
@@ -219,13 +222,14 @@ independently.
 
 	cpu_opp_table: opp_table {
 		compatible = "operating-points-v2";
+		opp-suspend = <&suspend_opp>;
 
 		/*
 		 * Missing opp-shared property means CPUs switch DVFS states
 		 * independently.
 		 */
 
-		opp00 {
+		suspend-opp: opp00 {
 			opp-hz = <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
@@ -298,9 +302,10 @@ DVFS state together.
 
 	cluster0_opp: opp_table0 {
 		compatible = "operating-points-v2";
+		opp-suspend = <&suspend_opp0>;
 		opp-shared;
 
-		opp00 {
+		suspend-opp: opp00 {
 			opp-hz = <1000000000>;
 			opp-microvolt = <970000 975000 985000>;
 			opp-microamp = <70000>;
@@ -323,9 +328,10 @@ DVFS state together.
 
 	cluster1_opp: opp_table1 {
 		compatible = "operating-points-v2";
+		opp-suspend = <&suspend_opp1>;
 		opp-shared;
 
-		opp10 {
+		suspend-opp: opp10 {
 			opp-hz = <1300000000>;
 			opp-microvolt = <1045000 1050000 1055000>;
 			opp-microamp = <95000>;
-- 
2.4.0
