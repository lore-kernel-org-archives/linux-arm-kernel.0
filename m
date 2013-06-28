From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 28 Jun 2013 15:02:53 +0200
Subject: [PATCHv3 4/8] ARM: mxs: dt: cfa10036: make hogpins grabbed by
 respective drivers
In-Reply-To: <1372424577-8279-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372424577-8279-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1372424577-8279-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10036.dts | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index 94c4476..1ec8c94 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -23,10 +23,7 @@
 	apb at 80000000 {
 		apbh at 80000000 {
 			pinctrl at 80018000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&hog_pins_cfa10036>;
-
-				hog_pins_cfa10036: hog-10036 at 0 {
+				ssd1306_cfa10036: ssd1306-10036 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
 						0x2073 /* MX28_PAD_SSP0_D7__GPIO_2_7 */
@@ -83,6 +80,8 @@
 
 				ssd1306: oled@3c {
 					compatible = "solomon,ssd1306fb-i2c";
+					pinctrl-names = "default";
+					pinctrl-0 = <&ssd1306_cfa10036>;
 					reg = <0x3c>;
 					reset-gpios = <&gpio2 7 0>;
 					solomon,height = <32>;
-- 
1.8.1.2
