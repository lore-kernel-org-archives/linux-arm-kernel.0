From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 13 Mar 2012 09:48:22 +1100
Subject: [PATCH v4 11/11] ep93xx: Remove unnecessary includes of ep93xx-regs.h
Message-ID: <1331592502-9083-12-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the include of ep93xx-regs.h from files which no longer need
it, notably include/mach/hardware.h.

Signed-off-by: Ryan Mallon <rmallon@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
Acked-by: Hartley Sweeten <hsweeten@visionengravers.com>
---
 arch/arm/mach-ep93xx/crunch.c                |    2 +-
 arch/arm/mach-ep93xx/include/mach/hardware.h |    1 -
 arch/arm/mach-ep93xx/soc.h                   |    2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ep93xx/crunch.c b/arch/arm/mach-ep93xx/crunch.c
index d05ed0b..74753e2 100644
--- a/arch/arm/mach-ep93xx/crunch.c
+++ b/arch/arm/mach-ep93xx/crunch.c
@@ -16,7 +16,7 @@
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <mach/ep93xx-regs.h>
+
 #include <asm/thread_notify.h>
 
 #include "soc.h"
diff --git a/arch/arm/mach-ep93xx/include/mach/hardware.h b/arch/arm/mach-ep93xx/include/mach/hardware.h
index 4df8428..efcd478 100644
--- a/arch/arm/mach-ep93xx/include/mach/hardware.h
+++ b/arch/arm/mach-ep93xx/include/mach/hardware.h
@@ -5,7 +5,6 @@
 #ifndef __ASM_ARCH_HARDWARE_H
 #define __ASM_ARCH_HARDWARE_H
 
-#include <mach/ep93xx-regs.h>
 #include <mach/platform.h>
 
 /*
diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
index ce32c2c..a20e558 100644
--- a/arch/arm/mach-ep93xx/soc.h
+++ b/arch/arm/mach-ep93xx/soc.h
@@ -13,6 +13,8 @@
 #ifndef _EP93XX_SOC_H
 #define _EP93XX_SOC_H
 
+#include <mach/ep93xx-regs.h>
+
 /*
  * EP93xx Physical Memory Map:
  *
-- 
1.7.0.4
