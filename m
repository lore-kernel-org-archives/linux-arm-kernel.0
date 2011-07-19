From: banajit.g@samsung.com (Banajit Goswami)
Date: Tue, 19 Jul 2011 17:35:01 +0530
Subject: [PATCH 2/7] ARM: SAMSUNG: Use generic s3c_set_platdata for FB
In-Reply-To: <1311077106-28351-1-git-send-email-banajit.g@samsung.com>
References: <1311077106-28351-1-git-send-email-banajit.g@samsung.com>
Message-ID: <1311077106-28351-3-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call the generic s3c_set_platdata to set FB platform data

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
 arch/arm/plat-samsung/dev-fb.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-fb.c b/arch/arm/plat-samsung/dev-fb.c
index bf60204..49a1362 100644
--- a/arch/arm/plat-samsung/dev-fb.c
+++ b/arch/arm/plat-samsung/dev-fb.c
@@ -58,16 +58,6 @@ struct platform_device s3c_device_fb = {
 
 void __init s3c_fb_set_platdata(struct s3c_fb_platdata *pd)
 {
-	struct s3c_fb_platdata *npd;
-
-	if (!pd) {
-		printk(KERN_ERR "%s: no platform data\n", __func__);
-		return;
-	}
-
-	npd = kmemdup(pd, sizeof(struct s3c_fb_platdata), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-
-	s3c_device_fb.dev.platform_data = npd;
+	s3c_set_platdata(pd, sizeof(struct s3c_fb_platdata),
+			 &s3c_device_fb);
 }
-- 
1.7.2.3
