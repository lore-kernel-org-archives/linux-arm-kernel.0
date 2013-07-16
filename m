From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 16 Jul 2013 20:10:46 +0800
Subject: [PATCH] ARM: OMAP: dma: fix error return code in
 omap_system_dma_probe()
Message-ID: <CAPgLHd-yE_qW1NeK5KkPSUtA1wGfQcnROywrcfa7cH+Dtwfezw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/plat-omap/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 4d463ca..0376606 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2083,6 +2083,7 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 		dma_irq = platform_get_irq_byname(pdev, irq_name);
 		if (dma_irq < 0) {
 			dev_err(&pdev->dev, "failed: request IRQ %d", dma_irq);
+			ret = dma_irq;
 			goto exit_dma_lch_fail;
 		}
 		ret = setup_irq(dma_irq, &omap24xx_dma_irq);
