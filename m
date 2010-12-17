From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 14:00:03 +0900
Subject: [PATCH 01/17] ARM: S5P6442: Implement i2c-gpio config
In-Reply-To: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1292562003-19619-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p6442/setup-i2c0.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5p6442/setup-i2c0.c b/arch/arm/mach-s5p6442/setup-i2c0.c
index 662695d..aad8565 100644
--- a/arch/arm/mach-s5p6442/setup-i2c0.c
+++ b/arch/arm/mach-s5p6442/setup-i2c0.c
@@ -14,12 +14,15 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/gpio.h>
 
 struct platform_device; /* don't need the contents */
 
+#include <plat/gpio-cfg.h>
 #include <plat/iic.h>
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	/* Will be populated later */
+	s3c_gpio_cfgall_range(S5P6442_GPD1(0), 2,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 }
-- 
1.6.2.5
