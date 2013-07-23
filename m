From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 23 Jul 2013 20:01:57 +0200
Subject: [PATCH 24/27] sound/soc/pxa: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1374602524-3398-25-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Please apply via the subsystem-tree.

 sound/soc/pxa/mmp-sspa.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 62142ce..1605934 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -430,9 +430,6 @@ static int asoc_mmp_sspa_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL)
-		return -ENOMEM;
-
 	priv->sspa->mmio_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->sspa->mmio_base))
 		return PTR_ERR(priv->sspa->mmio_base);
-- 
1.7.10.4
