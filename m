From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 14:42:13 +0900
Subject: [PATCH 08/12] ARM: shmobile: Rework include path for r8a7790
In-Reply-To: <20140224054058.1143.14096.sendpatchset@w520>
References: <20140224054058.1143.14096.sendpatchset@w520>
Message-ID: <20140224054213.1143.46444.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert r8a7790 SoC code use of include files from 
the style <mach/something.h> to "something.h".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r8a7790.c |    6 +++---
 arch/arm/mach-shmobile/pm-r8a7790.c    |    4 ++--
 arch/arm/mach-shmobile/setup-r8a7790.c |    8 ++++----
 arch/arm/mach-shmobile/smp-r8a7790.c   |    6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-r8a7790.c
+++ work/arch/arm/mach-shmobile/clock-r8a7790.c	2014-02-24 13:44:02.000000000 +0900
@@ -22,9 +22,9 @@
 #include <linux/kernel.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
-#include <mach/common.h>
-#include <mach/r8a7790.h>
+#include "clock.h"
+#include "common.h"
+#include "r8a7790.h"
 
 /*
  *   MD		EXTAL		PLL0	PLL1	PLL3
--- 0001/arch/arm/mach-shmobile/pm-r8a7790.c
+++ work/arch/arm/mach-shmobile/pm-r8a7790.c	2014-02-24 13:44:26.000000000 +0900
@@ -12,8 +12,8 @@
 
 #include <linux/kernel.h>
 #include <asm/io.h>
-#include <mach/pm-rcar.h>
-#include <mach/r8a7790.h>
+#include "pm-rcar.h"
+#include "r8a7790.h"
 
 /* SYSC */
 #define SYSCIER 0x0c
--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2014-02-24 13:43:31.000000000 +0900
@@ -26,10 +26,10 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
-#include <mach/common.h>
-#include <mach/dma-register.h>
-#include <mach/irqs.h>
-#include <mach/r8a7790.h>
+#include "common.h"
+#include "dma-register.h"
+#include "irqs.h"
+#include "r8a7790.h"
 #include <asm/mach/arch.h>
 
 /* Audio-DMAC */
--- 0001/arch/arm/mach-shmobile/smp-r8a7790.c
+++ work/arch/arm/mach-shmobile/smp-r8a7790.c	2014-02-24 13:46:10.000000000 +0900
@@ -18,9 +18,9 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <asm/smp_plat.h>
-#include <mach/common.h>
-#include <mach/pm-rcar.h>
-#include <mach/r8a7790.h>
+#include "common.h"
+#include "pm-rcar.h"
+#include "r8a7790.h"
 
 #define RST		0xe6160000
 #define CA15BAR		0x0020
