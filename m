From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 20 Aug 2018 12:20:41 +0200
Subject: [PATCH] ARM: dts: at91/trivial: remove old NAND bindings leftover in
 sama5d2
Message-ID: <20180820102041.27476-1-nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the new bindings are already in place in sama5d2.dtsi and that it's used
in the only Mainline board for this product (at91-sama5d2_ptc_ek.dts), we can
safely remove the old bindings.

Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 61f68e5c48e9..fd1a401f2914 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -323,44 +323,6 @@
 			};
 		};
 
-		nand0: nand at 80000000 {
-			compatible = "atmel,sama5d2-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			reg = < /* EBI CS3 */
-				0x80000000 0x08000000
-				/* SMC PMECC regs */
-				0xf8014070 0x00000490
-				/* SMC PMECC Error Location regs */
-				0xf8014500 0x00000200
-				/* ROM Galois tables */
-				0x00040000 0x00018000
-				>;
-			interrupts = <17 IRQ_TYPE_LEVEL_HIGH 6>;
-			atmel,nand-addr-offset = <21>;
-			atmel,nand-cmd-offset = <22>;
-			atmel,nand-has-dma;
-			atmel,has-pmecc;
-			atmel,pmecc-lookup-table-offset = <0x0 0x8000>;
-			status = "disabled";
-
-			nfc at c0000000 {
-				compatible = "atmel,sama5d3-nfc";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = < /* NFC Command Registers */
-					0xc0000000 0x08000000
-					/* NFC HSMC regs */
-					0xf8014000 0x00000070
-					/* NFC SRAM banks */
-					0x00100000 0x00100000
-					>;
-				clocks = <&hsmc_clk>;
-				atmel,write-by-sram;
-			};
-		};
-
 		sdmmc0: sdio-host at a0000000 {
 			compatible = "atmel,sama5d2-sdhci";
 			reg = <0xa0000000 0x300>;
-- 
2.15.1
