From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 19 Dec 2013 13:24:04 +0200
Subject: [PATCHv11 33/49] ARM: dts: DRA7: Change apll_pcie_m2_ck to fixed
 factor clock
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Message-ID: <1387452260-23276-34-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: J Keerthy <j-keerthy@ti.com>

This patch changes apll_pcie_m2_ck to fixed factor
clock as there are no configurable divider associated to m2.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index d4e7410..d616359 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1183,13 +1183,10 @@
 
 	apll_pcie_m2_ck: apll_pcie_m2_ck {
 		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
+		compatible = "fixed-factor-clock";
 		clocks = <&apll_pcie_ck>;
-		ti,max-div = <127>;
-		ti,autoidle-shift = <8>;
-		reg = <0x0224>;
-		ti,index-starts-at-one;
-		ti,invert-autoidle-bit;
+		clock-mult = <1>;
+		clock-div = <1>;
 	};
 
 	dpll_per_ck: dpll_per_ck {
-- 
1.7.9.5
