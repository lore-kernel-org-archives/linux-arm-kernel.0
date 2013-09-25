From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 25 Sep 2013 11:48:23 +0300
Subject: [PATCHv7 17/36] ARM: dts: clk: Add apll related clocks
In-Reply-To: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
Message-ID: <1380098922-30340-18-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Keerthy <j-keerthy@ti.com>

The patch adds a mux node to choose the parent of apll_pcie_ck node.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 0d83f95..c830e15 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -315,11 +315,19 @@ dpll_pcie_ref_m2ldo_ck: dpll_pcie_ref_m2ldo_ck at 4a008210 {
 	ti,autoidle-low;
 };
 
+apll_pcie_in_clk_mux: apll_pcie_in_clk_mux at 4ae06118 {
+	compatible = "ti,mux-clock";
+	clocks = <&dpll_pcie_ref_ck>, <&pciesref_acs_clk_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00821c 0x4>;
+	ti,bit-shift = <7>;
+};
+
 apll_pcie_ck: apll_pcie_ck at 4a008200 {
 	#clock-cells = <0>;
-	compatible = "ti,omap4-dpll-clock";
-	clocks = <&dpll_pcie_ref_ck>, <&dpll_pcie_ref_ck>;
-	reg = <0x4a008200 0x4>, <0x4a008204 0x4>, <0x4a008208 0x4>, <0x4a00820c 0x4>;
+	compatible = "ti,dra7-apll-clock";
+	clocks = <&apll_pcie_in_clk_mux>, <&dpll_pcie_ref_ck>;
+	reg = <0x4a00821c 0x4>, <0x4a008220 0x4>;
 };
 
 apll_pcie_clkvcoldo: apll_pcie_clkvcoldo {
-- 
1.7.9.5
