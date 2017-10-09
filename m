From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Mon, 9 Oct 2017 19:09:34 +0300
Subject: [PATCH 12/15] ARM: dts: at91: sama5d2_xplained: remove pull-up on
 SD/MMC lines
In-Reply-To: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
References: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1507565377-1545-13-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the board have the proper pull-ups soldered on the data and CMD
lines we don't need them specified in the PADs. So remove the
"bias-pull-up" property and set "bias-disable".
This will also save some power.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[claudiu.beznea at microchip.com: change subject to match the desired prefix]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 82777747cc72..cd53c0a33591 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -444,7 +444,7 @@
 							 <PIN_PA7__SDMMC0_DAT5>,
 							 <PIN_PA8__SDMMC0_DAT6>,
 							 <PIN_PA9__SDMMC0_DAT7>;
-						bias-pull-up;
+						bias-disable;
 					};
 
 					ck_cd_rstn_vddsel {
@@ -463,7 +463,7 @@
 							 <PIN_PA19__SDMMC1_DAT1>,
 							 <PIN_PA20__SDMMC1_DAT2>,
 							 <PIN_PA21__SDMMC1_DAT3>;
-						bias-pull-up;
+						bias-disable;
 					};
 
 					conf-ck_cd {
-- 
2.7.4
