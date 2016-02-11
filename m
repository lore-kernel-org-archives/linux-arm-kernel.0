From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Feb 2016 12:50:04 +0000
Subject: [PATCH] coresight: etb: Remove simple announcement message
Message-ID: <1455195004-30214-1-git-send-email-broonie@kernel.org>
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
index 92969dae739d..18c55d1c428c 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -481,7 +481,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	if (ret)
 		goto err_misc_register;
 
-	dev_info(dev, "ETB initialized\n");
 	return 0;
 
 err_misc_register:
-- 
2.7.0
