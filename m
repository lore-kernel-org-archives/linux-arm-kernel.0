From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 5 Aug 2013 20:17:20 +0530
Subject: [PATCH 3/6] hwrng: OMAP: Remove duplicated function call
In-Reply-To: <1375714043-23407-1-git-send-email-lokeshvutla@ti.com>
References: <1375714043-23407-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1375714043-23407-4-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_set_drvdata() is called twice in driver probe.
Removing the duplicated call.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/char/hw_random/omap-rng.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 9c19396..5a2ab3b 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -125,7 +125,6 @@ static int omap_rng_probe(struct platform_device *pdev)
 		ret = PTR_ERR(priv->base);
 		goto err_ioremap;
 	}
-	platform_set_drvdata(pdev, priv);
 
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
-- 
1.7.9.5
