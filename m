From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Jan 2017 10:51:51 -0800
Subject: [PATCH] ARM: OMAP2+: Remove duplicate definition of omap_test_timeout
Message-ID: <20170120185151.1630-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have the same defined already in common.h.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/cm2xxx.c                |  1 +
 arch/arm/mach-omap2/cm33xx.c                |  1 +
 arch/arm/mach-omap2/cm3xxx.c                |  1 +
 arch/arm/mach-omap2/cminst44xx.c            |  1 +
 arch/arm/mach-omap2/powerdomains3xxx_data.c |  1 +
 arch/arm/mach-omap2/prcm-common.h           | 22 ----------------------
 arch/arm/mach-omap2/prm2xxx_3xxx.c          |  1 +
 arch/arm/mach-omap2/prm33xx.c               |  1 +
 8 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -18,6 +18,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include "common.h"
 #include "prm2xxx.h"
 #include "cm.h"
 #include "cm2xxx.h"
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include "common.h"
 #include "clockdomain.h"
 #include "cm.h"
 #include "cm33xx.h"
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -18,6 +18,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include "common.h"
 #include "prm2xxx_3xxx.h"
 #include "cm.h"
 #include "cm3xxx.h"
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include "common.h"
 #include "clockdomain.h"
 #include "cm.h"
 #include "cm1_44xx.h"
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/bug.h>
+#include <linux/delay.h>
 
 #include "soc.h"
 #include "powerdomain.h"
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -434,28 +434,6 @@
 #define MAX_IOPAD_LATCH_TIME			100
 # ifndef __ASSEMBLER__
 
-#include <linux/delay.h>
-
-/**
- * omap_test_timeout - busy-loop, testing a condition
- * @cond: condition to test until it evaluates to true
- * @timeout: maximum number of microseconds in the timeout
- * @index: loop index (integer)
- *
- * Loop waiting for @cond to become true or until at least @timeout
- * microseconds have passed.  To use, define some integer @index in the
- * calling code.  After running, if @index == @timeout, then the loop has
- * timed out.
- */
-#define omap_test_timeout(cond, timeout, index)			\
-({								\
-	for (index = 0; index < timeout; index++) {		\
-		if (cond)					\
-			break;					\
-		udelay(1);					\
-	}							\
-})
-
 /**
  * struct omap_prcm_irq - describes a PRCM interrupt bit
  * @name: a short name describing the interrupt type, e.g. "wkup" or "io"
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include "common.h"
 #include "powerdomain.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include "common.h"
 #include "powerdomain.h"
 #include "prm33xx.h"
 #include "prm-regbits-33xx.h"
-- 
2.11.0
