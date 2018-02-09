From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri,  9 Feb 2018 14:28:10 +0530
Subject: [PATCH 10/10] dt-bindings: thermal: Remove "cooling-{min|max}-level"
 properties
In-Reply-To: <cover.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
Message-ID: <0ec53640f1a09e6e0d7aa1a21d1a3266c3c209c7.1518166039.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "cooling-min-level" and "cooling-max-level" properties are not
parsed by any part of kernel currently and the max cooling state of a
CPU cooling device is found by referring to the cpufreq table instead.

Remove the unused bindings.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index 1719d47a5e2f..cc553f0952c5 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -55,8 +55,7 @@ of heat dissipation). For example a fan's cooling states correspond to
 the different fan speeds possible. Cooling states are referred to by
 single unsigned integers, where larger numbers mean greater heat
 dissipation. The precise set of cooling states associated with a device
-(as referred to by the cooling-min-level and cooling-max-level
-properties) should be defined in a particular device's binding.
+should be defined in a particular device's binding.
 For more examples of cooling devices, refer to the example sections below.
 
 Required properties:
@@ -69,15 +68,6 @@ For more examples of cooling devices, refer to the example sections below.
 			See Cooling device maps section below for more details
 			on how consumers refer to cooling devices.
 
-Optional properties:
-- cooling-min-level:	An integer indicating the smallest
-  Type: unsigned	cooling state accepted. Typically 0.
-  Size: one cell
-
-- cooling-max-level:	An integer indicating the largest
-  Type: unsigned	cooling state accepted.
-  Size: one cell
-
 * Trip points
 
 The trip node is a node to describe a point in the temperature domain
@@ -226,8 +216,6 @@ cpus {
 			396000  950000
 			198000  850000
 		>;
-		cooling-min-level = <0>;
-		cooling-max-level = <3>;
 		#cooling-cells = <2>; /* min followed by max */
 	};
 	...
@@ -241,8 +229,6 @@ cpus {
 	 */
 	fan0: fan at 48 {
 		...
-		cooling-min-level = <0>;
-		cooling-max-level = <9>;
 		#cooling-cells = <2>; /* min followed by max */
 	};
 };
-- 
2.15.0.194.g9af6a3dea062
