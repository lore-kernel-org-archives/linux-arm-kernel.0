From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed, 17 May 2017 18:16:15 +0800
Subject: [PATCH v2 2/4] arm: dts: rk322x: add operating-points-v2 property for
 cpu
In-Reply-To: <1495016177-2413-1-git-send-email-frank.wang@rock-chips.com>
References: <1495016177-2413-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1495016177-2413-3-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

This patch adds a new opp table for cpu on rk322x SoC.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/rk322x.dtsi | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 64368b0..9a9da1f 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -66,10 +66,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0xf00>;
 			resets = <&cru SRST_CORE0>;
-			operating-points = <
-				/* KHz    uV */
-				 816000 1000000
-			>;
+			operating-points-v2 = <&cpu0_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
@@ -80,6 +77,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0xf01>;
 			resets = <&cru SRST_CORE1>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu2: cpu at f02 {
@@ -87,6 +85,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0xf02>;
 			resets = <&cru SRST_CORE2>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu3: cpu at f03 {
@@ -94,6 +93,35 @@
 			compatible = "arm,cortex-a7";
 			reg = <0xf03>;
 			resets = <&cru SRST_CORE3>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <950000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <975000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1175000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1275000>;
 		};
 	};
 
-- 
2.0.0
