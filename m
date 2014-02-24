From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 14:42:03 +0900
Subject: [PATCH 07/12] ARM: shmobile: Rework include path for r8a7779
In-Reply-To: <20140224054058.1143.14096.sendpatchset@w520>
References: <20140224054058.1143.14096.sendpatchset@w520>
Message-ID: <20140224054203.1143.41482.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert r8a7779 SoC code use of include files from 
the style <mach/something.h> to "something.h".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r8a7779.c |    4 ++--
 arch/arm/mach-shmobile/pm-r8a7779.c    |    6 +++---
 arch/arm/mach-shmobile/setup-r8a7779.c |    6 +++---
 arch/arm/mach-shmobile/smp-r8a7779.c   |    6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-r8a7779.c
+++ work/arch/arm/mach-shmobile/clock-r8a7779.c	2014-02-24 13:40:01.000000000 +0900
@@ -23,8 +23,8 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
-#include <mach/common.h>
+#include "clock.h"
+#include "common.h"
 
 /*
  *		MD1 = 1			MD1 = 0
--- 0001/arch/arm/mach-shmobile/pm-r8a7779.c
+++ work/arch/arm/mach-shmobile/pm-r8a7779.c	2014-02-24 13:40:40.000000000 +0900
@@ -19,9 +19,9 @@
 #include <linux/interrupt.h>
 #include <linux/console.h>
 #include <asm/io.h>
-#include <mach/common.h>
-#include <mach/pm-rcar.h>
-#include <mach/r8a7779.h>
+#include "common.h"
+#include "pm-rcar.h"
+#include "r8a7779.h"
 
 /* SYSC */
 #define SYSCIER 0x0c
--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2014-02-24 13:40:19.000000000 +0900
@@ -40,9 +40,9 @@
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/pm_runtime.h>
-#include <mach/irqs.h>
-#include <mach/r8a7779.h>
-#include <mach/common.h>
+#include "irqs.h"
+#include "r8a7779.h"
+#include "common.h"
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
--- 0001/arch/arm/mach-shmobile/smp-r8a7779.c
+++ work/arch/arm/mach-shmobile/smp-r8a7779.c	2014-02-24 13:41:01.000000000 +0900
@@ -23,9 +23,9 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-#include <mach/common.h>
-#include <mach/pm-rcar.h>
-#include <mach/r8a7779.h>
+#include "common.h"
+#include "pm-rcar.h"
+#include "r8a7779.h"
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
