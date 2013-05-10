From: marex@denx.de (Marek Vasut)
Date: Fri, 10 May 2013 14:26:34 +0200
Subject: [PATCH 1/2] ARM: mxs: Add default AUART2 pinmux
Message-ID: <1368188795-9114-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux for AUART2 pins where they are in mux0.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 7ba4966..13799cf 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -308,6 +308,17 @@
 					fsl,pull-up = <0>;
 				};
 
+				auart2_2pins_b: auart2-2pins at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						0x3080 /* MX28_PAD_AUART2_RX__AUART2_RX */
+						0x3090 /* MX28_PAD_AUART2_TX__AUART2_TX */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				auart3_pins_a: auart3 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.10.4
