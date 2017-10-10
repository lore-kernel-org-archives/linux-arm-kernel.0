From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Tue, 10 Oct 2017 13:09:46 +0300
Subject: [PATCH v2 11/14] ARM: dts: at91: sama5d2_xplained: remove pull-up on
 SD/MMC lines
In-Reply-To: <1507630189-15504-1-git-send-email-claudiu.beznea@microchip.com>
References: <1507630189-15504-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1507630189-15504-12-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

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
index 851a095fd51d..62328310ef42 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -437,7 +437,7 @@
 							 <PIN_PA7__SDMMC0_DAT5>,
 							 <PIN_PA8__SDMMC0_DAT6>,
 							 <PIN_PA9__SDMMC0_DAT7>;
-						bias-pull-up;
+						bias-disable;
 					};
 
 					ck_cd_rstn_vddsel {
@@ -456,7 +456,7 @@
 							 <PIN_PA19__SDMMC1_DAT1>,
 							 <PIN_PA20__SDMMC1_DAT2>,
 							 <PIN_PA21__SDMMC1_DAT3>;
-						bias-pull-up;
+						bias-disable;
 					};
 
 					conf-ck_cd {
-- 
2.7.4
