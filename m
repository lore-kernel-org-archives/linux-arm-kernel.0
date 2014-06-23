From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:24:59 +0900
Subject: [PATCH 3/8] ARM: shmobile: Move clock.h
In-Reply-To: <cover.1403487267.git.horms+renesas@verge.net.au>
References: <cover.1403487267.git.horms+renesas@verge.net.au>
Message-ID: <ad6ffa0b59dc2c81474d7642fa2188e25cce99d6.1403487267.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Change location of clock.h so it can be used as #include "clock.h"
instead of the old style #include <mach/clock.h>.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-genmai-reference.c  |  2 +-
 arch/arm/mach-shmobile/board-koelsch-reference.c |  2 +-
 arch/arm/mach-shmobile/board-lager-reference.c   |  2 +-
 arch/arm/mach-shmobile/clock-r8a73a4.c           |  2 +-
 arch/arm/mach-shmobile/clock-r8a7740.c           |  2 +-
 arch/arm/mach-shmobile/clock-r8a7778.c           |  2 +-
 arch/arm/mach-shmobile/clock-r8a7779.c           |  2 +-
 arch/arm/mach-shmobile/clock-r8a7790.c           |  2 +-
 arch/arm/mach-shmobile/clock-r8a7791.c           |  2 +-
 arch/arm/mach-shmobile/clock-sh7372.c            |  2 +-
 arch/arm/mach-shmobile/clock-sh73a0.c            |  2 +-
 arch/arm/mach-shmobile/clock.c                   |  4 +-
 arch/arm/mach-shmobile/clock.h                   | 56 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/clock.h      | 56 ------------------------
 14 files changed, 69 insertions(+), 69 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/clock.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/clock.h

diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index 2ff6ad6..c353585 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -20,11 +20,11 @@
 
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
-#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/r7s72100.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include "clock.h"
 
 /*
  * This is a really crude hack to provide clkdev support to platform
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index d322a16..4a6dd63 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -23,12 +23,12 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
-#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7791.h>
 #include <asm/mach/arch.h>
+#include "clock.h"
 
 /* DU */
 static struct rcar_du_encoder_data koelsch_du_encoders[] = {
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 749832e..1d198b0 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -22,12 +22,12 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
-#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
+#include "clock.h"
 
 /* DU */
 static struct rcar_du_encoder_data lager_du_encoders[] = {
diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index b5bc22c..857b142 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -22,8 +22,8 @@
 #include <linux/kernel.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
 #include <mach/common.h>
+#include "clock.h"
 
 #define CPG_BASE 0xe6150000
 #define CPG_LEN 0x270
diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 50931e3..6986527 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -22,9 +22,9 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/r8a7740.h>
+#include "clock.h"
 
 /*
  *        |  MDx  |  XTAL1/EXTAL1   |  System   | EXTALR |
diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 13f8f3a..017fa50 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -39,8 +39,8 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
 #include <mach/common.h>
+#include "clock.h"
 
 #define MSTPCR0		IOMEM(0xffc80030)
 #define MSTPCR1		IOMEM(0xffc80034)
diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index a13298b..eb7b131 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -23,8 +23,8 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
 #include <mach/common.h>
+#include "clock.h"
 
 /*
  *		MD1 = 1			MD1 = 0
diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 296a057..8c62446 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -22,9 +22,9 @@
 #include <linux/kernel.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/r8a7790.h>
+#include "clock.h"
 
 /*
  *   MD		EXTAL		PLL0	PLL1	PLL3
diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index e2fdfcc..20cad4a 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -23,9 +23,9 @@
 #include <linux/kernel.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/rcar-gen2.h>
+#include "clock.h"
 
 /*
  *   MD		EXTAL		PLL0	PLL1	PLL3
diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index d16d9ca..b19bc7e 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -21,8 +21,8 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
 #include <mach/common.h>
+#include "clock.h"
 
 /* SH7372 registers */
 #define FRQCRA		IOMEM(0xe6150000)
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 0d9cd1f..3956b95 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -22,8 +22,8 @@
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
 #include <asm/processor.h>
-#include <mach/clock.h>
 #include <mach/common.h>
+#include "clock.h"
 
 #define FRQCRA		IOMEM(0xe6150000)
 #define FRQCRB		IOMEM(0xe6150004)
diff --git a/arch/arm/mach-shmobile/clock.c b/arch/arm/mach-shmobile/clock.c
index e7232a0..2a58a78 100644
--- a/arch/arm/mach-shmobile/clock.c
+++ b/arch/arm/mach-shmobile/clock.c
@@ -25,7 +25,7 @@
 #ifdef CONFIG_COMMON_CLK
 #include <linux/clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
+#include "clock.h"
 
 void __init shmobile_clk_workaround(const struct clk_name *clks,
 				    int nr_clks, bool enable)
@@ -49,8 +49,8 @@ void __init shmobile_clk_workaround(const struct clk_name *clks,
 #else /* CONFIG_COMMON_CLK */
 #include <linux/sh_clk.h>
 #include <linux/export.h>
-#include <mach/clock.h>
 #include <mach/common.h>
+#include "clock.h"
 
 unsigned long shmobile_fixed_ratio_clk_recalc(struct clk *clk)
 {
diff --git a/arch/arm/mach-shmobile/clock.h b/arch/arm/mach-shmobile/clock.h
new file mode 100644
index 0000000..31b6417
--- /dev/null
+++ b/arch/arm/mach-shmobile/clock.h
@@ -0,0 +1,56 @@
+#ifndef CLOCK_H
+#define CLOCK_H
+
+#ifdef CONFIG_COMMON_CLK
+/* temporary clock configuration helper for platform devices */
+
+struct clk_name {
+	const char *clk;
+	const char *con_id;
+	const char *dev_id;
+};
+
+void shmobile_clk_workaround(const struct clk_name *clks, int nr_clks,
+			     bool enable);
+
+#else /* CONFIG_COMMON_CLK */
+/* legacy clock implementation */
+
+struct clk;
+unsigned long shmobile_fixed_ratio_clk_recalc(struct clk *clk);
+extern struct sh_clk_ops shmobile_fixed_ratio_clk_ops;
+
+/* clock ratio */
+struct clk_ratio {
+	int mul;
+	int div;
+};
+
+#define SH_CLK_RATIO(name, m, d)		\
+static struct clk_ratio name ##_ratio = {	\
+	.mul = m,				\
+	.div = d,				\
+}
+
+#define SH_FIXED_RATIO_CLKg(name, p, r)	\
+struct clk name = {			\
+	.parent	= &p,				\
+	.ops	= &shmobile_fixed_ratio_clk_ops,\
+	.priv	= &r ## _ratio,			\
+}
+
+#define SH_FIXED_RATIO_CLK(name, p, r)		\
+static SH_FIXED_RATIO_CLKg(name, p, r)
+
+#define SH_FIXED_RATIO_CLK_SET(name, p, m, d)	\
+	SH_CLK_RATIO(name, m, d);		\
+	SH_FIXED_RATIO_CLK(name, p, name)
+
+#define SH_CLK_SET_RATIO(p, m, d)	\
+do {			\
+	(p)->mul = m;	\
+	(p)->div = d;	\
+} while (0)
+
+#endif /* CONFIG_COMMON_CLK */
+#endif
diff --git a/arch/arm/mach-shmobile/include/mach/clock.h b/arch/arm/mach-shmobile/include/mach/clock.h
deleted file mode 100644
index 31b6417..0000000
--- a/arch/arm/mach-shmobile/include/mach/clock.h
+++ /dev/null
@@ -1,56 +0,0 @@
-#ifndef CLOCK_H
-#define CLOCK_H
-
-#ifdef CONFIG_COMMON_CLK
-/* temporary clock configuration helper for platform devices */
-
-struct clk_name {
-	const char *clk;
-	const char *con_id;
-	const char *dev_id;
-};
-
-void shmobile_clk_workaround(const struct clk_name *clks, int nr_clks,
-			     bool enable);
-
-#else /* CONFIG_COMMON_CLK */
-/* legacy clock implementation */
-
-struct clk;
-unsigned long shmobile_fixed_ratio_clk_recalc(struct clk *clk);
-extern struct sh_clk_ops shmobile_fixed_ratio_clk_ops;
-
-/* clock ratio */
-struct clk_ratio {
-	int mul;
-	int div;
-};
-
-#define SH_CLK_RATIO(name, m, d)		\
-static struct clk_ratio name ##_ratio = {	\
-	.mul = m,				\
-	.div = d,				\
-}
-
-#define SH_FIXED_RATIO_CLKg(name, p, r)	\
-struct clk name = {			\
-	.parent	= &p,				\
-	.ops	= &shmobile_fixed_ratio_clk_ops,\
-	.priv	= &r ## _ratio,			\
-}
-
-#define SH_FIXED_RATIO_CLK(name, p, r)		\
-static SH_FIXED_RATIO_CLKg(name, p, r)
-
-#define SH_FIXED_RATIO_CLK_SET(name, p, m, d)	\
-	SH_CLK_RATIO(name, m, d);		\
-	SH_FIXED_RATIO_CLK(name, p, name)
-
-#define SH_CLK_SET_RATIO(p, m, d)	\
-do {			\
-	(p)->mul = m;	\
-	(p)->div = d;	\
-} while (0)
-
-#endif /* CONFIG_COMMON_CLK */
-#endif
-- 
2.0.0.rc2
