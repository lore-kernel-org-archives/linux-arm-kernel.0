From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Tue,  9 Apr 2013 11:16:56 +0200
Subject: [PATCH] ARM: ux500: Fix intcore regulator name
Message-ID: <1365499016-8348-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ux500 regulator name for V-INTCORE is misspelled as vinitcore instead of
vintcore in some .dts file, causing the AB8500 regulator driver to not
bind properly.  Fix this by replacing all occurrences with the right
name.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 Documentation/devicetree/bindings/mfd/ab8500.txt | 2 +-
 arch/arm/boot/dts/dbx5x0.dtsi                    | 6 +++---
 arch/arm/boot/dts/href.dtsi                      | 2 +-
 arch/arm/boot/dts/hrefv60plus.dts                | 2 +-
 arch/arm/boot/dts/snowball.dts                   | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
index c3a14e0..cd9e90c 100644
--- a/Documentation/devicetree/bindings/mfd/ab8500.txt
+++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
@@ -120,7 +120,7 @@ ab8500 {
                                   "USB_LINK_STATUS",
                                   "USB_ADP_PROBE_PLUG",
                                   "USB_ADP_PROBE_UNPLUG";
-                vddulpivio18-supply = <&ab8500_ldo_initcore_reg>;
+                vddulpivio18-supply = <&ab8500_ldo_intcore_reg>;
                 v-ape-supply = <&db8500_vape_reg>;
                 musb_1v8-supply = <&db8500_vsmps2_reg>;
         };
diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 9de9309..70e5d5a 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -383,7 +383,7 @@
 							  "USB_LINK_STATUS",
 							  "USB_ADP_PROBE_PLUG",
 							  "USB_ADP_PROBE_UNPLUG";
-					vddulpivio18-supply = <&ab8500_ldo_initcore_reg>;
+					vddulpivio18-supply = <&ab8500_ldo_intcore_reg>;
 					v-ape-supply = <&db8500_vape_reg>;
 					musb_1v8-supply = <&db8500_vsmps2_reg>;
 				};
@@ -441,8 +441,8 @@
 					};
 
 					// supply for v-intcore12; VINTCORE12 LDO
-					ab8500_ldo_initcore_reg: ab8500_ldo_initcore {
-						regulator-compatible = "ab8500_ldo_initcore";
+					ab8500_ldo_intcore_reg: ab8500_ldo_intcore {
+						regulator-compatible = "ab8500_ldo_intcore";
 					};
 
 					// supply for tvout; gpadc; TVOUT LDO
diff --git a/arch/arm/boot/dts/href.dtsi b/arch/arm/boot/dts/href.dtsi
index 379128e..2e0978a 100644
--- a/arch/arm/boot/dts/href.dtsi
+++ b/arch/arm/boot/dts/href.dtsi
@@ -235,7 +235,7 @@
 						regulator-name = "V-MMC-SD";
 					};
 
-					ab8500_ldo_initcore_reg: ab8500_ldo_initcore {
+					ab8500_ldo_intcore_reg: ab8500_ldo_intcore {
 						regulator-name = "V-INTCORE";
 					};
 
diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index 2b587a7..27fabc8 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -172,7 +172,7 @@
 						regulator-name = "V-MMC-SD";
 					};
 
-					ab8500_ldo_initcore_reg: ab8500_ldo_initcore {
+					ab8500_ldo_intcore_reg: ab8500_ldo_intcore {
 						regulator-name = "V-INTCORE";
 					};
 
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index d3ec32f..5e3438b 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -312,7 +312,7 @@
 						regulator-name = "V-MMC-SD";
 					};
 
-					ab8500_ldo_initcore_reg: ab8500_ldo_initcore {
+					ab8500_ldo_intcore_reg: ab8500_ldo_intcore {
 						regulator-name = "V-INTCORE";
 					};
 
-- 
1.8.1.3
