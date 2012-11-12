From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Nov 2012 16:23:29 +0100
Subject: [PATCH 7/7] ARM i.MX51 babbage: Add display support
In-Reply-To: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
References: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1352733809-27230-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The babbage board has a DVI-I output which allows to output analog
and digital signals simultaneously. This patch adds support for it
to the devicetree. The DDC signals are not wired up on the board, so
DRM will fall back on default VESA modes.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx51-babbage.dts |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index cbd2b1c..567e7ee 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -22,6 +22,22 @@
 	};
 
 	soc {
+		display at di0 {
+			compatible = "fsl,imx-parallel-display";
+			crtcs = <&ipu 0>;
+			interface-pix-fmt = "rgb24";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ipu_disp1_1>;
+		};
+
+		display at di1 {
+			compatible = "fsl,imx-parallel-display";
+			crtcs = <&ipu 1>;
+			interface-pix-fmt = "rgb565";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ipu_disp2_1>;
+		};
+
 		aips at 70000000 { /* aips-1 */
 			spba at 70000000 {
 				esdhc at 70004000 { /* ESDHC1 */
-- 
1.7.10.4
