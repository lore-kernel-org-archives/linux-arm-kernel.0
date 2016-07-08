From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  8 Jul 2016 10:40:39 +0800
Subject: [PATCH] ARM: dts: sun8i-h3: Rename sinovoip-bpi-m2-plus to
 bananapi-m2-plus
Message-ID: <1467945639-12844-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Banana Pi series is a well known series of single board computers.
The manufacturer, Sinovoip, is less well known. Moreover, the board
markings do not mention Sinovoip, but only the Banana Pi logo, and
the BPI-M* model name.

Rename the dts file to use the more well known name. Also fix up
some of the model names and labels to match other Banana Pi boards.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/Makefile                                          | 2 +-
 ...8i-h3-sinovoip-bpi-m2-plus.dts => sun8i-h3-bananapi-m2-plus.dts} | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm/boot/dts/{sun8i-h3-sinovoip-bpi-m2-plus.dts => sun8i-h3-bananapi-m2-plus.dts} (97%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e9fcd25701a0..b18a26925fa5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -764,11 +764,11 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a33-sinlinx-sina33.dtb \
 	sun8i-a83t-allwinner-h8homlet-v2.dtb \
 	sun8i-a83t-cubietruck-plus.dtb \
+	sun8i-h3-bananapi-m2-plus.dtb \
 	sun8i-h3-orangepi-2.dtb \
 	sun8i-h3-orangepi-one.dtb \
 	sun8i-h3-orangepi-pc.dtb \
 	sun8i-h3-orangepi-plus.dtb \
-	sun8i-h3-sinovoip-bpi-m2-plus.dtb \
 	sun8i-r16-parrot.dtb
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-sinovoip-bpi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
similarity index 97%
rename from arch/arm/boot/dts/sun8i-h3-sinovoip-bpi-m2-plus.dts
rename to arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index d21bc57ce140..f3b1d5f6dbd2 100644
--- a/arch/arm/boot/dts/sun8i-h3-sinovoip-bpi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -49,8 +49,8 @@
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
-	model = "Sinovoip BPI-M2+";
-	compatible = "sinovoip,bpi-m2+", "allwinner,sun8i-h3";
+	model = "Banana Pi BPI-M2-Plus";
+	compatible = "sinovoip,bpi-m2-plus", "allwinner,sun8i-h3";
 
 	aliases {
 		serial0 = &uart0;
@@ -67,7 +67,7 @@
 		pinctrl-0 = <&pwr_led_bpi_m2p>;
 
 		pwr_led {
-			label = "bpi-m2+:red:pwr";
+			label = "bananapi-m2-plus:red:pwr";
 			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
 			default-state = "on";
 		};
-- 
2.8.1
