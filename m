From: fkan@apm.com (Feng Kan)
Date: Tue,  7 Jan 2014 14:50:39 -0800
Subject: [PATCH V2 4/6] power: reset: removed use of the dts mask and use
 fixed value for reset.
In-Reply-To: <1389135041-16062-1-git-send-email-fkan@apm.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
Message-ID: <1389135041-16062-5-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the use of the mask attribute in the X-Gene reboot driver and
use fixed value.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 drivers/power/reset/xgene-reboot.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index ecd55f8..683238c 100644
--- a/drivers/power/reset/xgene-reboot.c
+++ b/drivers/power/reset/xgene-reboot.c
@@ -40,7 +40,7 @@ struct xgene_reboot_context {
 
 static struct xgene_reboot_context *xgene_restart_ctx;
 
-static void xgene_restart(char str, const char *cmd)
+static void xgene_restart(enum reboot_mode reboot_mode, const char *cmd)
 {
 	struct xgene_reboot_context *ctx = xgene_restart_ctx;
 	unsigned long timeout;
@@ -73,8 +73,7 @@ static int xgene_reboot_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask))
-		ctx->mask = 0xFFFFFFFF;
+	ctx->mask = 0x1;
 
 	ctx->pdev = pdev;
 	arm_pm_restart = xgene_restart;
-- 
1.7.6.1
