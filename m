From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 13 Oct 2015 21:54:30 +0200
Subject: [PATCH v2 3/3] dmaengine: pxa_dma: declare transfer are reusable
In-Reply-To: <1444766070-26915-1-git-send-email-robert.jarzmik@free.fr>
References: <1444766070-26915-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1444766070-26915-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As this driver provides a mechanism to reuse transfers, declare it in
its probe function.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index fc4156afa070..f2a0310ae771 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1414,6 +1414,7 @@ static int pxad_probe(struct platform_device *op)
 	pdev->slave.dst_addr_widths = widths;
 	pdev->slave.directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 	pdev->slave.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	pdev->slave.descriptor_reuse = true;
 
 	pdev->slave.dev = &op->dev;
 	ret = pxad_init_dmadev(op, pdev, dma_channels);
-- 
2.1.4
