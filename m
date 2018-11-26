From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Sun, 25 Nov 2018 18:15:27 -0600
Subject: [PATCH linux-next 06/10] ARM: dts: dm814x: switch to use phy-gmii-sel
In-Reply-To: <20181126001531.12974-1-grygorii.strashko@ti.com>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
Message-ID: <20181126001531.12974-7-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to use phy-gmii-sel PHY instead of cpsw-phy-sel.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/dm814x.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 601c57a..413ae19 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -343,6 +343,12 @@
 					#size-cells = <1>;
 					ranges = <0 0 0x800>;
 
+					phy_gmii_sel: phy-gmii-sel {
+						compatible = "ti,dm814-phy-gmii-sel";
+						reg = <0x650 0x4>;
+						#phy-cells = <1>;
+					};
+
 					scm_clocks: clocks {
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -549,17 +555,14 @@
 			cpsw_emac0: slave at 4a100200 {
 				/* Filled in by U-Boot */
 				mac-address = [ 00 00 00 00 00 00 ];
+				phys = <&phy_gmii_sel 1>;
+
 			};
 
 			cpsw_emac1: slave at 4a100300 {
 				/* Filled in by U-Boot */
 				mac-address = [ 00 00 00 00 00 00 ];
-			};
-
-			phy_sel: cpsw-phy-sel at 48140650 {
-				compatible = "ti,am3352-cpsw-phy-sel";
-				reg= <0x48140650 0x4>;
-				reg-names = "gmii-sel";
+				phys = <&phy_gmii_sel 2>;
 			};
 		};
 
-- 
2.10.5
