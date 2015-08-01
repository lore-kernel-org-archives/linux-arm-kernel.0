From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat,  1 Aug 2015 12:38:52 +0900
Subject: [PATCH] pinctrl: UniPhier: PH1-Pro5: add I2C ch6 pin-mux setting
Message-ID: <1438400332-2933-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initial version of this driver missed to add I2C ch6 pin-muxing.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c b/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c
index b35cf4a..9af4559 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c
@@ -810,6 +810,8 @@ static const unsigned i2c5b_pins[] = {196, 197};
 static const unsigned i2c5b_muxvals[] = {2, 2};
 static const unsigned i2c5c_pins[] = {215, 216};
 static const unsigned i2c5c_muxvals[] = {2, 2};
+static const unsigned i2c6_pins[] = {101, 102};
+static const unsigned i2c6_muxvals[] = {2, 2};
 static const unsigned nand_pins[] = {19, 20, 21, 22, 23, 24, 25, 28, 29, 30,
 				     31, 32, 33, 34, 35};
 static const unsigned nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -927,6 +929,7 @@ static const struct uniphier_pinctrl_group ph1_pro5_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c5),
 	UNIPHIER_PINCTRL_GROUP(i2c5b),
 	UNIPHIER_PINCTRL_GROUP(i2c5c),
+	UNIPHIER_PINCTRL_GROUP(i2c6),
 	UNIPHIER_PINCTRL_GROUP(uart0),
 	UNIPHIER_PINCTRL_GROUP(uart0b),
 	UNIPHIER_PINCTRL_GROUP(uart1),
@@ -1204,6 +1207,7 @@ static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c2_groups[] = {"i2c2"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const i2c5_groups[] = {"i2c5", "i2c5b", "i2c5c"};
+static const char * const i2c6_groups[] = {"i2c6"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
 static const char * const uart0_groups[] = {"uart0", "uart0b"};
 static const char * const uart1_groups[] = {"uart1"};
@@ -1290,6 +1294,7 @@ static const struct uniphier_pinmux_function ph1_pro5_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c2),
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(i2c5),
+	UNIPHIER_PINMUX_FUNCTION(i2c6),
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
-- 
1.9.1
