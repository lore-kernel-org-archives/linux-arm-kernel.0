From: b32955@freescale.com (Huang Shijie)
Date: Thu, 24 May 2012 18:45:38 +0800
Subject: [PATCH] ARM: mx28: add gpmi-nand dt support
Message-ID: <1337856338-24723-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add gpmi-nand device tree support.
Also enable the gpmi support for mx28-evk board.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts |    4 ++++
 arch/arm/boot/dts/imx28.dtsi    |   18 +++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index ee520a5..5fff6c9 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -22,6 +22,10 @@
 
 	apb at 80000000 {
 		apbh at 80000000 {
+			gpmi-nand at 8000c000 {
+				status = "okay";
+			};
+
 			ssp0: ssp at 80010000 {
 				compatible = "fsl,imx28-mmc";
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 4634cb8..2358089 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -68,15 +68,15 @@
 				status = "disabled";
 			};
 
-			bch at 8000a000 {
-				reg = <0x8000a000 2000>;
-				interrupts = <41>;
-				status = "disabled";
-			};
-
-			gpmi at 8000c000 {
-				reg = <0x8000c000 2000>;
-				interrupts = <42 88>;
+			gpmi-nand at 8000c000 {
+				compatible = "fsl,imx28-gpmi-nand";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x8000c000 2000>, <0x8000a000 2000>;
+				reg-names = "gpmi-nand", "bch";
+				interrupts = <88>, <41>;
+				interrupt-names = "gpmi-dma", "bch";
+				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
 
-- 
1.7.0.4
