From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 28 Mar 2012 12:05:49 +0200
Subject: [PATCH v2 2/3] arm: at91: at91sam9x5 add mci support
In-Reply-To: <1332929150-14240-1-git-send-email-ludovic.desroches@atmel.com>
References: <1332929150-14240-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1332929150-14240-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |   24 ++++++++++++++++++++++++
 arch/arm/mach-at91/at91sam9x5.c   |    2 ++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index c111001..c2ab650 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -191,6 +191,30 @@
 				interrupts = <27 4>;
 				status = "disabled";
 			};
+
+			mmc0: mmc at f0008000 {
+				compatible = "atmel,hsmci";
+				reg = <0xf0008000 0x600>;
+				interrupts = <12 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				slot at 0 {
+					reg = <0>;
+				};
+			};
+
+			mmc1: mmc at f000c000 {
+				compatible = "atmel,hsmci";
+				reg = <0xf000c000 0x600>;
+				interrupts = <26 4>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				slot at 0 {
+					reg = <0>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 13c8cae..39cbef3 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -225,6 +225,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller", &dma0_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffee00.dma-controller", &dma1_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "f0008000.mmc", &mmc0_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "f000c000.mmc", &mmc1_clk),
 	CLKDEV_CON_ID("pioA", &pioAB_clk),
 	CLKDEV_CON_ID("pioB", &pioAB_clk),
 	CLKDEV_CON_ID("pioC", &pioCD_clk),
-- 
1.7.5.4
