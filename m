From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 14:42:42 +0900
Subject: [PATCH 11/12] ARM: shmobile: Rework include path for r7s72100
In-Reply-To: <20140224054058.1143.14096.sendpatchset@w520>
References: <20140224054058.1143.14096.sendpatchset@w520>
Message-ID: <20140224054242.1143.3118.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert r7s72100 SoC code use of include files from 
the style <mach/something.h> to "something.h".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r7s72100.c |    4 ++--
 arch/arm/mach-shmobile/setup-r7s72100.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-r7s72100.c
+++ work/arch/arm/mach-shmobile/clock-r7s72100.c	2014-02-24 13:57:37.000000000 +0900
@@ -19,8 +19,8 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/common.h>
-#include <mach/r7s72100.h>
+#include "common.h"
+#include "r7s72100.h"
 
 /* Frequency Control Registers */
 #define FRQCR		0xfcfe0010
--- 0001/arch/arm/mach-shmobile/setup-r7s72100.c
+++ work/arch/arm/mach-shmobile/setup-r7s72100.c	2014-02-24 13:56:17.000000000 +0900
@@ -23,9 +23,9 @@
 #include <linux/of_platform.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
-#include <mach/common.h>
-#include <mach/irqs.h>
-#include <mach/r7s72100.h>
+#include "common.h"
+#include "irqs.h"
+#include "r7s72100.h"
 #include <asm/mach/arch.h>
 
 #define R7S72100_SCIF(index, baseaddr, irq)				\
