From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 26 Jul 2013 18:05:28 +0800
Subject: [PATCH v6 06/11] clocksource: mmp: move mmp timer driver
In-Reply-To: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1374833133-21119-7-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move timer-mmp driver from mach-mmp to clocksource directory.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/Makefile                                  | 2 +-
 drivers/clocksource/Makefile                                | 1 +
 arch/arm/mach-mmp/time.c => drivers/clocksource/timer-mmp.c | 2 --
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename arch/arm/mach-mmp/time.c => drivers/clocksource/timer-mmp.c (99%)

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 9b702a1..5d4ccc6 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Marvell's PXA168 processors line
 #
 
-obj-y				+= common.o devices.o time.o
+obj-y				+= common.o devices.o
 
 # SoC support
 obj-$(CONFIG_CPU_PXA168)	+= pxa168.o
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 8b00c5c..7dda633 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
 obj-$(CONFIG_ARCH_MARCO)	+= timer-marco.o
+obj-$(CONFIG_ARCH_MMP)		+= timer-mmp.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
 obj-$(CONFIG_ARCH_PRIMA2)	+= timer-prima2.o
 obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
diff --git a/arch/arm/mach-mmp/time.c b/drivers/clocksource/timer-mmp.c
similarity index 99%
rename from arch/arm/mach-mmp/time.c
rename to drivers/clocksource/timer-mmp.c
index 7ac41e8..ddc1b15 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/drivers/clocksource/timer-mmp.c
@@ -37,8 +37,6 @@
 #include <mach/cputype.h>
 #include <asm/mach/time.h>
 
-#include "clock.h"
-
 #define TIMERS_VIRT_BASE	TIMERS1_VIRT_BASE
 
 #define MAX_DELTA		(0xfffffffe)
-- 
1.8.1.2
