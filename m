From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 14:42:51 +0900
Subject: [PATCH 12/12] ARM: shmobile: Rework include path for common bits
In-Reply-To: <20140224054058.1143.14096.sendpatchset@w520>
References: <20140224054058.1143.14096.sendpatchset@w520>
Message-ID: <20140224054251.1143.39128.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert remaining shared mach-shmobile code use of include
files from the style <mach/something.h> to "something.h".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock.c           |    4 ++--
 arch/arm/mach-shmobile/console.c         |    2 +-
 arch/arm/mach-shmobile/platsmp-apmu.c    |    2 +-
 arch/arm/mach-shmobile/platsmp-scu.c     |    2 +-
 arch/arm/mach-shmobile/platsmp.c         |    2 +-
 arch/arm/mach-shmobile/pm-rcar.c         |    2 +-
 arch/arm/mach-shmobile/pm-rmobile.c      |    2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c |    4 ++--
 8 files changed, 10 insertions(+), 10 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock.c
+++ work/arch/arm/mach-shmobile/clock.c	2014-02-24 13:59:37.000000000 +0900
@@ -23,8 +23,8 @@
 #include <linux/init.h>
 #include <linux/sh_clk.h>
 #include <linux/export.h>
-#include <mach/clock.h>
-#include <mach/common.h>
+#include "clock.h"
+#include "common.h"
 
 unsigned long shmobile_fixed_ratio_clk_recalc(struct clk *clk)
 {
--- 0001/arch/arm/mach-shmobile/console.c
+++ work/arch/arm/mach-shmobile/console.c	2014-02-24 13:59:57.000000000 +0900
@@ -19,7 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <mach/common.h>
+#include "common.h"
 #include <asm/mach/map.h>
 
 void __init shmobile_setup_console(void)
--- 0001/arch/arm/mach-shmobile/platsmp-apmu.c
+++ work/arch/arm/mach-shmobile/platsmp-apmu.c	2014-02-24 14:00:18.000000000 +0900
@@ -16,7 +16,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
-#include <mach/common.h>
+#include "common.h"
 
 static struct {
 	void __iomem *iomem;
--- 0001/arch/arm/mach-shmobile/platsmp-scu.c
+++ work/arch/arm/mach-shmobile/platsmp-scu.c	2014-02-24 14:00:26.000000000 +0900
@@ -15,7 +15,7 @@
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
-#include <mach/common.h>
+#include "common.h"
 
 static int shmobile_smp_scu_notifier_call(struct notifier_block *nfb,
 					  unsigned long action, void *hcpu)
--- 0001/arch/arm/mach-shmobile/platsmp.c
+++ work/arch/arm/mach-shmobile/platsmp.c	2014-02-24 14:00:07.000000000 +0900
@@ -13,7 +13,7 @@
 #include <linux/init.h>
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
-#include <mach/common.h>
+#include "common.h"
 
 extern unsigned long shmobile_smp_fn[];
 extern unsigned long shmobile_smp_arg[];
--- 0001/arch/arm/mach-shmobile/pm-rcar.c
+++ work/arch/arm/mach-shmobile/pm-rcar.c	2014-02-24 14:00:42.000000000 +0900
@@ -13,7 +13,7 @@
 #include <linux/mm.h>
 #include <linux/spinlock.h>
 #include <asm/io.h>
-#include <mach/pm-rcar.h>
+#include "pm-rcar.h"
 
 static void __iomem *rcar_sysc_base;
 
--- 0001/arch/arm/mach-shmobile/pm-rmobile.c
+++ work/arch/arm/mach-shmobile/pm-rmobile.c	2014-02-24 14:00:53.000000000 +0900
@@ -17,7 +17,7 @@
 #include <linux/pm.h>
 #include <linux/pm_clock.h>
 #include <asm/io.h>
-#include <mach/pm-rmobile.h>
+#include "pm-rmobile.h"
 
 /* SYSC */
 #define SPDCR		IOMEM(0xe6180008)
--- 0001/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ work/arch/arm/mach-shmobile/setup-rcar-gen2.c	2014-02-24 14:01:09.000000000 +0900
@@ -22,8 +22,8 @@
 #include <linux/clocksource.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <mach/common.h>
-#include <mach/rcar-gen2.h>
+#include "common.h"
+#include "rcar-gen2.h"
 #include <asm/mach/arch.h>
 
 #define MODEMR 0xe6160060
