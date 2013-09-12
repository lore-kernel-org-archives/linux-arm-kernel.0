From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Sep 2013 15:45:41 +0200
Subject: [PATCH 2/2] ARM: ux500: skip redefined regulator names on v60plus
 board
Message-ID: <1378993541-24403-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These regulator rail names are already set in the
ste-href.dtsi file included by this file, this is just redoing
the naming for no benefit, so delete it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-hrefv60plus.dts | 50 -----------------------------------
 1 file changed, 50 deletions(-)

diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dts b/arch/arm/boot/dts/ste-hrefv60plus.dts
index 0e2be7a..bb3cfc7 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dts
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dts
@@ -74,55 +74,5 @@
 
 			status = "okay";
 		};
-
-		prcmu at 80157000 {
-			ab8500 {
-				ab8500-regulators {
-					ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
-						regulator-name = "V-DISPLAY";
-					};
-
-					ab8500_ldo_aux2_reg: ab8500_ldo_aux2 {
-						regulator-name = "V-eMMC1";
-					};
-
-					ab8500_ldo_aux3_reg: ab8500_ldo_aux3 {
-						regulator-name = "V-MMC-SD";
-					};
-
-					ab8500_ldo_intcore_reg: ab8500_ldo_intcore {
-						regulator-name = "V-INTCORE";
-					};
-
-					ab8500_ldo_tvout_reg: ab8500_ldo_tvout {
-						regulator-name = "V-TVOUT";
-					};
-
-					ab8500_ldo_usb_reg: ab8500_ldo_usb {
-						regulator-name = "dummy";
-					};
-
-					ab8500_ldo_audio_reg: ab8500_ldo_audio {
-						regulator-name = "V-AUD";
-					};
-
-					ab8500_ldo_anamic1_reg: ab8500_ldo_anamic1 {
-						regulator-name = "V-AMIC1";
-					};
-
-					ab8500_ldo_anamic2_reg: ab8500_ldo_anamic2 {
-						regulator-name = "V-AMIC2";
-					};
-
-					ab8500_ldo_dmic_reg: ab8500_ldo_dmic {
-						regulator-name = "V-DMIC";
-					};
-
-					ab8500_ldo_ana_reg: ab8500_ldo_ana {
-						regulator-name = "V-CSI/DSI";
-					};
-				};
-			};
-		};
 	};
 };
-- 
1.8.3.1
