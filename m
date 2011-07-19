From: banajit.g@samsung.com (Banajit Goswami)
Date: Tue, 19 Jul 2011 17:35:00 +0530
Subject: [PATCH 1/7] ARM: SAMSUNG: Use generic s3c_set_platdata for TS
In-Reply-To: <1311077106-28351-1-git-send-email-banajit.g@samsung.com>
References: <1311077106-28351-1-git-send-email-banajit.g@samsung.com>
Message-ID: <1311077106-28351-2-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call the generic s3c_set_platdata to set TS platform data

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
 arch/arm/plat-samsung/dev-ts.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-ts.c b/arch/arm/plat-samsung/dev-ts.c
index 3e4bd81..82543f0 100644
--- a/arch/arm/plat-samsung/dev-ts.c
+++ b/arch/arm/plat-samsung/dev-ts.c
@@ -45,16 +45,6 @@ struct platform_device s3c_device_ts = {
 
 void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *pd)
 {
-	struct s3c2410_ts_mach_info *npd;
-
-	if (!pd) {
-		printk(KERN_ERR "%s: no platform data\n", __func__);
-		return;
-	}
-
-	npd = kmemdup(pd, sizeof(struct s3c2410_ts_mach_info), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-
-	s3c_device_ts.dev.platform_data = npd;
+	s3c_set_platdata(pd, sizeof(struct s3c2410_ts_mach_info),
+			 &s3c_device_ts);
 }
-- 
1.7.2.3
