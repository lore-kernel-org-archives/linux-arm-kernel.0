From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 25 Feb 2016 09:40:00 +0530
Subject: [PATCH v2 2/2] ARM: SAMSUNG: remove unused register offset definition
In-Reply-To: <1456373400-10633-1-git-send-email-pankaj.dubey@samsung.com>
References: <1456373400-10633-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1456373400-10633-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch cleans up various map.h under mach-exynos, mach-s3c24xx and
plat-samsung by removing unused register offset. This patch also does a
minor nitpick of changing EXYNOS4 to EXYNOS from comment section of
header file "mach-exynos/include/mach/map.h".

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/include/mach/map.h      |  9 +--------
 arch/arm/mach-s3c24xx/include/mach/map.h     | 11 -----------
 arch/arm/plat-samsung/include/plat/map-s3c.h |  4 ----
 arch/arm/plat-samsung/include/plat/map-s5p.h |  5 -----
 4 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 351e839..c48ba4f 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -2,7 +2,7 @@
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
- * EXYNOS4 - Memory map definitions
+ * EXYNOS - Memory map definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -14,12 +14,6 @@
 
 #include <plat/map-base.h>
 
-/*
- * EXYNOS4 UART offset is 0x10000 but the older S5P SoCs are 0x400.
- * So need to define it, and here is to avoid redefinition warning.
- */
-#define S3C_UART_OFFSET			(0x10000)
-
 #include <plat/map-s5p.h>
 
 #define EXYNOS_PA_CHIPID		0x10000000
@@ -30,6 +24,5 @@
 #define EXYNOS4_PA_DMC1			0x10410000
 
 #define EXYNOS4_PA_COREPERI		0x10500000
-#define EXYNOS4_PA_L2CC			0x10502000
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/map.h b/arch/arm/mach-s3c24xx/include/mach/map.h
index 444793f..adc3904 100644
--- a/arch/arm/mach-s3c24xx/include/mach/map.h
+++ b/arch/arm/mach-s3c24xx/include/mach/map.h
@@ -14,13 +14,6 @@
 #define __ASM_ARCH_MAP_H
 
 #include <plat/map-base.h>
-
-/*
- * S3C2410 UART offset is 0x4000 but the other SoCs are 0x400.
- * So need to define it, and here is to avoid redefinition warning.
- */
-#define S3C_UART_OFFSET		(0x4000)
-
 #include <plat/map-s3c.h>
 
 /*
@@ -34,9 +27,6 @@
 #define S3C2410_PA_MEMCTRL	(0x48000000)
 #define S3C24XX_SZ_MEMCTRL	SZ_1M
 
-/* UARTs */
-#define S3C_VA_UARTx(uart)	(S3C_VA_UART + ((uart * S3C_UART_OFFSET)))
-
 /* Timers */
 #define S3C2410_PA_TIMER	(0x51000000)
 #define S3C24XX_SZ_TIMER	SZ_1M
@@ -157,7 +147,6 @@
 
 #define S3C_PA_FB	    S3C2443_PA_FB
 #define S3C_PA_IIC          S3C2410_PA_IIC
-#define S3C_PA_UART	    S3C24XX_PA_UART
 #define S3C_PA_USBHOST	S3C2410_PA_USBHOST
 #define S3C_PA_HSMMC0	    S3C2416_PA_HSMMC0
 #define S3C_PA_HSMMC1	    S3C2443_PA_HSMMC
diff --git a/arch/arm/plat-samsung/include/plat/map-s3c.h b/arch/arm/plat-samsung/include/plat/map-s3c.h
index c0c70a8..6feedd4 100644
--- a/arch/arm/plat-samsung/include/plat/map-s3c.h
+++ b/arch/arm/plat-samsung/include/plat/map-s3c.h
@@ -27,10 +27,6 @@
 #define S3C2410_PA_UART		(0x50000000)
 #define S3C24XX_PA_UART		S3C2410_PA_UART
 
-#ifndef S3C_UART_OFFSET
-#define S3C_UART_OFFSET		(0x400)
-#endif
-
 /*
  * GPIO ports
  *
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index e555769..b63aeeb 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -22,7 +22,6 @@
 #define S5P_VA_COREPERI_BASE	S3C_ADDR(0x02800000)
 #define S5P_VA_COREPERI(x)	(S5P_VA_COREPERI_BASE + (x))
 #define S5P_VA_SCU		S5P_VA_COREPERI(0x0)
-#define S5P_VA_TWD		S5P_VA_COREPERI(0x600)
 
 #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
 #define VA_VIC0			VA_VIC(0)
@@ -30,10 +29,6 @@
 #define VA_VIC2			VA_VIC(2)
 #define VA_VIC3			VA_VIC(3)
 
-#ifndef S3C_UART_OFFSET
-#define S3C_UART_OFFSET		(0x400)
-#endif
-
 #include <plat/map-s3c.h>
 
 #endif /* __ASM_PLAT_MAP_S5P_H */
-- 
2.4.5
