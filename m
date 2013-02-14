From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 23:26:56 +0100
Subject: [PATCH 7/9] ARM defconfigs: add missing inclusions of
 linux/platform_device.h
In-Reply-To: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
References: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
Message-ID: <1360880818-4071454-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 16559ae "kgdb: remove #include <linux/serial_8250.h> from kgdb.h"
removed an implicit inclusion of linux/platform_device.h
In a number of places. This adds back explicit inclusions in a few
more places I found.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 arch/arm/plat-samsung/include/plat/adc.h | 1 +
 drivers/video/clps711xfb.c               | 1 +
 drivers/video/mmp/fb/mmpfb.c             | 1 +
 include/linux/platform_data/s3c-hsotg.h  | 2 ++
 4 files changed, 5 insertions(+)

diff --git a/arch/arm/plat-samsung/include/plat/adc.h b/arch/arm/plat-samsung/include/plat/adc.h
index b258a08..2fc8931 100644
--- a/arch/arm/plat-samsung/include/plat/adc.h
+++ b/arch/arm/plat-samsung/include/plat/adc.h
@@ -15,6 +15,7 @@
 #define __ASM_PLAT_ADC_H __FILE__
 
 struct s3c_adc_client;
+struct platform_device;
 
 extern int s3c_adc_start(struct s3c_adc_client *client,
 			 unsigned int channel, unsigned int nr_samples);
diff --git a/drivers/video/clps711xfb.c b/drivers/video/clps711xfb.c
index 5a7af0d..f009806 100644
--- a/drivers/video/clps711xfb.c
+++ b/drivers/video/clps711xfb.c
@@ -26,6 +26,7 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
diff --git a/drivers/video/mmp/fb/mmpfb.c b/drivers/video/mmp/fb/mmpfb.c
index f34a3a9..6d1fa96 100644
--- a/drivers/video/mmp/fb/mmpfb.c
+++ b/drivers/video/mmp/fb/mmpfb.c
@@ -21,6 +21,7 @@
  */
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
 #include "mmpfb.h"
 
 static int var_to_pixfmt(struct fb_var_screeninfo *var)
diff --git a/include/linux/platform_data/s3c-hsotg.h b/include/linux/platform_data/s3c-hsotg.h
index 8b79e09..3f1cbf9 100644
--- a/include/linux/platform_data/s3c-hsotg.h
+++ b/include/linux/platform_data/s3c-hsotg.h
@@ -15,6 +15,8 @@
 #ifndef __LINUX_USB_S3C_HSOTG_H
 #define __LINUX_USB_S3C_HSOTG_H
 
+struct platform_device;
+
 enum s3c_hsotg_dmamode {
 	S3C_HSOTG_DMA_NONE,	/* do not use DMA at-all */
 	S3C_HSOTG_DMA_ONLY,	/* always use DMA */
-- 
1.8.1.2
