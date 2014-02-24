From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 14:41:16 +0900
Subject: [PATCH 02/12] ARM: shmobile: Rework include path for sh7372
In-Reply-To: <20140224054058.1143.14096.sendpatchset@w520>
References: <20140224054058.1143.14096.sendpatchset@w520>
Message-ID: <20140224054116.1143.83938.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert sh7372 SoC code use of include files from 
the style <mach/something.h> to "something.h".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh7372.c |    4 ++--
 arch/arm/mach-shmobile/intc-sh7372.c  |    4 ++--
 arch/arm/mach-shmobile/pm-sh7372.c    |    6 +++---
 arch/arm/mach-shmobile/setup-sh7372.c |    8 ++++----
 4 files changed, 11 insertions(+), 11 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-sh7372.c
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2014-02-24 13:13:46.000000000 +0900
@@ -21,8 +21,8 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
-#include <mach/common.h>
+#include "clock.h"
+#include "common.h"
 
 /* SH7372 registers */
 #define FRQCRA		IOMEM(0xe6150000)
--- 0001/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2014-02-24 13:13:46.000000000 +0900
@@ -23,8 +23,8 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/sh_intc.h>
-#include <mach/intc.h>
-#include <mach/irqs.h>
+#include "intc.h"
+#include "irqs.h"
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
--- 0001/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2014-02-24 13:26:42.000000000 +0900
@@ -25,9 +25,9 @@
 #include <asm/io.h>
 #include <asm/tlbflush.h>
 #include <asm/suspend.h>
-#include <mach/common.h>
-#include <mach/sh7372.h>
-#include <mach/pm-rmobile.h>
+#include "common.h"
+#include "sh7372.h"
+#include "pm-rmobile.h"
 
 /* DBG */
 #define DBGREG1 IOMEM(0xe6100020)
--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2014-02-24 13:13:46.000000000 +0900
@@ -34,10 +34,10 @@
 #include <linux/pm_domain.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/sh_ipmmu.h>
-#include <mach/dma-register.h>
-#include <mach/irqs.h>
-#include <mach/sh7372.h>
-#include <mach/common.h>
+#include "dma-register.h"
+#include "irqs.h"
+#include "sh7372.h"
+#include "common.h"
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
