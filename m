From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 31 Aug 2015 21:18:56 +0800
Subject: [PATCH 1/3] spi: mediatek: remove clk_disable_unprepare()
In-Reply-To: <1441027138-16458-1-git-send-email-leilk.liu@mediatek.com>
References: <1441027138-16458-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1441027138-16458-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes clk_disable_unprepare() in mtk_spi_remove().
clk_disable_prepare/unprepare must be balance, spi-clk is disabled
in mtk_spi_probe, so not needs to disable again.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index d882261..3a177d0 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -630,7 +630,6 @@ static int mtk_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	mtk_spi_reset(mdata);
-	clk_disable_unprepare(mdata->spi_clk);
 	spi_master_put(master);
 
 	return 0;
-- 
1.8.1.1.dirty
