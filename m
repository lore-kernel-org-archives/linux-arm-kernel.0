From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 25 May 2018 16:01:58 +0530
Subject: [PATCH 12/15] arm: dts: highbank: Add missing OPP properties for CPUs
In-Reply-To: <cover.1527244200.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
Message-ID: <f8a4e5c3062397736475ec599de730206846cb9b.1527244201.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OPP properties, like "operating-points", should either be present
for all the CPUs of a cluster or none. If these are present only for a
subset of CPUs of a cluster then things will start falling apart as soon
as the CPUs are brought online in a different order. For example, this
will happen because the operating system looks for such properties in
the CPU node it is trying to bring up, so that it can create an OPP
table.

Add such missing properties.

Fix other missing property (clock latency) as well to make it all
work.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/highbank.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
index ed14aeac0566..50278715de76 100644
--- a/arch/arm/boot/dts/highbank.dts
+++ b/arch/arm/boot/dts/highbank.dts
@@ -56,6 +56,16 @@
 			next-level-cache = <&L2>;
 			clocks = <&a9pll>;
 			clock-names = "cpu";
+			operating-points = <
+				/* kHz    ignored */
+				 1300000  1000000
+				 1200000  1000000
+				 1100000  1000000
+				  800000  1000000
+				  400000  1000000
+				  200000  1000000
+			>;
+			clock-latency = <100000>;
 		};
 
 		cpu at 902 {
@@ -65,6 +75,16 @@
 			next-level-cache = <&L2>;
 			clocks = <&a9pll>;
 			clock-names = "cpu";
+			operating-points = <
+				/* kHz    ignored */
+				 1300000  1000000
+				 1200000  1000000
+				 1100000  1000000
+				  800000  1000000
+				  400000  1000000
+				  200000  1000000
+			>;
+			clock-latency = <100000>;
 		};
 
 		cpu at 903 {
@@ -74,6 +94,16 @@
 			next-level-cache = <&L2>;
 			clocks = <&a9pll>;
 			clock-names = "cpu";
+			operating-points = <
+				/* kHz    ignored */
+				 1300000  1000000
+				 1200000  1000000
+				 1100000  1000000
+				  800000  1000000
+				  400000  1000000
+				  200000  1000000
+			>;
+			clock-latency = <100000>;
 		};
 	};
 
-- 
2.15.0.194.g9af6a3dea062
