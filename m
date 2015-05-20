From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 May 2015 12:41:41 +0100
Subject: [PATCH] coresight: etb: Remove simple announcement message
Message-ID: <1432122101-2233-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's generally preferred that drivers not print initialisation messages on
startup that don't contain information gained at runtime such as specific
hardware revision information. This provides a small speedup on systems
with serial consoles and keeps the boot less noisy.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 77d0f9c1118d..e34e34b8edfb 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -481,7 +481,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	if (ret)
 		goto err_misc_register;
 
-	dev_info(dev, "ETB initialized\n");
 	return 0;
 
 err_misc_register:
-- 
2.1.4
