From: c.hemp@phytec.de (Christian Hemp)
Date: Fri, 14 Nov 2014 14:32:24 +0100
Subject: [PATCH 3/5] ARM:dts:imx6:phyFLEX: Set correct interrupt for pmic
In-Reply-To: <1415971946-48975-1-git-send-email-c.hemp@phytec.de>
References: <1415971946-48975-1-git-send-email-c.hemp@phytec.de>
Message-ID: <1415971946-48975-4-git-send-email-c.hemp@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMIC interrupt was changed from modul revision 1 to 2. Revision 1 was
declared as a prototype and is not in series by any customers.

Signed-off-by: Christian Hemp <c.hemp@phytec.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index af30653..8d718b5 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -107,8 +107,8 @@
 	pmic at 58 {
 		compatible = "dlg,da9063";
 		reg = <0x58>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <17 0x8>; /* active-low GPIO4_17 */
+		interrupt-parent = <&gpio2>;
+		interrupts = <9 0x8>; /* active-low GPIO2_9 */
 
 		regulators {
 			vddcore_reg: bcore1 {
@@ -205,7 +205,7 @@
 			fsl,pins = <
 				MX6QDL_PAD_EIM_D23__GPIO3_IO23 0x80000000
 				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24 0x80000000 /* SPI NOR chipselect */
-				MX6QDL_PAD_DI0_PIN15__GPIO4_IO17  0x80000000 /* PMIC interrupt */
+				MX6QDL_PAD_SD4_DAT1__GPIO2_IO09  0x80000000 /* PMIC interrupt */
 				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 0x80000000 /* Green LED */
 				MX6QDL_PAD_EIM_EB3__GPIO2_IO31 0x80000000 /* Red LED */
 			>;
-- 
1.9.1
