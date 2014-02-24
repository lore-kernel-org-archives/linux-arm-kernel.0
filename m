From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 14:41:34 +0900
Subject: [PATCH 04/12] ARM: shmobile: Rework include path for EMEV2
In-Reply-To: <20140224054058.1143.14096.sendpatchset@w520>
References: <20140224054058.1143.14096.sendpatchset@w520>
Message-ID: <20140224054134.1143.15635.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert EMEV2 SoC code use of include files from 
the style <mach/something.h> to "something.h".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-emev2.c |    2 +-
 arch/arm/mach-shmobile/setup-emev2.c |    4 ++--
 arch/arm/mach-shmobile/smp-emev2.c   |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-emev2.c
+++ work/arch/arm/mach-shmobile/clock-emev2.c	2014-02-24 13:28:21.000000000 +0900
@@ -21,7 +21,7 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/common.h>
+#include "common.h"
 
 #define EMEV2_SMU_BASE 0xe0110000
 
--- 0001/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2014-02-24 13:28:37.000000000 +0900
@@ -20,8 +20,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
-#include <mach/common.h>
-#include <mach/emev2.h>
+#include "common.h"
+#include "emev2.h"
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
--- 0001/arch/arm/mach-shmobile/smp-emev2.c
+++ work/arch/arm/mach-shmobile/smp-emev2.c	2014-02-24 13:28:58.000000000 +0900
@@ -23,8 +23,8 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-#include <mach/common.h>
-#include <mach/emev2.h>
+#include "common.h"
+#include "emev2.h"
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
