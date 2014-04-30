From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 30 Apr 2014 14:41:36 +0300
Subject: [PATCH 2/2] ARM: DTS: omap54xx-clocks: Correct abe_iclk clock node
In-Reply-To: <1398858096-32144-1-git-send-email-peter.ujfalusi@ti.com>
References: <1398858096-32144-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1398858096-32144-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

abe_iclk's parent is aess_fclk and not abe_clk.
Also correct the parameters for clock rate calculation as used for OMAP4
since in PRCM level there's no difference between the two platform
regarding to AESS/ABE clocking.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap54xx-clocks.dtsi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index d784ff5d3904..86fc507a0567 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -143,10 +143,11 @@
 
 	abe_iclk: abe_iclk {
 		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&abe_clk>;
-		clock-mult = <1>;
-		clock-div = <2>;
+		compatible = "ti,divider-clock";
+		clocks = <&aess_fclk>;
+		ti,bit-shift = <24>;
+		reg = <0x0528>;
+		ti,dividers = <2>, <1>;
 	};
 
 	abe_lp_clk_div: abe_lp_clk_div {
-- 
1.9.2
