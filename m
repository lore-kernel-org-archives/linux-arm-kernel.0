From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:45 +0200
Subject: [PATCH 10/20] ARM: dts: sun4i: Rename thermal nodes to avoid warnings
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <f40eebec4a934ee2a2ef46c375c731daac664dba.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The thermal-zone subnodes we defined for the A10 have underscores in them
that will generate DTC warnings. Change those underscores for hyphens.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 6ce4aafdfd92..9e384234398a 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -129,7 +129,7 @@
 	};
 
 	thermal-zones {
-		cpu_thermal {
+		cpu-thermal {
 			/* milliseconds */
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
@@ -143,14 +143,14 @@
 			};
 
 			trips {
-				cpu_alert0: cpu_alert0 {
+				cpu_alert0: cpu-alert0 {
 					/* milliCelsius */
 					temperature = <850000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit: cpu_crit {
+				cpu_crit: cpu-crit {
 					/* milliCelsius */
 					temperature = <100000>;
 					hysteresis = <2000>;
-- 
git-series 0.9.1
