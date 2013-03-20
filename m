From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 20 Mar 2013 12:22:54 +0100
Subject: [PATCH] DTS at91sam9x5ek: i2c1 and i2c2 conflict with macb and lcd
Message-ID: <1363778575-4809-1-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on at91sam9x5ek, macb0 is enabled, so it conflicts with i2c2 (PB4)
same for i2c1, (conflicts with LCD).
Moreover, only i2c0 is used on this board.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 8a7cf1d..1128565 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -61,14 +61,6 @@
 				status = "okay";
 			};
 
-			i2c1: i2c at f8014000 {
-				status = "okay";
-			};
-
-			i2c2: i2c at f8018000 {
-				status = "okay";
-			};
-
 			pinctrl at fffff400 {
 				mmc0 {
 					pinctrl_board_mmc0: mmc0-board {
-- 
1.7.2.5
