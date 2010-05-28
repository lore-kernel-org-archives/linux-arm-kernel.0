From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 07:19:19 +0100
Subject: [PATCH 9/9] ARM: S3C64XX: Use s3c_set_platdata() helper
In-Reply-To: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
References: <1275027559-29278-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275027559-29278-10-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f8b5ea089d5a447a8933a6540ceeccbcb78f9e53 added a helper
to copy and set platform data, so let's replace the various sites
in the Samsung support where this is happening.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/dev-onenand1.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-onenand1.c b/arch/arm/mach-s3c64xx/dev-onenand1.c
index 92ffd5b..c902a1d 100644
--- a/arch/arm/mach-s3c64xx/dev-onenand1.c
+++ b/arch/arm/mach-s3c64xx/dev-onenand1.c
@@ -46,10 +46,6 @@ struct platform_device s3c64xx_device_onenand1 = {
 
 void s3c64xx_onenand1_set_platdata(struct onenand_platform_data *pdata)
 {
-	struct onenand_platform_data *pd;
-
-	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
-	if (!pd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	s3c64xx_device_onenand1.dev.platform_data = pd;
+	s3c_set_platdata(pd, sizeof(struct onenand_platform_data),
+			 &s3c64xx_device_onenand1);
 }
-- 
1.6.3.3
