From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 24 Sep 2015 21:26:47 +0900
Subject: [PATCH v3 2/2] pinctrl: uniphier: add SD card pinmux settings
In-Reply-To: <1443097607-29011-1-git-send-email-yamada.masahiro@socionext.com>
References: <1443097607-29011-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1443097607-29011-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SD card pinmux settings for PH1-LD4, PH1-Pro4, PH1-sLD8,
PH1-Pro5, ProXstream2, and PH1-LD6b SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c     |  5 +++++
 drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c    |  5 +++++
 drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c    | 11 +++++++++++
 drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c    |  5 +++++
 drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c    |  5 +++++
 drivers/pinctrl/uniphier/pinctrl-proxstream2.c |  5 +++++
 6 files changed, 36 insertions(+)

diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c b/drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c
index 7beb87e..a7056dc 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c
@@ -537,6 +537,8 @@ static const unsigned nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 					0, 0};
 static const unsigned nand_cs1_pins[] = {22, 23};
 static const unsigned nand_cs1_muxvals[] = {0, 0};
+static const unsigned sd_pins[] = {44, 45, 46, 47, 48, 49, 50, 51, 52};
+static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned uart0_pins[] = {85, 88};
 static const unsigned uart0_muxvals[] = {1, 1};
 static const unsigned uart1_pins[] = {155, 156};
@@ -619,6 +621,7 @@ static const struct uniphier_pinctrl_group ph1_ld4_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c3),
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
+	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP(uart0),
 	UNIPHIER_PINCTRL_GROUP(uart1),
 	UNIPHIER_PINCTRL_GROUP(uart1b),
@@ -776,6 +779,7 @@ static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c2_groups[] = {"i2c2"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
+static const char * const sd_groups[] = {"sd"};
 static const char * const uart0_groups[] = {"uart0"};
 static const char * const uart1_groups[] = {"uart1", "uart1b"};
 static const char * const uart2_groups[] = {"uart2"};
@@ -831,6 +835,7 @@ static const struct uniphier_pinmux_function ph1_ld4_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c2),
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(nand),
+	UNIPHIER_PINMUX_FUNCTION(sd),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
 	UNIPHIER_PINMUX_FUNCTION(uart2),
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c
index 9720e697..1824831 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c
@@ -761,6 +761,8 @@ static const unsigned nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 					0, 0};
 static const unsigned nand_cs1_pins[] = {37, 38};
 static const unsigned nand_cs1_muxvals[] = {0, 0};
+static const unsigned sd_pins[] = {47, 48, 49, 50, 51, 52, 53, 54, 55};
+static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned uart0_pins[] = {135, 136};
 static const unsigned uart0_muxvals[] = {3, 3};
 static const unsigned uart0b_pins[] = {11, 12};
@@ -866,6 +868,7 @@ static const struct uniphier_pinctrl_group ph1_ld6b_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c3),
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
+	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP(uart0),
 	UNIPHIER_PINCTRL_GROUP(uart0b),
 	UNIPHIER_PINCTRL_GROUP(uart1),
@@ -1136,6 +1139,7 @@ static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c2_groups[] = {"i2c2"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
+static const char * const sd_groups[] = {"sd"};
 static const char * const uart0_groups[] = {"uart0", "uart0b"};
 static const char * const uart1_groups[] = {"uart1", "uart1b"};
 static const char * const uart2_groups[] = {"uart2", "uart2b"};
@@ -1219,6 +1223,7 @@ static const struct uniphier_pinmux_function ph1_ld6b_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c2),
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(nand),
+	UNIPHIER_PINMUX_FUNCTION(sd),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
 	UNIPHIER_PINMUX_FUNCTION(uart2),
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c b/drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c
index 96921e4..ec8e92d 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c
@@ -1031,6 +1031,11 @@ static const unsigned nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 					0, 0};
 static const unsigned nand_cs1_pins[] = {131, 132};
 static const unsigned nand_cs1_muxvals[] = {1, 1};
+static const unsigned sd_pins[] = {150, 151, 152, 153, 154, 155, 156, 157, 158};
+static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned sd1_pins[] = {319, 320, 321, 322, 323, 324, 325, 326,
+				    327};
+static const unsigned sd1_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned uart0_pins[] = {127, 128};
 static const unsigned uart0_muxvals[] = {0, 0};
 static const unsigned uart1_pins[] = {129, 130};
@@ -1140,6 +1145,8 @@ static const struct uniphier_pinctrl_group ph1_pro4_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c6),
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
+	UNIPHIER_PINCTRL_GROUP(sd),
+	UNIPHIER_PINCTRL_GROUP(sd1),
 	UNIPHIER_PINCTRL_GROUP(uart0),
 	UNIPHIER_PINCTRL_GROUP(uart1),
 	UNIPHIER_PINCTRL_GROUP(uart2),
@@ -1412,6 +1419,8 @@ static const char * const i2c2_groups[] = {"i2c2"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const i2c6_groups[] = {"i2c6"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
+static const char * const sd_groups[] = {"sd"};
+static const char * const sd1_groups[] = {"sd1"};
 static const char * const uart0_groups[] = {"uart0"};
 static const char * const uart1_groups[] = {"uart1"};
 static const char * const uart2_groups[] = {"uart2"};
@@ -1498,6 +1507,8 @@ static const struct uniphier_pinmux_function ph1_pro4_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(i2c6),
 	UNIPHIER_PINMUX_FUNCTION(nand),
+	UNIPHIER_PINMUX_FUNCTION(sd),
+	UNIPHIER_PINMUX_FUNCTION(sd1),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
 	UNIPHIER_PINMUX_FUNCTION(uart2),
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c b/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c
index 9af4559..e3d648e 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c
@@ -818,6 +818,8 @@ static const unsigned nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 					0, 0};
 static const unsigned nand_cs1_pins[] = {26, 27};
 static const unsigned nand_cs1_muxvals[] = {0, 0};
+static const unsigned sd_pins[] = {250, 251, 252, 253, 254, 255, 256, 257, 258};
+static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned uart0_pins[] = {47, 48};
 static const unsigned uart0_muxvals[] = {0, 0};
 static const unsigned uart0b_pins[] = {227, 228};
@@ -930,6 +932,7 @@ static const struct uniphier_pinctrl_group ph1_pro5_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c5b),
 	UNIPHIER_PINCTRL_GROUP(i2c5c),
 	UNIPHIER_PINCTRL_GROUP(i2c6),
+	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP(uart0),
 	UNIPHIER_PINCTRL_GROUP(uart0b),
 	UNIPHIER_PINCTRL_GROUP(uart1),
@@ -1209,6 +1212,7 @@ static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const i2c5_groups[] = {"i2c5", "i2c5b", "i2c5c"};
 static const char * const i2c6_groups[] = {"i2c6"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
+static const char * const sd_groups[] = {"sd"};
 static const char * const uart0_groups[] = {"uart0", "uart0b"};
 static const char * const uart1_groups[] = {"uart1"};
 static const char * const uart2_groups[] = {"uart2"};
@@ -1296,6 +1300,7 @@ static const struct uniphier_pinmux_function ph1_pro5_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c5),
 	UNIPHIER_PINMUX_FUNCTION(i2c6),
 	UNIPHIER_PINMUX_FUNCTION(nand),
+	UNIPHIER_PINMUX_FUNCTION(sd),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
 	UNIPHIER_PINMUX_FUNCTION(uart2),
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c b/drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c
index 2df8bbe..c3700a3 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c
@@ -450,6 +450,8 @@ static const unsigned nand_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 					0, 0};
 static const unsigned nand_cs1_pins[] = {22, 23};
 static const unsigned nand_cs1_muxvals[] = {0, 0};
+static const unsigned sd_pins[] = {32, 33, 34, 35, 36, 37, 38, 39, 40};
+static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned uart0_pins[] = {70, 71};
 static const unsigned uart0_muxvals[] = {3, 3};
 static const unsigned uart1_pins[] = {114, 115};
@@ -536,6 +538,7 @@ static const struct uniphier_pinctrl_group ph1_sld8_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c3),
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
+	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP(uart0),
 	UNIPHIER_PINCTRL_GROUP(uart1),
 	UNIPHIER_PINCTRL_GROUP(uart2),
@@ -684,6 +687,7 @@ static const char * const i2c1_groups[] = {"i2c1"};
 static const char * const i2c2_groups[] = {"i2c2"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
+static const char * const sd_groups[] = {"sd"};
 static const char * const uart0_groups[] = {"uart0"};
 static const char * const uart1_groups[] = {"uart1"};
 static const char * const uart2_groups[] = {"uart2"};
@@ -739,6 +743,7 @@ static const struct uniphier_pinmux_function ph1_sld8_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c2),
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(nand),
+	UNIPHIER_PINMUX_FUNCTION(sd),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
 	UNIPHIER_PINMUX_FUNCTION(uart2),
diff --git a/drivers/pinctrl/uniphier/pinctrl-proxstream2.c b/drivers/pinctrl/uniphier/pinctrl-proxstream2.c
index 3f036e2..bc00d75 100644
--- a/drivers/pinctrl/uniphier/pinctrl-proxstream2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-proxstream2.c
@@ -751,6 +751,8 @@ static const unsigned nand_muxvals[] = {8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
 					8, 8};
 static const unsigned nand_cs1_pins[] = {37, 38};
 static const unsigned nand_cs1_muxvals[] = {8, 8};
+static const unsigned sd_pins[] = {47, 48, 49, 50, 51, 52, 53, 54, 55};
+static const unsigned sd_muxvals[] = {8, 8, 8, 8, 8, 8, 8, 8, 8};
 static const unsigned uart0_pins[] = {217, 218};
 static const unsigned uart0_muxvals[] = {8, 8};
 static const unsigned uart0b_pins[] = {179, 180};
@@ -857,6 +859,7 @@ static const struct uniphier_pinctrl_group proxstream2_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c6),
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
+	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP(uart0),
 	UNIPHIER_PINCTRL_GROUP(uart0b),
 	UNIPHIER_PINCTRL_GROUP(uart1),
@@ -1128,6 +1131,7 @@ static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const i2c5_groups[] = {"i2c5"};
 static const char * const i2c6_groups[] = {"i2c6"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
+static const char * const sd_groups[] = {"sd"};
 static const char * const uart0_groups[] = {"uart0", "uart0b"};
 static const char * const uart1_groups[] = {"uart1"};
 static const char * const uart2_groups[] = {"uart2"};
@@ -1213,6 +1217,7 @@ static const struct uniphier_pinmux_function proxstream2_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c5),
 	UNIPHIER_PINMUX_FUNCTION(i2c6),
 	UNIPHIER_PINMUX_FUNCTION(nand),
+	UNIPHIER_PINMUX_FUNCTION(sd),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
 	UNIPHIER_PINMUX_FUNCTION(uart2),
-- 
1.9.1
