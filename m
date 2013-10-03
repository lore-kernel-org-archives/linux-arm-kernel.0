From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 Oct 2013 13:29:52 +0200
Subject: [PATCH 02/10] ARM: ux500 enable the AB8500 gpio for all HREFs
Message-ID: <1380799792-25770-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AB8500 GPIO was only registered for the pre-v60 HREF but should
be made available on all HREF variants, move the DT entry to the
common file.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href.dtsi      | 4 ++++
 arch/arm/boot/dts/ste-hrefprev60.dts | 8 --------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 5e7cf4b..d675326 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -169,6 +169,10 @@
 
 		prcmu at 80157000 {
 			ab8500 {
+				ab8500-gpio {
+					compatible = "stericsson,ab8500-gpio";
+				};
+
 				ab8500-regulators {
 					ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
 						regulator-name = "V-DISPLAY";
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dts b/arch/arm/boot/dts/ste-hrefprev60.dts
index d8d3b99..767fa21 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dts
+++ b/arch/arm/boot/dts/ste-hrefprev60.dts
@@ -25,14 +25,6 @@
 	};
 
 	soc {
-		prcmu at 80157000 {
-			ab8500 at 5 {
-				ab8500-gpio {
-					compatible = "stericsson,ab8500-gpio";
-				};
-			};
-		};
-
 		i2c at 80004000 {
 			tps61052 at 33 {
 				compatible = "tps61052";
-- 
1.8.3.1
