From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 20 Apr 2017 11:14:16 +0530
Subject: [PATCH V4 5/7] ARM: sun8i: Use - instead of @ for DT OPP entries
In-Reply-To: <cover.1492666725.git.viresh.kumar@linaro.org>
References: <cover.1492666725.git.viresh.kumar@linaro.org>
Message-ID: <d13e447e9cc080d81c4f2db3bd5433506d3ef739.1492666725.git.viresh.kumar@linaro.org>
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
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 306af6cadf26..a2c555d6475c 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -49,19 +49,19 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp at 648000000 {
+		opp-648000000 {
 			opp-hz = /bits/ 64 <648000000>;
 			opp-microvolt = <1040000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp at 816000000 {
+		opp-816000000 {
 			opp-hz = /bits/ 64 <816000000>;
 			opp-microvolt = <1100000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp at 1008000000 {
+		opp-1008000000 {
 			opp-hz = /bits/ 64 <1008000000>;
 			opp-microvolt = <1200000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
-- 
2.12.0.432.g71c3a4f4ba37
