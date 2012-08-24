From: marex@denx.de (Marek Vasut)
Date: Sat, 25 Aug 2012 01:51:37 +0200
Subject: [PATCH 1/4 V2] ARM: mx28: Add SPI 2 pinmux into imx28.dtsi
Message-ID: <1345852300-2213-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add this SSP port 2 pin multiplexing configuration into the imx28.dtsi file.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28.dtsi |   13 +++++++++++++
 1 file changed, 13 insertions(+)

V2: Add only SSP2 pinmux.

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 91b43e9..b996c2d 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -507,6 +507,19 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
+
+				spi2_pins_a: spi2 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x2100 /* MX28_PAD_SSP2_SCK__SSP2_SCK */
+						0x2110 /* MX28_PAD_SSP2_MOSI__SSP2_CMD */
+						0x2120 /* MX28_PAD_SSP2_MISO__SSP2_D0 */
+						0x2130 /* MX28_PAD_SSP2_SS0__SSP2_D3 */
+					>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
 			};
 
 			digctl at 8001c000 {
-- 
1.7.10.4
