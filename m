From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 12 Aug 2011 15:55:54 +0530
Subject: [PATCH] ARM: S3C64XX: Fix build break in PM debug
Message-ID: <1313144754-30485-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When S3C_PM_DEBUG_LED_SMDK is enabled for suspend/resume debugging, the following
compilation error occurs:

arch/arm/mach-s3c64xx/pm.c: In function 's3c_pm_debug_smdkled':
arch/arm/mach-s3c64xx/pm.c:41: error: implicit declaration of function 'gpio_set_value'
arch/arm/mach-s3c64xx/pm.c:41: error: implicit declaration of function 'S3C64XX_GPN'
arch/arm/mach-s3c64xx/pm.c: In function 's3c64xx_pm_init':
arch/arm/mach-s3c64xx/pm.c:184: error: implicit declaration of function 'gpio_request'
arch/arm/mach-s3c64xx/pm.c:188: error: implicit declaration of function 'gpio_direction_output'

Fix the error by including linux/gpio.h

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-s3c64xx/pm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 8bad643..055e285 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -16,6 +16,7 @@
 #include <linux/suspend.h>
 #include <linux/serial_core.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 
 #include <mach/map.h>
 #include <mach/irqs.h>
-- 
1.6.6.1
