From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 14:41:44 +0900
Subject: [PATCH 05/12] ARM: shmobile: Rework include path for r8a7740
In-Reply-To: <20140224054058.1143.14096.sendpatchset@w520>
References: <20140224054058.1143.14096.sendpatchset@w520>
Message-ID: <20140224054144.1143.6577.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert r8a7740 SoC code use of include files from 
the style <mach/something.h> to "something.h".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r8a7740.c |    6 +++---
 arch/arm/mach-shmobile/pm-r8a7740.c    |    4 ++--
 arch/arm/mach-shmobile/setup-r8a7740.c |   10 +++++-----
 3 files changed, 10 insertions(+), 10 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-r8a7740.c
+++ work/arch/arm/mach-shmobile/clock-r8a7740.c	2014-02-24 13:31:41.000000000 +0900
@@ -22,9 +22,9 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
-#include <mach/common.h>
-#include <mach/r8a7740.h>
+#include "clock.h"
+#include "common.h"
+#include "r8a7740.h"
 
 /*
  *        |  MDx  |  XTAL1/EXTAL1   |  System   | EXTALR |
--- 0001/arch/arm/mach-shmobile/pm-r8a7740.c
+++ work/arch/arm/mach-shmobile/pm-r8a7740.c	2014-02-24 13:32:24.000000000 +0900
@@ -10,8 +10,8 @@
  */
 #include <linux/console.h>
 #include <linux/suspend.h>
-#include <mach/pm-rmobile.h>
-#include <mach/common.h>
+#include "pm-rmobile.h"
+#include "common.h"
 
 #ifdef CONFIG_PM
 static int r8a7740_pd_a4s_suspend(void)
--- 0001/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2014-02-24 13:31:18.000000000 +0900
@@ -31,11 +31,11 @@
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
 #include <linux/platform_data/sh_ipmmu.h>
-#include <mach/dma-register.h>
-#include <mach/r8a7740.h>
-#include <mach/pm-rmobile.h>
-#include <mach/common.h>
-#include <mach/irqs.h>
+#include "dma-register.h"
+#include "r8a7740.h"
+#include "pm-rmobile.h"
+#include "common.h"
+#include "irqs.h"
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
