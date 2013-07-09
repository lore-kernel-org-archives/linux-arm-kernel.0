From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  9 Jul 2013 15:37:54 +0100
Subject: [PATCH 1/3] DMA: shdma: (cosmetic) don't re-calculate a pointer
In-Reply-To: <1373380677-450-1-git-send-email-lee.jones@linaro.org>
References: <1373380677-450-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1373380677-450-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Use an existing pointer instead of retrieving it again.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/sh/shdma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index b70709b..a5a1887 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -729,7 +729,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 		goto eshdma;
 
 	/* platform data */
-	shdev->pdata = pdev->dev.platform_data;
+	shdev->pdata = pdata;
 
 	if (pdata->chcr_offset)
 		shdev->chcr_offset = pdata->chcr_offset;
-- 
1.7.10.4
