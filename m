From: finley.xiao@rock-chips.com (Finley Xiao)
Date: Fri,  4 Aug 2017 11:33:37 +0800
Subject: [PATCH 1/2] arm64: dts: rockchip: Add cpu operating points for RK3328
 SoC
In-Reply-To: <1501817618-65504-1-git-send-email-finley.xiao@rock-chips.com>
References: <1501817618-65504-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <1501817618-65504-2-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic OPP entries for RK3328 SoC.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 41 ++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 440e6bc..81fd8cb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -76,6 +76,7 @@
 			clocks = <&cru ARMCLK>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu1: cpu at 1 {
@@ -85,6 +86,7 @@
 			clocks = <&cru ARMCLK>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu2: cpu at 2 {
@@ -94,6 +96,7 @@
 			clocks = <&cru ARMCLK>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu3: cpu at 3 {
@@ -103,6 +106,7 @@
 			clocks = <&cru ARMCLK>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		l2: l2-cache0 {
@@ -110,6 +114,43 @@
 		};
 	};
 
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
+			opp-microvolt = <950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1225000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1296000000 {
+			opp-hz = /bits/ 64 <1296000000>;
+			opp-microvolt = <1300000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
 	amba {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.7.4
