From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 22 Dec 2014 10:35:09 -0500
Subject: [PATCH] dma-mapping: fix debug print to display correct dma_pfn_offset
Message-ID: <1419262509-9811-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix the dev_dbg to display the offset which is the calculated
dma_pfn_offset value and set later in the code.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/of/platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 5b33c6a..a54ec10 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -188,7 +188,7 @@ static void of_dma_configure(struct device *dev)
 		size = dev->coherent_dma_mask;
 	} else {
 		offset = PFN_DOWN(paddr - dma_addr);
-		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
+		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
 	}
 	dev->dma_pfn_offset = offset;
 
-- 
1.7.9.5
