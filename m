From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Wed, 17 Jan 2018 11:40:34 +0000
Subject: [PATCH -next] hwrng: bcm2835 - Remove redundant dev_err call in
 bcm2835_rng_probe()
Message-ID: <1516189234-11957-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/char/hw_random/bcm2835-rng.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index 25e5631..7a84cec 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -158,10 +158,8 @@ static int bcm2835_rng_probe(struct platform_device *pdev)
 
 	/* map peripheral */
 	priv->base = devm_ioremap_resource(dev, r);
-	if (IS_ERR(priv->base)) {
-		dev_err(dev, "failed to remap rng regs");
+	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
-	}
 
 	/* Clock is optional on most platforms */
 	priv->clk = devm_clk_get(dev, NULL);
