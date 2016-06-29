From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 29 Jun 2016 17:45:10 +0900
Subject: [PATCH] pinctrl: uniphier: remove pointless SD pin-mux setting for
 PH1-LD11
Message-ID: <1467189910-14125-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This SoC has no SD card controller.  This pin-muxing has no point.

Fixes: 70f2f9c4cf25 ("pinctrl: uniphier: add UniPhier PH1-LD11 pinctrl driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
index 608cd73..2c43576 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -485,8 +485,6 @@ static const int i2c4_muxvals[] = {1, 1};
 static const unsigned nand_pins[] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
 				     15, 16, 17};
 static const int nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
-static const unsigned sd_pins[] = {10, 11, 12, 13, 14, 15, 16, 17};
-static const int sd_muxvals[] = {3, 3, 3, 3, 3, 3, 3, 3};  /* No SDVOLC */
 static const unsigned system_bus_pins[] = {1, 2, 6, 7, 8, 9, 10, 11, 12, 13,
 					   14, 15, 16, 17};
 static const int system_bus_muxvals[] = {0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
@@ -598,7 +596,6 @@ static const struct uniphier_pinctrl_group uniphier_ld11_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c3),
 	UNIPHIER_PINCTRL_GROUP(i2c4),
 	UNIPHIER_PINCTRL_GROUP(nand),
-	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP(system_bus),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
 	UNIPHIER_PINCTRL_GROUP(uart0),
@@ -826,7 +823,6 @@ static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const i2c4_groups[] = {"i2c4"};
 static const char * const nand_groups[] = {"nand"};
-static const char * const sd_groups[] = {"sd"};
 static const char * const system_bus_groups[] = {"system_bus",
 						 "system_bus_cs1"};
 static const char * const uart0_groups[] = {"uart0"};
@@ -907,7 +903,6 @@ static const struct uniphier_pinmux_function uniphier_ld11_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(i2c4),
 	UNIPHIER_PINMUX_FUNCTION(nand),
-	UNIPHIER_PINMUX_FUNCTION(sd),
 	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
-- 
1.9.1
