From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 11 Jan 2012 14:14:36 +1100
Subject: [PATCH 11/11] ep93xx: Remove unnecessary includes of ep93xx-regs.h
In-Reply-To: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
Message-ID: <1326251676-7593-12-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the include of ep93xx-regs.h from files which no longer need
it, notably include/mach/hardware.h. An explict include of
ep93xx-regs.h is needed in the EP93xx watchdog driver for the
EP93XX_APB_IOMEM macro.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/crunch.c                |    2 +-
 arch/arm/mach-ep93xx/include/mach/hardware.h |    1 -
 arch/arm/mach-ep93xx/soc.h                   |    2 ++
 drivers/watchdog/ep93xx_wdt.c                |    1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

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
index 0e1041d..0a64e4a 100644
--- a/arch/arm/mach-ep93xx/soc.h
+++ b/arch/arm/mach-ep93xx/soc.h
@@ -13,6 +13,8 @@
 #ifndef _EP93XX_SOC_H
 #define _EP93XX_SOC_H
 
+#include <mach/ep93xx-regs.h>
+
 /* EP93xx System Controller software locked register write */
 void ep93xx_syscon_swlocked_write(unsigned int val, void __iomem *reg);
 void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits);
diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 82f648a..3d7f691 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -31,6 +31,7 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
+#include <mach/ep93xx-regs.h>
 
 #define WDT_VERSION	"0.3"
 #define PFX		"ep93xx_wdt: "
-- 
1.7.0.4
