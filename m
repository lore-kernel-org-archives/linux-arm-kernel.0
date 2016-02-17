From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 17 Feb 2016 15:55:26 +0900
Subject: [RFC 1/3] ARM: dts: Add cooling levels for CPUs on exynos5420
In-Reply-To: <1455692128-28504-1-git-send-email-k.kozlowski@samsung.com>
References: <1455692128-28504-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1455692128-28504-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos5420 we support 8 cpufreq steps (600-1300 MHz) for LITTLE and
12 steps for big core (700-1800 MHz). Add respective cooling cells.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5420-cpus.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
index 261d25173f61..498ae82e1cb2 100644
--- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
@@ -33,6 +33,9 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <11>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu1: cpu at 1 {
@@ -70,6 +73,9 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu5: cpu at 101 {
-- 
2.5.0
