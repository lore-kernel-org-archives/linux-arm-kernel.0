From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jun 2013 15:43:43 +0200
Subject: [PATCH 2/4] ARM: cfa10049: Switch the chip select pin of the LCD
 controller
In-Reply-To: <1371131025-12200-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1371131025-12200-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1371131025-12200-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Brian Lilly <brian@crystalfontz.com>

The early prototypes had the chip select pin for the LCD controller
wired on the GPIO 3-23, while the production run of the CFA-10049 have
this chip select on the GPIO 3-5.

Signed-off-by: Brian Lilly <brian@crystalfontz.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 063e620..fa91af5 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -33,7 +33,7 @@
 						0x1163 /* MX28_PAD_LCD_D22__GPIO_1_22 */
 						0x1173 /* MX28_PAD_LCD_D22__GPIO_1_23 */
 						0x2153 /* MX28_PAD_SSP2_D5__GPIO_2_21 */
-						0x3173 /* MX28_PAD_LCD_RESET__GPIO_3_23 */
+						0x3053 /* MX28_PAD_AUART1_TX__GPIO_3_5 */
 					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
@@ -265,7 +265,7 @@
 		gpio-sck = <&gpio2 16 0>;
 		gpio-mosi = <&gpio2 17 0>;
 		gpio-miso = <&gpio2 18 0>;
-		cs-gpios = <&gpio3 23 0>;
+		cs-gpios = <&gpio3 5 0>;
 		num-chipselects = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.3
