From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 11:48:39 +0100
Subject: [PATCH V3 1/5] pinctrl: sh-pfc: r7s72100: Add RSPI support
In-Reply-To: <1389523723-2288-1-git-send-email-geert@linux-m68k.org>
References: <1389523723-2288-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1389523723-2288-2-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
V2:
  - No changes
V3:
  - No changes

 drivers/pinctrl/sh-pfc/pfc-r7s72100.c |   94 +++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r7s72100.c b/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
index 267677c683c5..5e0f03c14fcc 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
@@ -138,6 +138,70 @@ RIIC1(RZ_PIN_AND_MUX)
 RIIC2(RZ_PIN_AND_MUX)
 RIIC3(RZ_PIN_AND_MUX)
 
+#define RSPI0(fn)			\
+	fn(rspi0, rspck,  2, 12, 2)	\
+	fn(rspi0, ssl0,   2, 13, 2)	\
+	fn(rspi0, mosi,   2, 14, 2)	\
+	fn(rspi0, miso,   2, 15, 2)	\
+	fn(rspi0, rspck,  7, 15, 2)	\
+	fn(rspi0, ssl0,   8,  0, 2)	\
+	fn(rspi0, mosi,   8,  1, 2)	\
+	fn(rspi0, miso,   8,  2, 2)	\
+	fn(rspi0, rspck, 10, 12, 4)	\
+	fn(rspi0, ssl0,  10, 13, 4)	\
+	fn(rspi0, mosi,  10, 14, 4)	\
+	fn(rspi0, miso,  10, 15, 4)	\
+
+#define RSPI1(fn)			\
+	fn(rspi1, rspck,  4,  4, 2)	\
+	fn(rspi1, ssl0,   4,  5, 2)	\
+	fn(rspi1, mosi,   4,  6, 2)	\
+	fn(rspi1, miso,   4,  7, 2)	\
+	fn(rspi1, rspck,  6,  4, 7)	\
+	fn(rspi1, ssl0,   6,  5, 7)	\
+	fn(rspi1, mosi,   6,  6, 7)	\
+	fn(rspi1, miso,   6,  7, 7)	\
+	fn(rspi1, rspck, 11, 12, 2)	\
+	fn(rspi1, ssl0,  11, 13, 2)	\
+	fn(rspi1, mosi,  11, 14, 2)	\
+	fn(rspi1, miso,  11, 15, 2)	\
+
+#define RSPI2(fn)			\
+	fn(rspi2, rspck,  8,  3, 3)	\
+	fn(rspi2, ssl0,   8,  4, 3)	\
+	fn(rspi2, mosi,   8,  5, 3)	\
+	fn(rspi2, miso,   8,  6, 3)	\
+	fn(rspi2, rspck,  8, 14, 5)	\
+	fn(rspi2, ssl0,   8, 15, 5)	\
+	fn(rspi2, mosi,   9,  0, 5)	\
+	fn(rspi2, miso,   9,  1, 5)	\
+
+#define RSPI3(fn)			\
+	fn(rspi3, rspck,  3,  0, 8)	\
+	fn(rspi3, ssl0,   3,  1, 8)	\
+	fn(rspi3, mosi,   3,  2, 8)	\
+	fn(rspi3, miso,   3,  3, 8)	\
+	fn(rspi3, rspck,  5,  0, 8)	\
+	fn(rspi3, ssl0,   5,  1, 8)	\
+	fn(rspi3, mosi,   5,  2, 8)	\
+	fn(rspi3, miso,   5,  3, 8)	\
+
+#define RSPI4(fn)			\
+	fn(rspi4, rspck,  2,  8, 8)	\
+	fn(rspi4, ssl0,   2,  9, 8)	\
+	fn(rspi4, mosi,   2, 10, 8)	\
+	fn(rspi4, miso,   2, 11, 8)	\
+	fn(rspi4, rspck,  4,  0, 7)	\
+	fn(rspi4, ssl0,   4,  1, 7)	\
+	fn(rspi4, mosi,   4,  2, 7)	\
+	fn(rspi4, miso,   4,  3, 7)	\
+
+RSPI0(RZ_PIN_AND_MUX)
+RSPI1(RZ_PIN_AND_MUX)
+RSPI2(RZ_PIN_AND_MUX)
+RSPI3(RZ_PIN_AND_MUX)
+RSPI4(RZ_PIN_AND_MUX)
+
 #define SCIF0(fn)			\
 	fn(scif0, clk, 2, 13, 6)	\
 	fn(scif0, txd, 2, 14, 6)	\
@@ -312,6 +376,11 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	RIIC1(RZ_PMX_GROUP)
 	RIIC2(RZ_PMX_GROUP)
 	RIIC3(RZ_PMX_GROUP)
+	RSPI0(RZ_PMX_GROUP)
+	RSPI1(RZ_PMX_GROUP)
+	RSPI2(RZ_PMX_GROUP)
+	RSPI3(RZ_PMX_GROUP)
+	RSPI4(RZ_PMX_GROUP)
 	SCIF0(RZ_PMX_GROUP)
 	SCIF1(RZ_PMX_GROUP)
 	SCIF2(RZ_PMX_GROUP)
@@ -339,6 +408,26 @@ static const char * const riic3_groups[] = {
 	RIIC3(RZ_GROUPS)
 };
 
+static const char * const rspi0_groups[] = {
+	RSPI0(RZ_GROUPS)
+};
+
+static const char * const rspi1_groups[] = {
+	RSPI1(RZ_GROUPS)
+};
+
+static const char * const rspi2_groups[] = {
+	RSPI2(RZ_GROUPS)
+};
+
+static const char * const rspi3_groups[] = {
+	RSPI3(RZ_GROUPS)
+};
+
+static const char * const rspi4_groups[] = {
+	RSPI4(RZ_GROUPS)
+};
+
 static const char * const scif0_groups[] = {
 	SCIF0(RZ_GROUPS)
 };
@@ -380,6 +469,11 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(riic1),
 	SH_PFC_FUNCTION(riic2),
 	SH_PFC_FUNCTION(riic3),
+	SH_PFC_FUNCTION(rspi0),
+	SH_PFC_FUNCTION(rspi1),
+	SH_PFC_FUNCTION(rspi2),
+	SH_PFC_FUNCTION(rspi3),
+	SH_PFC_FUNCTION(rspi4),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
 	SH_PFC_FUNCTION(scif2),
-- 
1.7.9.5
