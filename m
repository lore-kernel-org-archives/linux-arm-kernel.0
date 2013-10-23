From: aida.mynzhasova@skitlab.ru (Aida Mynzhasova)
Date: Wed, 23 Oct 2013 10:58:57 +0400
Subject: [PATCH v2] ARM: dts: mxs: add auart2 pinmux to imx28.dtsi
Message-ID: <1382511537-5072-1-git-send-email-aida.mynzhasova@skitlab.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add auart2 pins configuration on its main pads

Signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
---
 arch/arm/boot/dts/imx28.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 918d419..cab4c22 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -343,6 +343,19 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				auart2_pins_a: auart2-pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_AUART2_RX__AUART2_RX
+						MX28_PAD_AUART2_TX__AUART2_TX
+						MX28_PAD_AUART2_CTS__AUART2_CTS
+						MX28_PAD_AUART2_RTS__AUART2_RTS
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
 				auart3_pins_a: auart3 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.8.1.2
