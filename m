From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:24:03 -0800
Subject: [PATCH 26/26] ARM: S3C64XX: make regs-syscon-power.h local
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-27-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header file can be local in mach-s3c64xx/.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/pm.c                                   |    2 +-
 arch/arm/mach-s3c64xx/{include/mach => }/regs-syscon-power.h |    9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)
 rename arch/arm/mach-s3c64xx/{include/mach => }/regs-syscon-power.h (95%)

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 546d6e0..f6b13a2 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -28,11 +28,11 @@
 
 #include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
-#include <mach/regs-syscon-power.h>
 
 #include "regs-gpio-memport.h"
 #include "regs-modem.h"
 #include "regs-sys.h"
+#include "regs-syscon-power.h"
 
 struct s3c64xx_pm_domain {
 	char *const name;
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-syscon-power.h b/arch/arm/mach-s3c64xx/regs-syscon-power.h
similarity index 95%
rename from arch/arm/mach-s3c64xx/include/mach/regs-syscon-power.h
rename to arch/arm/mach-s3c64xx/regs-syscon-power.h
index 270d96a..6e16b34 100644
--- a/arch/arm/mach-s3c64xx/include/mach/regs-syscon-power.h
+++ b/arch/arm/mach-s3c64xx/regs-syscon-power.h
@@ -1,5 +1,4 @@
-/* arch/arm/plat-s3c64xx/include/plat/regs-syscon-power.h
- *
+/*
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *      http://armlinux.simtec.co.uk/
@@ -12,8 +11,8 @@
  * published by the Free Software Foundation.
 */
 
-#ifndef __PLAT_S3C64XX_REGS_SYSCON_POWER_H
-#define __PLAT_S3C64XX_REGS_SYSCON_POWER_H __FILE__
+#ifndef __MACH_S3C64XX_REGS_SYSCON_POWER_H
+#define __MACH_S3C64XX_REGS_SYSCON_POWER_H __FILE__
 
 #define S3C64XX_PWR_CFG				S3C_SYSREG(0x804)
 
@@ -113,4 +112,4 @@
 #define S3C64XX_INFORM2				S3C_SYSREG(0xA08)
 #define S3C64XX_INFORM3				S3C_SYSREG(0xA0C)
 
-#endif /* __PLAT_S3C64XX_REGS_SYSCON_POWER_H */
+#endif /* __MACH_S3C64XX_REGS_SYSCON_POWER_H */
-- 
1.7.10.4
