From: clg@kaod.org (=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=)
Date: Wed, 19 Apr 2017 15:43:15 +0200
Subject: [PATCH] ARM: dts: aspeed-g4: fix AHB window size of the SMC
 controllers
Message-ID: <1492609395-9151-1-git-send-email-clg@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The window of the Aspeed AST2400 SMC Controllers to map chips on the
AHB Bus has a 256MB size. The full window range is

    [ 0x20000000 - 0x2FFFFFFF ] for the FMC controller
    [ 0x30000000 - 0x3FFFFFFF ] for the SPI controller

This change requires CONFIG_VMSPLIT_2G to be set.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 4e3f055b365c..a7b6e04d5f1b 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -26,7 +26,7 @@
 
 		fmc: flash-controller at 1e620000 {
 			reg = < 0x1e620000 0x94
-				0x20000000 0x02000000 >;
+				0x20000000 0x10000000 >;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2400-fmc";
@@ -41,7 +41,7 @@
 
 		spi: flash-controller at 1e630000 {
 			reg = < 0x1e630000 0x18
-				0x30000000 0x02000000 >;
+				0x30000000 0x10000000 >;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2400-spi";
-- 
2.7.4
