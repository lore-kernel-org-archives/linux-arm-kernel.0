From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu,  8 Aug 2013 14:51:25 +0200
Subject: [PATCH 6/8] ARM: dts: mxs: add pin config options for usbphy pins
In-Reply-To: <1375966287-6784-1-git-send-email-LW@KARO-electronics.de>
References: <1375966287-6784-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1375966287-6784-7-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28.dtsi |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 7363fde..f941648 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -731,6 +731,17 @@
 					fsl,pull-up = <0>;
 				};
 
+				usbphy0_pins_c: usbphy0 at 2 {
+					reg = <2>;
+					fsl,pinmux-ids = <
+						0x0123 /* MX28_PAD_GPMI_CE2N__GPIO_0_18 - USBOTG_VBUSEN */
+						0x0133 /* MX28_PAD_GPMI_CE3N__GPIO_0_19 - USBOTH_OC */
+					>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				usbphy1_pins_a: usbphy1 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
@@ -740,6 +751,17 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
+
+				usbphy1_pins_b: usbphy1 at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						0x31b3 /* MX28_PAD_SPDIF__GPIO_3_27 - USBH_VBUSEN */
+						0x4143 /* MX28_PAD_JTAG_RTCK__GPIO_4_20 - USBH_OC */
+					>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
 			};
 
 			digctl: digctl at 8001c000 {
-- 
1.7.2.5
