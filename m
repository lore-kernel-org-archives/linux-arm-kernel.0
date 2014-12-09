From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue,  9 Dec 2014 09:42:04 +0100
Subject: [PATCH v2] ARM: i.MX53: dts: add sahara module
Message-ID: <1418114524-11325-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX53 has a SAHARA v4 core. Add it to the dtsi.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes since v1:
	- remove status property

 arch/arm/boot/dts/imx53.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index b96213ba0671..ff4fa7ecacd8 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -765,6 +765,15 @@
 				resets = <&src 1>;
 				iram = <&ocram>;
 			};
+
+			sahara: crypto at 63ff8000 {
+				compatible = "fsl,imx53-sahara";
+				reg = <0x63ff8000 0x4000>;
+				interrupts = <19 20>;
+				clocks = <&clks IMX5_CLK_SAHARA_IPG_GATE>,
+				         <&clks IMX5_CLK_SAHARA_IPG_GATE>;
+				clock-names = "ipg", "ahb";
+			};
 		};
 
 		ocram: sram at f8000000 {
-- 
2.1.3
