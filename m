From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 07:55:36 +0900
Subject: [PATCH 02/12] ARM: S3C24XX: move spi-s3c24xx platdata out of mach
In-Reply-To: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1329346545-16373-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko@sntech.de>

spi.h now only contains the definition of the platform data structure
for the driver in spi-s3c24xx.c . Therefore it does not need to stay
in include/mach but can instead live in linux/spi/s3c24xx.h .

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2440/mach-gta02.c                 |    2 +-
 drivers/spi/spi-s3c24xx.c                          |    2 +-
 .../mach/spi.h => include/linux/spi/s3c24xx.h      |    9 ++++-----
 3 files changed, 6 insertions(+), 7 deletions(-)
 rename arch/arm/mach-s3c2410/include/mach/spi.h => include/linux/spi/s3c24xx.h (82%)

diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 5859e60..cf270f5 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -38,6 +38,7 @@
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/s3c24xx.h>
 
 #include <linux/mmc/host.h>
 
@@ -73,7 +74,6 @@
 #include <mach/regs-gpioj.h>
 #include <mach/fb.h>
 
-#include <mach/spi.h>
 #include <plat/usb-control.h>
 #include <mach/regs-mem.h>
 #include <mach/hardware.h>
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index fc06453..8ee7d79 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -24,10 +24,10 @@
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
+#include <linux/spi/s3c24xx.h>
 #include <linux/module.h>
 
 #include <plat/regs-spi.h>
-#include <mach/spi.h>
 
 #include <plat/fiq.h>
 #include <asm/fiq.h>
diff --git a/arch/arm/mach-s3c2410/include/mach/spi.h b/include/linux/spi/s3c24xx.h
similarity index 82%
rename from arch/arm/mach-s3c2410/include/mach/spi.h
rename to include/linux/spi/s3c24xx.h
index 2a686c0..c23b923 100644
--- a/arch/arm/mach-s3c2410/include/mach/spi.h
+++ b/include/linux/spi/s3c24xx.h
@@ -1,5 +1,4 @@
-/* arch/arm/mach-s3c2410/include/mach/spi.h
- *
+/*
  * Copyright (c) 2006 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
@@ -10,8 +9,8 @@
  * published by the Free Software Foundation.
 */
 
-#ifndef __ASM_ARCH_SPI_H
-#define __ASM_ARCH_SPI_H __FILE__
+#ifndef __LINUX_SPI_S3C24XX_H
+#define __LINUX_SPI_S3C24XX_H __FILE__
 
 struct s3c2410_spi_info {
 	int			 pin_cs;	/* simple gpio cs */
@@ -24,4 +23,4 @@ struct s3c2410_spi_info {
 	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
 };
 
-#endif /* __ASM_ARCH_SPI_H */
+#endif /* __LINUX_SPI_S3C24XX_H */
-- 
1.7.4.4
