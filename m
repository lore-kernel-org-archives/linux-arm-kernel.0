From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 28 May 2013 17:07:54 +0800
Subject: [PATCH -next] dmaengine: ste_dma40: add missing iounmap() on error in
 d40_probe()
Message-ID: <CAPgLHd9kMzZ_ZY6zm0MZ+P6dHq73i_GdCsxhpUOt-V9nf08tWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing iounmap() before return from d40_probe()
in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/dma/ste_dma40.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 71bf4ec..018c2f7 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3612,6 +3612,8 @@ failure:
 			kmem_cache_destroy(base->desc_slab);
 		if (base->virtbase)
 			iounmap(base->virtbase);
+		if (base->lcpa_base)
+			iounmap(base->lcpa_base);
 
 		if (base->lcla_pool.base && base->plat_data->use_esram_lcla) {
 			iounmap(base->lcla_pool.base);
