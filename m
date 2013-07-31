From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 31 Jul 2013 16:37:55 +0200
Subject: [PATCH 5/10] ARM: dts: mxs: add pin config for SSP3 interface
In-Reply-To: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
References: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1375281480-25775-5-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28.dtsi |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 3ec9a68..f597c0f 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -683,6 +683,21 @@
 					fsl,pull-up = <1>;
 				};
 
+				spi3_pins_a: spi3 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x3082 /* MX28_PAD_AUART2_RX__SSP3_D4 */
+						0x3092 /* MX28_PAD_AUART2_TX__SSP3_D5 */
+						0x2180 /* MX28_PAD_SSP3_SCK__SSP3_SCK */
+						0x2190 /* MX28_PAD_SSP3_MOSI__SSP3_CMD */
+						0x21A0 /* MX28_PAD_SSP3_MISO__SSP3_D0 */
+						0x21B0 /* MX28_PAD_SSP3_SS0__SSP3_D3 */
+					>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				usbphy0_pins_a: usbphy0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.2.5
