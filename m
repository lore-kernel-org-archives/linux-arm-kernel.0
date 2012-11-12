From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Nov 2012 16:23:26 +0100
Subject: [PATCH 4/7] ARM i.MX53: Add IPU support
In-Reply-To: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
References: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1352733809-27230-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the IPU device to the devicetree.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 76ebb1a..3387c5d 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -67,6 +67,13 @@
 		interrupt-parent = <&tzic>;
 		ranges;
 
+		ipu: ipu at 18000000 {
+			#crtc-cells = <1>;
+			compatible = "fsl,imx53-ipu";
+			reg = <0x18000000 0x080000000>;
+			interrupts = <11 10>;
+		};
+
 		aips at 50000000 { /* AIPS1 */
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
-- 
1.7.10.4
