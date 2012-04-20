From: b32955@freescale.com (Huang Shijie)
Date: Fri, 20 Apr 2012 17:24:18 +0800
Subject: [PATCH 2/3] ARM: mx28evk: add gpmi-nand dt support
In-Reply-To: <1334913859-5314-1-git-send-email-b32955@freescale.com>
References: <1334913859-5314-1-git-send-email-b32955@freescale.com>
Message-ID: <1334913859-5314-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add gpmi-nand device tree support, and add proper clock for it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx28.dtsi   |    9 +++++----
 arch/arm/mach-mxs/clock-mx28.c |    2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index dd209a3..2804a43 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -63,15 +63,16 @@
 			};
 
 			bch at 8000a000 {
+				compatible = "fsl,imx28-bch";
 				reg = <0x8000a000 2000>;
 				interrupts = <41>;
-				status = "disabled";
 			};
 
-			gpmi at 8000c000 {
+			gpmi-nand at 8000c000 {
+				compatible = "fsl,imx28-gpmi-nand";
 				reg = <0x8000c000 2000>;
-				interrupts = <42 88>;
-				status = "disabled";
+				interrupts = <88>;
+				dma_channel = <4>;
 			};
 
 			ssp at 80010000 {
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 8401854..6fe6737 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -617,7 +617,6 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("duart", NULL, uart_clk)
 	_REGISTER_CLOCK("imx28-fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("imx28-fec.1", NULL, fec_clk)
-	_REGISTER_CLOCK("imx28-gpmi-nand", NULL, gpmi_clk)
 	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
 	_REGISTER_CLOCK("mxs-auart.1", NULL, uart_clk)
 	_REGISTER_CLOCK("mxs-auart.2", NULL, uart_clk)
@@ -649,6 +648,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxs-saif.0", NULL, saif0_clk)
 	_REGISTER_CLOCK("mxs-saif.1", NULL, saif1_clk)
 	/* for DT */
+	_REGISTER_CLOCK("8000c000.gpmi-nand", NULL, gpmi_clk)
 	_REGISTER_CLOCK("80074000.serial", NULL, uart_clk)
 	_REGISTER_CLOCK("800f0000.ethernet", NULL, fec_clk)
 	_REGISTER_CLOCK("800f4000.ethernet", NULL, fec_clk)
-- 
1.7.0.4
