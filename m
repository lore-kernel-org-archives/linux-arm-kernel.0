From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 22 May 2012 11:24:22 +0300
Subject: [PATCH] remoteproc/omap: fix dev_err typo
Message-ID: <1337675062-22028-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some reason one of the dev_err invocations is using a wrong
device so fix that.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/remoteproc/omap_remoteproc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 69425c4..de138e30 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -182,7 +182,7 @@ static int __devinit omap_rproc_probe(struct platform_device *pdev)
 
 	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret) {
-		dev_err(pdev->dev.parent, "dma_set_coherent_mask: %d\n", ret);
+		dev_err(&pdev->dev, "dma_set_coherent_mask: %d\n", ret);
 		return ret;
 	}
 
-- 
1.7.5.4
