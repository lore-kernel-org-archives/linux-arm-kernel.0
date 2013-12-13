From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:58 +0900
Subject: [PATCH 24/69] ARM: shmobile: armadillo: tidyup DT node naming
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <e63763b9b55a6833047199bd587e061520302ffc.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

According to ePAPR spec,
this patch tidies up DT node name.

This patch removed un-used "touchscreen" label

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 1c56c5e..6a54219 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -90,7 +90,7 @@
 
 &i2c0 {
 	status = "okay";
-	touchscreen: st1232 at 55 {
+	touchscreen at 55 {
 		compatible = "sitronix,st1232";
 		reg = <0x55>;
 		interrupt-parent = <&irqpin1>;
@@ -105,12 +105,12 @@
 	pinctrl-0 = <&scifa1_pins>;
 	pinctrl-names = "default";
 
-	scifa1_pins: scifa1 {
+	scifa1_pins: serial1 {
 		renesas,groups = "scifa1_data";
 		renesas,function = "scifa1";
 	};
 
-	st1232_pins: st1232 {
+	st1232_pins: touchscreen {
 		renesas,groups = "intc_irq10";
 		renesas,function = "intc";
 	};
@@ -125,7 +125,7 @@
 		renesas,function = "mmc0";
 	};
 
-	sdhi0_pins: sdhi0 {
+	sdhi0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_wp";
 		renesas,function = "sdhi0";
 	};
-- 
1.8.4
