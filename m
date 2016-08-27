From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 27 Aug 2016 15:59:50 +0800
Subject: [PATCH] ARM: dts: sun9i: Add missing #interrupt-cells to R_PIO
 pinctrl device node
Message-ID: <20160827075950.26524-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R_PIO device node is missing #interrupt-cells, which causes
interrupt parsing to fail to match it as a valid interrupt controller.

Add #interrupt-cells to it. Also remove the unnecesary #address-cells
and #size-cells.

Fixes: 1ac56a6da9e1 ("ARM: dts: sun9i: Add A80 R_PIO pin controller device
		      node")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 24e3cac4f571..3c5214cbe4e6 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -898,8 +898,7 @@
 			resets = <&apbs_rst 0>;
 			gpio-controller;
 			interrupt-controller;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
 			r_ir_pins: r_ir {
-- 
2.9.3
