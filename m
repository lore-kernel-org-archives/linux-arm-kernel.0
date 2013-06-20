From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 20 Jun 2013 20:46:36 +0400
Subject: [PATCH RESEND] media: coda: Fix DT-driver data pointer for i.MX27
Message-ID: <1371746796-16123-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/media/platform/coda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/coda.c b/drivers/media/platform/coda.c
index 48b8d7a..1c77781 100644
--- a/drivers/media/platform/coda.c
+++ b/drivers/media/platform/coda.c
@@ -1924,7 +1924,7 @@ MODULE_DEVICE_TABLE(platform, coda_platform_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id coda_dt_ids[] = {
-	{ .compatible = "fsl,imx27-vpu", .data = &coda_platform_ids[CODA_IMX27] },
+	{ .compatible = "fsl,imx27-vpu", .data = &coda_devdata[CODA_IMX27] },
 	{ .compatible = "fsl,imx53-vpu", .data = &coda_devdata[CODA_IMX53] },
 	{ /* sentinel */ }
 };
-- 
1.8.1.5
