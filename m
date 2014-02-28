From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 27 Feb 2014 19:20:50 -0500
Subject: [PATCH] dma: of: Move the functions under CONFIG_OF_DMA instead of
 CONFIG_OF
Message-ID: <1393546850-13907-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The of-dma.c is compiled out with !CONFIG_OF_DMA but the functions in
the header are kept under CONFIG_OF. Move them under CONFIG_OF_DMA
to avoid build errors with CONFIG_OFF && !CONFIG_OF_DMA

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 include/linux/of_dma.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
index 0322363..3d2beab 100644
--- a/include/linux/of_dma.h
+++ b/include/linux/of_dma.h
@@ -31,7 +31,7 @@ struct of_dma_filter_info {
 	dma_filter_fn	filter_fn;
 };
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_OF_DMA
 extern int of_dma_controller_register(struct device_node *np,
 		struct dma_chan *(*of_dma_xlate)
 		(struct of_phandle_args *, struct of_dma *),
-- 
1.7.9.5
