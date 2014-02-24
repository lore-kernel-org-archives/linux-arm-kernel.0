From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 14:42:23 +0900
Subject: [PATCH 09/12] ARM: shmobile: Rework include path for r8a7791
In-Reply-To: <20140224054058.1143.14096.sendpatchset@w520>
References: <20140224054058.1143.14096.sendpatchset@w520>
Message-ID: <20140224054223.1143.82115.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert r8a7791 SoC code use of include files from 
the style <mach/something.h> to "something.h".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r8a7791.c |    4 ++--
 arch/arm/mach-shmobile/setup-r8a7791.c |    8 ++++----
 arch/arm/mach-shmobile/smp-r8a7791.c   |    4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-r8a7791.c
+++ work/arch/arm/mach-shmobile/clock-r8a7791.c	2014-02-24 13:49:45.000000000 +0900
@@ -23,8 +23,8 @@
 #include <linux/kernel.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/clock.h>
-#include <mach/common.h>
+#include "clock.h"
+#include "common.h"
 
 /*
  *   MD		EXTAL		PLL0	PLL1	PLL3
--- 0001/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2014-02-24 13:49:04.000000000 +0900
@@ -26,10 +26,10 @@
 #include <linux/platform_data/irq-renesas-irqc.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
-#include <mach/common.h>
-#include <mach/irqs.h>
-#include <mach/r8a7791.h>
-#include <mach/rcar-gen2.h>
+#include "common.h"
+#include "irqs.h"
+#include "r8a7791.h"
+#include "rcar-gen2.h"
 #include <asm/mach/arch.h>
 
 static const struct resource pfc_resources[] __initconst = {
--- 0001/arch/arm/mach-shmobile/smp-r8a7791.c
+++ work/arch/arm/mach-shmobile/smp-r8a7791.c	2014-02-24 13:48:39.000000000 +0900
@@ -18,8 +18,8 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <asm/smp_plat.h>
-#include <mach/common.h>
-#include <mach/r8a7791.h>
+#include "common.h"
+#include "r8a7791.h"
 
 #define RST		0xe6160000
 #define CA15BAR		0x0020
