From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:06 +0100
Subject: [PATCH 05/77] ARM: dts: sun5i: Change clock node names to avoid
 warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <f46c0b69240d050a52ef2ca4c6c4a73f3f587974.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our oscillators clock names have a unit address, but no reg property, which
generates a warning in DTC. Change these names to remove those unit
addresses.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 3e7b251ce7a6..97236b112b01 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -93,14 +93,14 @@
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
