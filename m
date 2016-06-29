From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 29 Jun 2016 17:57:13 +0900
Subject: [PATCH] pinctrl: uniphier: remove pointless pin-mux settings for
 PH1-LD11
Message-ID: <1467190633-19990-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This SoC has no SD card controller.  Nor does it have USB port3.
These pin-mux settings have no point.

Fixes: 70f2f9c4cf25 ("pinctrl: uniphier: add UniPhier PH1-LD11 pinctrl driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
index 608cd73..89a260e 100644
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
@@ -507,8 +505,6 @@ static const unsigned usb1_pins[] = {48, 49};
 static const int usb1_muxvals[] = {0, 0};
 static const unsigned usb2_pins[] = {50, 51};
 static const int usb2_muxvals[] = {0, 0};
-static const unsigned usb3_pins[] = {52, 53};
-static const int usb3_muxvals[] = {0, 0};
 static const unsigned port_range_pins[] = {
 	159, 160, 161, 162, 163, 164, 165, 166,		/* PORT0x */
 	0, 1, 2, 3, 4, 5, 6, 7,				/* PORT1x */
@@ -598,7 +594,6 @@ static const struct uniphier_pinctrl_group uniphier_ld11_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c3),
 	UNIPHIER_PINCTRL_GROUP(i2c4),
 	UNIPHIER_PINCTRL_GROUP(nand),
-	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP(system_bus),
 	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
 	UNIPHIER_PINCTRL_GROUP(uart0),
@@ -608,7 +603,6 @@ static const struct uniphier_pinctrl_group uniphier_ld11_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(usb0),
 	UNIPHIER_PINCTRL_GROUP(usb1),
 	UNIPHIER_PINCTRL_GROUP(usb2),
-	UNIPHIER_PINCTRL_GROUP(usb3),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_PORT(port_range),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_IRQ(xirq),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_IRQ(xirq_alternatives),
@@ -826,7 +820,6 @@ static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const i2c4_groups[] = {"i2c4"};
 static const char * const nand_groups[] = {"nand"};
-static const char * const sd_groups[] = {"sd"};
 static const char * const system_bus_groups[] = {"system_bus",
 						 "system_bus_cs1"};
 static const char * const uart0_groups[] = {"uart0"};
@@ -836,7 +829,6 @@ static const char * const uart3_groups[] = {"uart3"};
 static const char * const usb0_groups[] = {"usb0"};
 static const char * const usb1_groups[] = {"usb1"};
 static const char * const usb2_groups[] = {"usb2"};
-static const char * const usb3_groups[] = {"usb3"};
 static const char * const port_groups[] = {
 	"port00",  "port01",  "port02",  "port03",
 	"port04",  "port05",  "port06",  "port07",
@@ -907,7 +899,6 @@ static const struct uniphier_pinmux_function uniphier_ld11_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(i2c4),
 	UNIPHIER_PINMUX_FUNCTION(nand),
-	UNIPHIER_PINMUX_FUNCTION(sd),
 	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
@@ -916,7 +907,6 @@ static const struct uniphier_pinmux_function uniphier_ld11_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(usb0),
 	UNIPHIER_PINMUX_FUNCTION(usb1),
 	UNIPHIER_PINMUX_FUNCTION(usb2),
-	UNIPHIER_PINMUX_FUNCTION(usb3),
 	UNIPHIER_PINMUX_FUNCTION(port),
 	UNIPHIER_PINMUX_FUNCTION(xirq),
 };
-- 
1.9.1
