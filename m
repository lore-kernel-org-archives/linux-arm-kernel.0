From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 20 Mar 2012 11:17:36 +0100
Subject: [PATCH] of: dma/fixup
In-Reply-To: <6b5dc1fadfd03a48093338b6981c0a7ae7662212.1332237596.git.nicolas.ferre@atmel.com>
References: <6b5dc1fadfd03a48093338b6981c0a7ae7662212.1332237596.git.nicolas.ferre@atmel.com>
Message-ID: <1332238657-12668-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 include/linux/of_dma.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
index 2865480..da95e37 100644
--- a/include/linux/of_dma.h
+++ b/include/linux/of_dma.h
@@ -18,7 +18,7 @@
 
 struct device_node;
 
-#ifdef CONFIG_OF_DMA
+#ifdef CONFIG_OF
 
 extern int of_dma_controller_register(struct device_node *np,
 			int (*of_dma_xlate)(struct of_phandle_args *, void *));
@@ -29,7 +29,7 @@ extern unsigned int of_dma_count(struct device_node *np);
 
 extern int of_dma_xlate_onenumbercell(struct of_phandle_args *dma_spec,
 				      void *dma_req);
-#else /* CONFIG_OF_DMA */
+#else /* CONFIG_OF */
 
 static int of_dma_controller_register(struct device_node *np,
 			int (*of_dma_xlate)(struct of_phandle_args *, void *))
@@ -55,6 +55,6 @@ static int of_dma_xlate_onenumbercell(struct of_phandle_args *dma_spec,
 {
 	return -ENOSYS;
 }
-#endif /* CONFIG_OF_DMA */
+#endif /* CONFIG_OF */
 
 #endif /* __LINUX_OF_DMA_H */
-- 
1.7.9
