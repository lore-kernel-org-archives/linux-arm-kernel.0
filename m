From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 26 Sep 2017 09:22:23 +0200
Subject: [PATCH v3 03/14] ARM: dts: sunxi: h3/h5: Fix node with unit name and
 no reg property
In-Reply-To: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
Message-ID: <20170926072234.27481-4-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the warning "xxx has a unit name, but no reg property" by
removing "@0" from such node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 289f2cd06dfe..2e4bae988acd 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -322,7 +322,7 @@
 				function = "i2c2";
 			};
 
-			mmc0_pins_a: mmc0 at 0 {
+			mmc0_pins_a: mmc0 {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
 				function = "mmc0";
@@ -330,13 +330,13 @@
 				bias-pull-up;
 			};
 
-			mmc0_cd_pin: mmc0_cd_pin at 0 {
+			mmc0_cd_pin: mmc0_cd_pin {
 				pins = "PF6";
 				function = "gpio_in";
 				bias-pull-up;
 			};
 
-			mmc1_pins_a: mmc1 at 0 {
+			mmc1_pins_a: mmc1 {
 				pins = "PG0", "PG1", "PG2", "PG3",
 				       "PG4", "PG5";
 				function = "mmc1";
@@ -354,7 +354,7 @@
 				bias-pull-up;
 			};
 
-			spdif_tx_pins_a: spdif at 0 {
+			spdif_tx_pins_a: spdif {
 				pins = "PA17";
 				function = "spdif";
 			};
@@ -369,7 +369,7 @@
 				function = "spi1";
 			};
 
-			uart0_pins_a: uart0 at 0 {
+			uart0_pins_a: uart0 {
 				pins = "PA4", "PA5";
 				function = "uart0";
 			};
@@ -697,7 +697,7 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
-			ir_pins_a: ir at 0 {
+			ir_pins_a: ir {
 				pins = "PL11";
 				function = "s_cir_rx";
 			};
-- 
2.13.5
