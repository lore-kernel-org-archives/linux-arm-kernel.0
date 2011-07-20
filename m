From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Wed, 20 Jul 2011 19:02:30 +0530
Subject: [PATCH 2/3] ARM: S5PV210: Cleanup mach/regs-fb.h from mach-s5pv210
In-Reply-To: <1311168751-30336-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1311168751-30336-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1311168751-30336-3-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use plat/regs-fb-v4.h in machine files instead of mach/regs-fb.h.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/regs-fb.h |   21 ---------------------
 arch/arm/mach-s5pv210/mach-aquila.c          |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c            |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c        |    2 +-
 arch/arm/mach-s5pv210/setup-fb-24bpp.c       |    1 -
 5 files changed, 3 insertions(+), 25 deletions(-)
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/regs-fb.h

diff --git a/arch/arm/mach-s5pv210/include/mach/regs-fb.h b/arch/arm/mach-s5pv210/include/mach/regs-fb.h
deleted file mode 100644
index 60d9929..0000000
--- a/arch/arm/mach-s5pv210/include/mach/regs-fb.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* 
- * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
- *
- * Dummy framebuffer to allow build for the moment.
- * 
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_MACH_REGS_FB_H
-#define __ASM_ARCH_MACH_REGS_FB_H __FILE__
-
-#include <plat/regs-fb-v4.h>
-
-static inline unsigned int s3c_fb_pal_reg(unsigned int window, int reg)
-{
-	return 0x2400 + (window * 256 *4 ) + reg;
-}
-
-#endif /* __ASM_ARCH_MACH_REGS_FB_H */
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 4e1d8ff..509627f 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -29,7 +29,6 @@
 
 #include <mach/map.h>
 #include <mach/regs-clock.h>
-#include <mach/regs-fb.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/regs-serial.h>
@@ -40,6 +39,7 @@
 #include <plat/fimc-core.h>
 #include <plat/sdhci.h>
 #include <plat/s5p-time.h>
+#include <plat/regs-fb-v4.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define AQUILA_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 31d5aa7..e0c4d06 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -34,7 +34,6 @@
 
 #include <mach/map.h>
 #include <mach/regs-clock.h>
-#include <mach/regs-fb.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/regs-serial.h>
@@ -47,6 +46,7 @@
 #include <plat/sdhci.h>
 #include <plat/clock.h>
 #include <plat/s5p-time.h>
+#include <plat/regs-fb-v4.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define GONI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index c6a9e86..9ccab15 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -29,7 +29,6 @@
 
 #include <mach/map.h>
 #include <mach/regs-clock.h>
-#include <mach/regs-fb.h>
 
 #include <plat/regs-serial.h>
 #include <plat/regs-srom.h>
@@ -45,6 +44,7 @@
 #include <plat/pm.h>
 #include <plat/fb.h>
 #include <plat/s5p-time.h>
+#include <plat/regs-fb-v4.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
diff --git a/arch/arm/mach-s5pv210/setup-fb-24bpp.c b/arch/arm/mach-s5pv210/setup-fb-24bpp.c
index e932ebf..55103c8 100644
--- a/arch/arm/mach-s5pv210/setup-fb-24bpp.c
+++ b/arch/arm/mach-s5pv210/setup-fb-24bpp.c
@@ -15,7 +15,6 @@
 #include <linux/fb.h>
 #include <linux/gpio.h>
 
-#include <mach/regs-fb.h>
 #include <mach/map.h>
 #include <plat/fb.h>
 #include <mach/regs-clock.h>
-- 
1.7.0.4
