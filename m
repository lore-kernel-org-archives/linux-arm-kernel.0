From: tony@atomide.com (Tony Lindgren)
Date: Mon, 3 Nov 2014 17:43:33 -0800
Subject: [PATCH] ARM: dts: Fix missing GPMC NAND device width for omap3 boards
Message-ID: <20141104014333.GO31454@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like we have some GPMC NAND timings missing device
width. This fixes "gpmc_cs_program_settings: invalid width 0!"
errors during boot.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -161,6 +161,7 @@
 		linux,mtd-name= "hynix,h8kds0un0mer-4em";
 		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
+		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
 
 		gpmc,sync-clk-ps = <0>;
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index ff0b11d..cc9343e 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -204,6 +204,7 @@
 		linux,mtd-name= "micron,mt29c4g96maz";
 		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
+		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
 
 		gpmc,sync-clk-ps = <0>;
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index fd7ed71..84b7452 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -61,6 +61,7 @@
 		linux,mtd-name= "micron,mt29c4g96maz";
 		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
+		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
 
 		gpmc,sync-clk-ps = <0>;
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 37d305a..202f95a 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -103,6 +103,7 @@
 		linux,mtd-name= "micron,nand";
 		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
+		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
 
 		gpmc,sync-clk-ps = <0>;
