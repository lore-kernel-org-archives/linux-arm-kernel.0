From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 28 May 2015 11:55:16 +0200
Subject: [PATCH] ARM: at91: dt: sama5d4ek: mci0 uses slot 0
Message-ID: <1432806916-23579-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mci0 uses slot 0 not 1.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: 7a4752677c44 ("ARM: at91: dt: add device tree file for SAMA5D4ek
board")
---
 arch/arm/boot/dts/at91-sama5d4ek.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index 89ef4a5..45e7761 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -108,8 +108,8 @@
 			mmc0: mmc at f8000000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3 &pinctrl_mmc0_cd>;
-				slot at 1 {
-					reg = <1>;
+				slot at 0 {
+					reg = <0>;
 					bus-width = <4>;
 					cd-gpios = <&pioE 5 0>;
 				};
-- 
2.2.0
