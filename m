From: banajit.g@samsung.com (Banajit Goswami)
Date: Tue, 19 Jul 2011 17:35:05 +0530
Subject: [PATCH 6/7] ARM: S3C64XX: Use generic s3c_set_platdata for OneNAND
In-Reply-To: <1311077106-28351-1-git-send-email-banajit.g@samsung.com>
References: <1311077106-28351-1-git-send-email-banajit.g@samsung.com>
Message-ID: <1311077106-28351-7-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call the generic s3c_set_platdata for setting platdata for OneNAND on
S3C64XX

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
 arch/arm/mach-s3c64xx/dev-onenand1.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-onenand1.c b/arch/arm/mach-s3c64xx/dev-onenand1.c
index 92ffd5b..999f9e1 100644
--- a/arch/arm/mach-s3c64xx/dev-onenand1.c
+++ b/arch/arm/mach-s3c64xx/dev-onenand1.c
@@ -19,6 +19,8 @@
 #include <mach/irqs.h>
 #include <mach/map.h>
 
+#include <plat/devs.h>
+
 static struct resource s3c64xx_onenand1_resources[] = {
 	[0] = {
 		.start	= S3C64XX_PA_ONENAND1,
@@ -46,10 +48,6 @@ struct platform_device s3c64xx_device_onenand1 = {
 
 void s3c64xx_onenand1_set_platdata(struct onenand_platform_data *pdata)
 {
-	struct onenand_platform_data *pd;
-
-	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
-	if (!pd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	s3c64xx_device_onenand1.dev.platform_data = pd;
+	s3c_set_platdata(pdata, sizeof(struct onenand_platform_data),
+			 &s3c64xx_device_onenand1);
 }
-- 
1.7.2.3
