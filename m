From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 20 Apr 2017 16:25:08 +0530
Subject: [PATCH V5 4/7] ARM: pxa: Use - instead of @ for DT OPP entries
In-Reply-To: <cover.1492685450.git.viresh.kumar@linaro.org>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
Message-ID: <741bc9af28d6968e6a9409f94681066db5d1228b.1492685450.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compiling the DT file with W=1, DTC warns like follows:

Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
unit name, but no reg property

Fix this by replacing '@' with '-' as the OPP nodes will never have a
"reg" property.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/pxa25x.dtsi |  8 ++++----
 arch/arm/boot/dts/pxa27x.dtsi | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
index f9f4726396a0..95d59be97213 100644
--- a/arch/arm/boot/dts/pxa25x.dtsi
+++ b/arch/arm/boot/dts/pxa25x.dtsi
@@ -93,22 +93,22 @@
 	pxa250_opp_table: opp_table0 {
 		compatible = "operating-points-v2";
 
-		opp at 99532800 {
+		opp-99532800 {
 			opp-hz = /bits/ 64 <99532800>;
 			opp-microvolt = <1000000 950000 1650000>;
 			clock-latency-ns = <20>;
 		};
-		opp at 199065600 {
+		opp-199065600 {
 			opp-hz = /bits/ 64 <199065600>;
 			opp-microvolt = <1000000 950000 1650000>;
 			clock-latency-ns = <20>;
 		};
-		opp at 298598400 {
+		opp-298598400 {
 			opp-hz = /bits/ 64 <298598400>;
 			opp-microvolt = <1100000 1045000 1650000>;
 			clock-latency-ns = <20>;
 		};
-		opp at 398131200 {
+		opp-398131200 {
 			opp-hz = /bits/ 64 <398131200>;
 			opp-microvolt = <1300000 1235000 1650000>;
 			clock-latency-ns = <20>;
diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index e0fab48ba6fa..5f1d6da02a4c 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -141,37 +141,37 @@
 	pxa270_opp_table: opp_table0 {
 		compatible = "operating-points-v2";
 
-		opp at 104000000 {
+		opp-104000000 {
 			opp-hz = /bits/ 64 <104000000>;
 			opp-microvolt = <900000 900000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp at 156000000 {
+		opp-156000000 {
 			opp-hz = /bits/ 64 <156000000>;
 			opp-microvolt = <1000000 1000000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp at 208000000 {
+		opp-208000000 {
 			opp-hz = /bits/ 64 <208000000>;
 			opp-microvolt = <1180000 1180000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp at 312000000 {
+		opp-312000000 {
 			opp-hz = /bits/ 64 <312000000>;
 			opp-microvolt = <1250000 1250000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp at 416000000 {
+		opp-416000000 {
 			opp-hz = /bits/ 64 <416000000>;
 			opp-microvolt = <1350000 1350000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp at 520000000 {
+		opp-520000000 {
 			opp-hz = /bits/ 64 <520000000>;
 			opp-microvolt = <1450000 1450000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp at 624000000 {
+		opp-624000000 {
 			opp-hz = /bits/ 64 <624000000>;
 			opp-microvolt = <1550000 1550000 1705000>;
 			clock-latency-ns = <20>;
-- 
2.12.0.432.g71c3a4f4ba37
