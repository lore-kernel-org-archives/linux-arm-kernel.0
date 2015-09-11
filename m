From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 11 Sep 2015 18:33:29 +0900
Subject: [PATCH v2 2/2] pinctrl: uniphier: add SD card pinmux settings
In-Reply-To: <1441964010-6885-1-git-send-email-yamada.masahiro@socionext.com>
References: <1441964010-6885-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1441964010-6885-3-git-send-email-yamada.masahiro@socionext.com>
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
 drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c    |  4 ++++
 drivers/pinctrl/uniphier/pinctrl-proxstream2.c |  5 +++++
 6 files changed, 35 insertions(+)

diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c b/drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c
index 7beb87e..9e31ee0 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c
@@ -555,6 +555,8 @@ static const unsigned usb2_pins[] = {155, 156};
 static const unsigned usb2_muxvals[] = {4, 4};
 static const unsigned usb2b_pins[] = {67, 68};
 static const unsigned usb2b_muxvals[] = {23, 23};
+static const unsigned sd_pins[] = {44, 45, 46, 47, 48, 49, 50, 51, 52};
+static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned port_range0_pins[] = {
 	135, 136, 137, 138, 139, 140, 141, 142,		/* PORT0x */
 	143, 144, 145, 146, 147, 148, 149, 150,		/* PORT1x */
@@ -628,6 +630,7 @@ static const struct uniphier_pinctrl_group ph1_ld4_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(usb1),
 	UNIPHIER_PINCTRL_GROUP(usb2),
 	UNIPHIER_PINCTRL_GROUP(usb2b),
+	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_PORT(port_range0),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_PORT(port_range1),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_IRQ(xirq_range0),
@@ -783,6 +786,7 @@ static const char * const uart3_groups[] = {"uart3"};
 static const char * const usb0_groups[] = {"usb0"};
 static const char * const usb1_groups[] = {"usb1"};
 static const char * const usb2_groups[] = {"usb2", "usb2b"};
+static const char * const sd_groups[] = {"sd"};
 static const char * const port_groups[] = {
 	"port00",  "port01",  "port02",  "port03",
 	"port04",  "port05",  "port06",  "port07",
@@ -838,6 +842,7 @@ static const struct uniphier_pinmux_function ph1_ld4_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(usb0),
 	UNIPHIER_PINMUX_FUNCTION(usb1),
 	UNIPHIER_PINMUX_FUNCTION(usb2),
+	UNIPHIER_PINMUX_FUNCTION(sd),
 	UNIPHIER_PINMUX_FUNCTION(port),
 	UNIPHIER_PINMUX_FUNCTION(xirq),
 };
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c
index 9720e697..e00c067 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c
@@ -781,6 +781,8 @@ static const unsigned usb2_pins[] = {60, 61};
 static const unsigned usb2_muxvals[] = {0, 0};
 static const unsigned usb3_pins[] = {62, 63};
 static const unsigned usb3_muxvals[] = {0, 0};
+static const unsigned sd_pins[] = {47, 48, 49, 50, 51, 52, 53, 54, 55};
+static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned port_range0_pins[] = {
 	127, 128, 129, 130, 131, 132, 133, 134,		/* PORT0x */
 	135, 136, 137, 138, 139, 140, 141, 142,		/* PORT1x */
@@ -876,6 +878,7 @@ static const struct uniphier_pinctrl_group ph1_ld6b_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(usb1),
 	UNIPHIER_PINCTRL_GROUP(usb2),
 	UNIPHIER_PINCTRL_GROUP(usb3),
+	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_PORT(port_range0),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_PORT(port_range1),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_IRQ(xirq),
@@ -1143,6 +1146,7 @@ static const char * const usb0_groups[] = {"usb0"};
 static const char * const usb1_groups[] = {"usb1"};
 static const char * const usb2_groups[] = {"usb2"};
 static const char * const usb3_groups[] = {"usb3"};
+static const char * const sd_groups[] = {"sd"};
 static const char * const port_groups[] = {
 	"port00",  "port01",  "port02",  "port03",
 	"port04",  "port05",  "port06",  "port07",
@@ -1226,6 +1230,7 @@ static const struct uniphier_pinmux_function ph1_ld6b_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(usb1),
 	UNIPHIER_PINMUX_FUNCTION(usb2),
 	UNIPHIER_PINMUX_FUNCTION(usb3),
+	UNIPHIER_PINMUX_FUNCTION(sd),
 	UNIPHIER_PINMUX_FUNCTION(port),
 	UNIPHIER_PINMUX_FUNCTION(xirq),
 };
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c b/drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c
index 96921e4..8b83db5 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c
@@ -1047,6 +1047,11 @@ static const unsigned usb2_pins[] = {184, 185};
 static const unsigned usb2_muxvals[] = {0, 0};
 static const unsigned usb3_pins[] = {186, 187};
 static const unsigned usb3_muxvals[] = {0, 0};
+static const unsigned sd_pins[] = {150, 151, 152, 153, 154, 155, 156, 157, 158};
+static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned sd1_pins[] = {319, 320, 321, 322, 323, 324, 325, 326,
+				    327};
+static const unsigned sd1_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned port_range0_pins[] = {
 	300, 301, 302, 303, 304, 305, 306, 307,		/* PORT0x */
 	308, 309, 310, 311, 312, 313, 314, 315,		/* PORT1x */
@@ -1148,6 +1153,8 @@ static const struct uniphier_pinctrl_group ph1_pro4_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(usb1),
 	UNIPHIER_PINCTRL_GROUP(usb2),
 	UNIPHIER_PINCTRL_GROUP(usb3),
+	UNIPHIER_PINCTRL_GROUP(sd),
+	UNIPHIER_PINCTRL_GROUP(sd1),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_PORT(port_range0),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_PORT(port_range1),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_IRQ(xirq),
@@ -1420,6 +1427,8 @@ static const char * const usb0_groups[] = {"usb0"};
 static const char * const usb1_groups[] = {"usb1"};
 static const char * const usb2_groups[] = {"usb2"};
 static const char * const usb3_groups[] = {"usb3"};
+static const char * const sd_groups[] = {"sd"};
+static const char * const sd1_groups[] = {"sd1"};
 static const char * const port_groups[] = {
 	"port00",  "port01",  "port02",  "port03",
 	"port04",  "port05",  "port06",  "port07",
@@ -1506,6 +1515,8 @@ static const struct uniphier_pinmux_function ph1_pro4_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(usb1),
 	UNIPHIER_PINMUX_FUNCTION(usb2),
 	UNIPHIER_PINMUX_FUNCTION(usb3),
+	UNIPHIER_PINMUX_FUNCTION(sd),
+	UNIPHIER_PINMUX_FUNCTION(sd1),
 	UNIPHIER_PINMUX_FUNCTION(port),
 	UNIPHIER_PINMUX_FUNCTION(xirq),
 };
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c b/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c
index 9af4559..a34dcaa 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c
@@ -834,6 +834,8 @@ static const unsigned usb1_pins[] = {126, 127};
 static const unsigned usb1_muxvals[] = {0, 0};
 static const unsigned usb2_pins[] = {128, 129};
 static const unsigned usb2_muxvals[] = {0, 0};
+static const unsigned sd_pins[] = {250, 251, 252, 253, 254, 255, 256, 257, 258};
+static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned port_range0_pins[] = {
 	89, 90, 91, 92, 93, 94, 95, 96,			/* PORT0x */
 	97, 98, 99, 100, 101, 102, 103, 104,		/* PORT1x */
@@ -938,6 +940,7 @@ static const struct uniphier_pinctrl_group ph1_pro5_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(usb0),
 	UNIPHIER_PINCTRL_GROUP(usb1),
 	UNIPHIER_PINCTRL_GROUP(usb2),
+	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_PORT(port_range0),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_PORT(port_range1),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_IRQ(xirq),
@@ -1216,6 +1219,7 @@ static const char * const uart3_groups[] = {"uart3"};
 static const char * const usb0_groups[] = {"usb0"};
 static const char * const usb1_groups[] = {"usb1"};
 static const char * const usb2_groups[] = {"usb2"};
+static const char * const sd_groups[] = {"sd"};
 static const char * const port_groups[] = {
 	"port00",  "port01",  "port02",  "port03",
 	"port04",  "port05",  "port06",  "port07",
@@ -1303,6 +1307,7 @@ static const struct uniphier_pinmux_function ph1_pro5_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(usb0),
 	UNIPHIER_PINMUX_FUNCTION(usb1),
 	UNIPHIER_PINMUX_FUNCTION(usb2),
+	UNIPHIER_PINMUX_FUNCTION(sd),
 	UNIPHIER_PINMUX_FUNCTION(port),
 	UNIPHIER_PINMUX_FUNCTION(xirq),
 };
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c b/drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c
index 2df8bbe..3b515ee 100644
--- a/drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c
@@ -464,6 +464,8 @@ static const unsigned usb1_pins[] = {43, 44};
 static const unsigned usb1_muxvals[] = {0, 0};
 static const unsigned usb2_pins[] = {114, 115};
 static const unsigned usb2_muxvals[] = {1, 1};
+static const unsigned sd_pins[] = {32, 33, 34, 35, 36, 37, 38, 39, 40};
+static const unsigned sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned port_range0_pins[] = {
 	0, 1, 2, 3, 4, 5, 6, 7,				/* PORT0x */
 	8, 9, 10, 11, 12, 13, 14, 15,			/* PORT1x */
@@ -543,6 +545,7 @@ static const struct uniphier_pinctrl_group ph1_sld8_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(usb0),
 	UNIPHIER_PINCTRL_GROUP(usb1),
 	UNIPHIER_PINCTRL_GROUP(usb2),
+	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_PORT(port_range0),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_PORT(port_range1),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_PORT(port_range2),
@@ -691,6 +694,7 @@ static const char * const uart3_groups[] = {"uart3"};
 static const char * const usb0_groups[] = {"usb0"};
 static const char * const usb1_groups[] = {"usb1"};
 static const char * const usb2_groups[] = {"usb2"};
+static const char * const sd_groups[] = {"sd"};
 static const char * const port_groups[] = {
 	"port00",  "port01",  "port02",  "port03",
 	"port04",  "port05",  "port06",  "port07",
diff --git a/drivers/pinctrl/uniphier/pinctrl-proxstream2.c b/drivers/pinctrl/uniphier/pinctrl-proxstream2.c
index 3f036e2..41c77fe 100644
--- a/drivers/pinctrl/uniphier/pinctrl-proxstream2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-proxstream2.c
@@ -771,6 +771,8 @@ static const unsigned usb2_pins[] = {60, 61};
 static const unsigned usb2_muxvals[] = {8, 8};
 static const unsigned usb3_pins[] = {62, 63};
 static const unsigned usb3_muxvals[] = {8, 8};
+static const unsigned sd_pins[] = {47, 48, 49, 50, 51, 52, 53, 54, 55};
+static const unsigned sd_muxvals[] = {8, 8, 8, 8, 8, 8, 8, 8, 8};
 static const unsigned port_range0_pins[] = {
 	127, 128, 129, 130, 131, 132, 133, 134,		/* PORT0x */
 	135, 136, 137, 138, 139, 140, 141, 142,		/* PORT1x */
@@ -867,6 +869,7 @@ static const struct uniphier_pinctrl_group proxstream2_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(usb1),
 	UNIPHIER_PINCTRL_GROUP(usb2),
 	UNIPHIER_PINCTRL_GROUP(usb3),
+	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_PORT(port_range0),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_PORT(port_range1),
 	UNIPHIER_PINCTRL_GROUP_GPIO_RANGE_IRQ(xirq),
@@ -1136,6 +1139,7 @@ static const char * const usb0_groups[] = {"usb0"};
 static const char * const usb1_groups[] = {"usb1"};
 static const char * const usb2_groups[] = {"usb2"};
 static const char * const usb3_groups[] = {"usb3"};
+static const char * const sd_groups[] = {"sd"};
 static const char * const port_groups[] = {
 	"port00",  "port01",  "port02",  "port03",
 	"port04",  "port05",  "port06",  "port07",
@@ -1221,6 +1225,7 @@ static const struct uniphier_pinmux_function proxstream2_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(usb1),
 	UNIPHIER_PINMUX_FUNCTION(usb2),
 	UNIPHIER_PINMUX_FUNCTION(usb3),
+	UNIPHIER_PINMUX_FUNCTION(sd),
 	UNIPHIER_PINMUX_FUNCTION(port),
 	UNIPHIER_PINMUX_FUNCTION(xirq),
 };
-- 
1.9.1
