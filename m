From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:55 -0800
Subject: [PATCH 18/26] ARM: S3C2412: cleanup regs-s3c2412.h
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-19-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the regs-s3c2412.h into mach-s3c24xx/s3c2412.c file.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c24xx/include/mach/regs-s3c2412.h |   23 -----------------
 arch/arm/mach-s3c24xx/s3c2412.c                   |   28 ++++++++++-----------
 2 files changed, 14 insertions(+), 37 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/regs-s3c2412.h

diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2412.h b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2412.h
deleted file mode 100644
index aa69dc7..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2412.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-s3c2412.h
- *
- * Copyright 2007 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2412 specific register definitions
-*/
-
-#ifndef __ASM_ARCH_REGS_S3C2412_H
-#define __ASM_ARCH_REGS_S3C2412_H "s3c2412"
-
-#define S3C2412_SWRST		(S3C24XX_VA_CLKPWR + 0x30)
-#define S3C2412_SWRST_RESET	(0x533C2412)
-
-/* see regs-power.h for the other registers in the power block. */
-
-#endif	/* __ASM_ARCH_REGS_S3C2412_H */
-
diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
index 6c5f403..26ab760 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c24xx/s3c2412.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-s3c2412/s3c2412.c
- *
+/*
  * Copyright (c) 2006 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
@@ -28,28 +27,29 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware.h>
 #include <asm/proc-fns.h>
 #include <asm/irq.h>
 #include <asm/system_misc.h>
 
-#include <plat/cpu-freq.h>
-
+#include <mach/hardware.h>
 #include <mach/regs-clock.h>
-#include <plat/regs-serial.h>
-#include <mach/regs-power.h>
-#include <mach/regs-gpio.h>
 #include <mach/regs-dsc.h>
-#include <plat/regs-spi.h>
-#include <mach/regs-s3c2412.h>
+#include <mach/regs-gpio.h>
+#include <mach/regs-power.h>
 
-#include <plat/s3c2412.h>
+#include <plat/clock.h>
 #include <plat/cpu.h>
+#include <plat/cpu-freq.h>
 #include <plat/devs.h>
-#include <plat/clock.h>
-#include <plat/pm.h>
-#include <plat/pll.h>
 #include <plat/nand-core.h>
+#include <plat/pll.h>
+#include <plat/pm.h>
+#include <plat/regs-serial.h>
+#include <plat/regs-spi.h>
+#include <plat/s3c2412.h>
+
+#define S3C2412_SWRST			(S3C24XX_VA_CLKPWR + 0x30)
+#define S3C2412_SWRST_RESET		(0x533C2412)
 
 #ifndef CONFIG_CPU_S3C2412_ONLY
 void __iomem *s3c24xx_va_gpio2 = S3C24XX_VA_GPIO;
-- 
1.7.10.4
