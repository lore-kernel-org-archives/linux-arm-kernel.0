From: aida.mynzhasova@skitlab.ru (Aida Mynzhasova)
Date: Sat, 26 Oct 2013 19:15:30 +0400
Subject: [PATCH] ARM: dts: mxs: add additional can interface pinmuxes to
 imx28.dtsi
Message-ID: <1382800530-3113-1-git-send-email-aida.mynzhasova@skitlab.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add alternative pinmuxes for can interface.

Signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
---
 arch/arm/boot/dts/imx28.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index cab4c22..dc49a5c 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -686,6 +686,17 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				can0_pins_b: can0 at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						MX28_PAD_AUART3_RX__CAN0_TX
+						MX28_PAD_AUART3_TX__CAN0_RX
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				can1_pins_a: can1 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
@@ -697,6 +708,17 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				can1_pins_b: can1 at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						MX28_PAD_AUART3_CTS__CAN1_TX
+						MX28_PAD_AUART3_RTS__CAN1_RX
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				spi2_pins_a: spi2 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.8.1.2
