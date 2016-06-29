From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 29 Jun 2016 16:10:34 +0800
Subject: [PATCH v2] ARM: s3c64xx: Add missing head file
In-Reply-To: <577379DA.10902@samsung.com>
References: <577379DA.10902@samsung.com>
Message-ID: <1467187835-25660-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The building reports warning after patch "arm: Remove unnecessary
of_platform_populate with default match table",

"arch/arm/mach-s3c64xx/common.h:28:2: warning: 'struct device_node' declared inside parameter list"

Add the missing of.h for device_node struct in common.h, and kill common.h
from arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c, because no function need it.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---

Hi Krzysztof, 

Thanks for your points, add "Reported-by" tag in v2, and Rob can directly
pick it up if necessary.

Thanks,
Kefeng

 arch/arm/mach-s3c64xx/common.h          | 1 +
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/common.h b/arch/arm/mach-s3c64xx/common.h
index 9eb8644..c2c8ac3 100644
--- a/arch/arm/mach-s3c64xx/common.h
+++ b/arch/arm/mach-s3c64xx/common.h
@@ -17,6 +17,7 @@
 #ifndef __ARCH_ARM_MACH_S3C64XX_COMMON_H
 #define __ARCH_ARM_MACH_S3C64XX_COMMON_H
 
+#include <linux/of.h>
 #include <linux/reboot.h>
 
 void s3c64xx_init_irq(u32 vic0, u32 vic1);
diff --git a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
index 5bf9afa..be0678a 100644
--- a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
+++ b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
@@ -15,7 +15,6 @@
 #include <plat/cpu.h>
 #include <mach/map.h>
 
-#include "common.h"
 #include "watchdog-reset.h"
 
 /*
-- 
1.7.12.4
