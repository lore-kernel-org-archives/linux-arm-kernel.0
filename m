From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 21 Sep 2016 13:26:31 +0300
Subject: [PATCH v2 3/9] dmaengine: edma: Use correct type for
 of_find_property() third parameter
In-Reply-To: <20160921102637.24845-1-peter.ujfalusi@ti.com>
References: <20160921102637.24845-1-peter.ujfalusi@ti.com>
Message-ID: <20160921102637.24845-4-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The correct type is int and not for the third parameter of
of_find_property().
Fixes compilation for 64bit architectures (x86_64, aarch64).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 4c8818278fcc..16c0bb92fa4d 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -2024,8 +2024,7 @@ static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
 {
 	struct edma_soc_info *info;
 	struct property *prop;
-	size_t sz;
-	int ret;
+	int sz, ret;
 
 	info = devm_kzalloc(dev, sizeof(struct edma_soc_info), GFP_KERNEL);
 	if (!info)
-- 
2.10.0
