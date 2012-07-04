From: attila@kinali.ch (Attila Kinali)
Date: Wed,  4 Jul 2012 14:10:33 +0200
Subject: [PATCH] i.mx23: add dts node for mmc1/ssp1 Signed-off-by: Attila
 Kinali <attila@kinali.ch>
Message-ID: <1341403833-25437-1-git-send-email-attila@kinali.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/boot/dts/imx23.dtsi |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 8c5f999..df0ae8d 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -134,6 +134,21 @@
 					fsl,pinmux-ids = <0x2010 0x2060>;
 					fsl,pull-up = <0>;
 				};
+
+				mmc1_8bit_pins_a: mmc1-8bit at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x0002 0x0012 0x0022
+						0x0032 0x0042 0x0052 0x0062
+						0x0072 0x0142 0x0132 0x0182>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
+				mmc1_pins_fixup: mmc1-pins-fixup {
+					fsl,pinmux-ids = <0x0132 0x0182>;
+					fsl,pull-up = <0>;
+				};
 			};
 
 			digctl at 8001c000 {
-- 
1.7.10
