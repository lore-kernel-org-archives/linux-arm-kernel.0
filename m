From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 20 Sep 2012 22:19:40 +0200
Subject: [PATCH 5/10] ARM: fix DMA-bounce code to allow sync from_device and
 to_device with bidirectional mappings.
In-Reply-To: <m3txus4hgm.fsf@intrepid.localdomain> (Krzysztof Halasa's message
 of "Thu, 20 Sep 2012 21:33:45 +0200")
References: <m3txus4hgm.fsf@intrepid.localdomain>
Message-ID: <m3ipb830rn.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>

--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -375,7 +375,7 @@ static int __dmabounce_sync_for_cpu(struct device *dev, dma_addr_t addr,
 
 	off = addr - buf->safe_dma_addr;
 
-	BUG_ON(buf->direction != dir);
+	BUG_ON(buf->direction != dir && buf->direction != DMA_BIDIRECTIONAL);
 
 	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x off=%#lx) mapped to %p (dma=%#x)\n",
 		__func__, buf->ptr, virt_to_dma(dev, buf->ptr), off,
@@ -415,7 +415,7 @@ static int __dmabounce_sync_for_device(struct device *dev, dma_addr_t addr,
 
 	off = addr - buf->safe_dma_addr;
 
-	BUG_ON(buf->direction != dir);
+	BUG_ON(buf->direction != dir && buf->direction != DMA_BIDIRECTIONAL);
 
 	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x off=%#lx) mapped to %p (dma=%#x)\n",
 		__func__, buf->ptr, virt_to_dma(dev, buf->ptr), off,

-- 
Krzysztof Halasa
