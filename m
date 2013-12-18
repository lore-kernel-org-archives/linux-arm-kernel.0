From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 18 Dec 2013 22:31:57 +0100
Subject: [PATCH V2 1/5] pinctrl: r7s72100: add riic groups
In-Reply-To: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1387402321-21866-2-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Tested RIIC2 on a genmai board. Other riic groups are untested but seem
trivial enough to be added.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Magnus Damm <damm@opensource.se>
---

V2: keep sorting alphabetical

Note: With the current PFC driver as posted by Magnus, it needs another patch
to work. Yet, I think this is a seperate PFC issue which needs to be sorted out
seperately and shouldn't affect these declarations. I'll add the needed patch
as a response to this mail.

 drivers/pinctrl/sh-pfc/pfc-r7s72100.c | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r7s72100.c b/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
index a662876..7ee0442 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
@@ -117,6 +117,27 @@ static const unsigned int __RZ_STR(pfx, hw, bank, pin, _mux)[] = {	\
 #define RZ_GROUPS(pfx, hw, bank, pin, fn) \
 	__RZ_GROUPS(pfx##_##hw##_p##bank##_##pin),
 
+#define RIIC0(fn)			\
+	fn(riic0, scl, 1, 0, 1)		\
+	fn(riic0, sda, 1, 1, 1)
+
+#define RIIC1(fn)			\
+	fn(riic1, scl, 1, 2, 1)		\
+	fn(riic1, sda, 1, 3, 1)
+
+#define RIIC2(fn)			\
+	fn(riic2, scl, 1, 4, 1)		\
+	fn(riic2, sda, 1, 5, 1)
+
+#define RIIC3(fn)			\
+	fn(riic3, scl, 1, 6, 1)		\
+	fn(riic3, sda, 1, 7, 1)
+
+RIIC0(RZ_PIN_AND_MUX)
+RIIC1(RZ_PIN_AND_MUX)
+RIIC2(RZ_PIN_AND_MUX)
+RIIC3(RZ_PIN_AND_MUX)
+
 #define SCIF0(fn)			\
 	fn(scif0, clk, 2, 13, 6)	\
 	fn(scif0, txd, 2, 14, 6)	\
@@ -230,6 +251,10 @@ SCIF6(RZ_PIN_AND_MUX)
 SCIF7(RZ_PIN_AND_MUX)
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	RIIC0(RZ_PMX_GROUP)
+	RIIC1(RZ_PMX_GROUP)
+	RIIC2(RZ_PMX_GROUP)
+	RIIC3(RZ_PMX_GROUP)
 	SCIF0(RZ_PMX_GROUP)
 	SCIF1(RZ_PMX_GROUP)
 	SCIF2(RZ_PMX_GROUP)
@@ -240,6 +265,22 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SCIF7(RZ_PMX_GROUP)
 };
 
+static const char * const riic0_groups[] = {
+	RIIC0(RZ_GROUPS)
+};
+
+static const char * const riic1_groups[] = {
+	RIIC1(RZ_GROUPS)
+};
+
+static const char * const riic2_groups[] = {
+	RIIC2(RZ_GROUPS)
+};
+
+static const char * const riic3_groups[] = {
+	RIIC3(RZ_GROUPS)
+};
+
 static const char * const scif0_groups[] = {
 	SCIF0(RZ_GROUPS)
 };
@@ -273,6 +314,10 @@ static const char * const scif7_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(riic0),
+	SH_PFC_FUNCTION(riic1),
+	SH_PFC_FUNCTION(riic2),
+	SH_PFC_FUNCTION(riic3),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
 	SH_PFC_FUNCTION(scif2),
-- 
1.8.4.2
