From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:39 +0200
Subject: [PATCH 04/20] ARM: dts: sun4i: Change clock node names to avoid
 warnings
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <7fe9d6db8d10c8e062eb41bffb9be40c67ce0fa5.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our oscillators clock names have a unit address, but no reg property, which
generates a warning in DTC. Change these names to remove those unit
addresses.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 442d46e7cc8b..9671ac72fae9 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -169,14 +169,14 @@
 		#size-cells = <1>;
 		ranges;
 
-		osc24M: clk at 1c20050 {
+		osc24M: clk-24M {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
 			clock-output-names = "osc24M";
 		};
 
-		osc32k: clk at 0 {
+		osc32k: clk-32k {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
-- 
git-series 0.9.1
