From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:38 +0100
Subject: [PATCH 37/77] ARM: dts: sun7i: Change clock node names to avoid
 warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <2e9319196fa1e19c66db990e1bf71cc5b45cdcfc.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our oscillators clock names have a unit address, but no reg property, which
generates a warning in DTC. Change these names to remove those unit
addresses.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 2a88ff58fee4..9e84dcffc978 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -205,14 +205,14 @@
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
@@ -228,14 +228,14 @@
 		 * The actual TX clock rate is not controlled by the
 		 * gmac_tx clock.
 		 */
-		mii_phy_tx_clk: clk at 1 {
+		mii_phy_tx_clk: clk-mii-phy-tx {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <25000000>;
 			clock-output-names = "mii_phy_tx";
 		};
 
-		gmac_int_tx_clk: clk at 2 {
+		gmac_int_tx_clk: clk-gmac-int-tx {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <125000000>;
-- 
git-series 0.9.1
