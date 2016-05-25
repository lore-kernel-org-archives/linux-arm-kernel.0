From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 May 2016 13:55:28 +0200
Subject: [PATCH 1/3] ARM: dts: Ux500: move compatible string to chipset
Message-ID: <1464177328-27416-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the compatible string "stericsson,ab8500" from the board
definitions into the main node in the chipset file where it
belongs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi  | 1 +
 arch/arm/boot/dts/ste-href.dtsi    | 1 -
 arch/arm/boot/dts/ste-snowball.dts | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 6ae56838bd3a..d309314f3a36 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -604,6 +604,7 @@
 				#interrupt-cells = <2>;
 
 				ab8500_gpio: ab8500-gpio {
+					compatible = "stericsson,ab8500-gpio";
 					gpio-controller;
 					#gpio-cells = <2>;
 				};
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 6d8ce154347e..48dc38482633 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -223,7 +223,6 @@
 		prcmu at 80157000 {
 			ab8500 {
 				ab8500-gpio {
-					compatible = "stericsson,ab8500-gpio";
 				};
 
 				ab8500-regulators {
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 36e84efc401c..37ae6166b0e6 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -352,7 +352,6 @@
 
 			ab8500 {
 				ab8500-gpio {
-					compatible = "stericsson,ab8500-gpio";
 				};
 
 				ext_regulators: ab8500-ext-regulators {
-- 
2.4.11
