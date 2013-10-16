From: aida.mynzhasova@skitlab.ru (Aida Mynzhasova)
Date: Wed, 16 Oct 2013 20:04:03 +0400
Subject: [PATCH] ARM: dts: mxs: add auart2 pinmux to imx28.dtsi
Message-ID: <1381939443-7318-1-git-send-email-aida.mynzhasova@skitlab.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add auart2 pins configuration on its main pads

Signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
---
 arch/arm/boot/dts/imx28.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 7363fde..81102b2 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -320,6 +320,19 @@
 					fsl,pull-up = <0>;
 				};
 
+				auart2_pins_a: auart2 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x3080 /* MX28_PAD_AUART2_RX__AUART2_RX	*/
+						0x3090 /* MX28_PAD_AUART2_TX__AUART2_TX */
+						0x30a0 /* MX28_PAD_AUART2_CTS__AUART2_CTS */
+						0x30b0 /* MX28_PAD_AUART2_RTS__AUART2_RTS */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				auart2_2pins_a: auart2-2pins at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.8.1.2
