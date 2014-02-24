From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 14:41:25 +0900
Subject: [PATCH 03/12] ARM: shmobile: Rework include path for sh73a0
In-Reply-To: <20140224054058.1143.14096.sendpatchset@w520>
References: <20140224054058.1143.14096.sendpatchset@w520>
Message-ID: <20140224054125.1143.91926.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert sh73a0 SoC code use of include files from 
the style <mach/something.h> to "something.h".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh73a0.c |    4 ++--
 arch/arm/mach-shmobile/intc-sh73a0.c  |    6 +++---
 arch/arm/mach-shmobile/pm-sh73a0.c    |    2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c |    8 ++++----
 arch/arm/mach-shmobile/smp-sh73a0.c   |    4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2014-02-24 13:20:15.000000000 +0900
@@ -22,8 +22,8 @@
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
 #include <asm/processor.h>
-#include <mach/clock.h>
-#include <mach/common.h>
+#include "clock.h"
+#include "common.h"
 
 #define FRQCRA		IOMEM(0xe6150000)
 #define FRQCRB		IOMEM(0xe6150004)
--- 0001/arch/arm/mach-shmobile/intc-sh73a0.c
+++ work/arch/arm/mach-shmobile/intc-sh73a0.c	2014-02-24 13:21:27.000000000 +0900
@@ -25,9 +25,9 @@
 #include <linux/sh_intc.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
-#include <mach/intc.h>
-#include <mach/irqs.h>
-#include <mach/sh73a0.h>
+#include "intc.h"
+#include "irqs.h"
+#include "sh73a0.h"
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
--- 0001/arch/arm/mach-shmobile/pm-sh73a0.c
+++ work/arch/arm/mach-shmobile/pm-sh73a0.c	2014-02-24 13:23:21.000000000 +0900
@@ -9,7 +9,7 @@
  */
 
 #include <linux/suspend.h>
-#include <mach/common.h>
+#include "common.h"
 
 #ifdef CONFIG_SUSPEND
 static int sh73a0_enter_suspend(suspend_state_t suspend_state)
--- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2014-02-24 13:20:41.000000000 +0900
@@ -33,10 +33,10 @@
 #include <linux/sh_timer.h>
 #include <linux/platform_data/sh_ipmmu.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
-#include <mach/dma-register.h>
-#include <mach/irqs.h>
-#include <mach/sh73a0.h>
-#include <mach/common.h>
+#include "dma-register.h"
+#include "irqs.h"
+#include "sh73a0.h"
+#include "common.h"
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
--- 0001/arch/arm/mach-shmobile/smp-sh73a0.c
+++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2014-02-24 13:21:54.000000000 +0900
@@ -22,8 +22,8 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-#include <mach/common.h>
-#include <mach/sh73a0.h>
+#include "common.h"
+#include "sh73a0.h"
 #include <asm/smp_plat.h>
 #include <asm/smp_twd.h>
 
