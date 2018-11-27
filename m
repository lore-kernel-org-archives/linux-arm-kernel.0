From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:55 +0100
Subject: [PATCH 54/77] ARM: dts: sun8i: a23/a33: Fix OPP DTC warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <631bd03061018debc815db896445087b8fc2571c.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DTC will emit a warning on our OPPs nodes for the common DTSI between the
A23 and A33 since those nodes use the frequency as unit addresses, but
don't have a matching reg property.

Fix this by moving the frequency to the node name instead.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi              | 6 +++---
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 22883f1b80e2..9db1f58a47de 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -47,19 +47,19 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp at 648000000 {
+		opp-648000000 {
 			opp-hz = /bits/ 64 <648000000>;
 			opp-microvolt = <1040000 1040000 1300000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp at 816000000 {
+		opp-816000000 {
 			opp-hz = /bits/ 64 <816000000>;
 			opp-microvolt = <1100000 1100000 1300000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp at 1008000000 {
+		opp-1008000000 {
 			opp-hz = /bits/ 64 <1008000000>;
 			opp-microvolt = <1200000 1200000 1300000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index 0dbdb29a8fff..ee7ce3752581 100644
--- a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
@@ -103,13 +103,13 @@
 };
 
 &cpu0_opp_table {
-	opp at 1104000000 {
+	opp-1104000000 {
 		opp-hz = /bits/ 64 <1104000000>;
 		opp-microvolt = <1320000>;
 		clock-latency-ns = <244144>; /* 8 32k periods */
 	};
 
-	opp at 1200000000 {
+	opp-1200000000 {
 		opp-hz = /bits/ 64 <1200000000>;
 		opp-microvolt = <1320000>;
 		clock-latency-ns = <244144>; /* 8 32k periods */
-- 
git-series 0.9.1
