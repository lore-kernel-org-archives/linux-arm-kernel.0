From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri,  9 Feb 2018 14:28:09 +0530
Subject: [PATCH 09/10] dt-bindings: cpufreq-dt: Remove
 "cooling-{min|max}-level" properties
In-Reply-To: <cover.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
Message-ID: <aef1b506b365920d82b17c0712a3428196f72dc5.1518166039.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "cooling-min-level" and "cooling-max-level" properties are not
parsed by any part of kernel currently and the max cooling state of a
CPU cooling device is found by referring to the cpufreq table instead.

Remove the unused bindings.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
index dd3929e85dec..332aed8f4597 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
@@ -18,8 +18,6 @@ under node /cpus/cpu at 0.
   in unit of nanoseconds.
 - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
 - #cooling-cells:
-- cooling-min-level:
-- cooling-max-level:
      Please refer to Documentation/devicetree/bindings/thermal/thermal.txt.
 
 Examples:
@@ -40,8 +38,6 @@ cpus {
 		>;
 		clock-latency = <61036>; /* two CLK32 periods */
 		#cooling-cells = <2>;
-		cooling-min-level = <0>;
-		cooling-max-level = <2>;
 	};
 
 	cpu at 1 {
-- 
2.15.0.194.g9af6a3dea062
