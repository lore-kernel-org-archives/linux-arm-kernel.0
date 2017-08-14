From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 14 Aug 2017 09:55:47 +0100
Subject: [PATCH] arm64: dma-mapping: Mark atomic_pool as __ro_after_init
In-Reply-To: <1502700947-22654-1-git-send-email-vladimir.murzin@arm.com>
References: <1502700947-22654-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1502700947-22654-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

atomic_pool is setup once while init stage and never changed after
that, so it is good candidate for __ro_after_init

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm64/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 7038e1a..614af88 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -42,7 +42,7 @@ static pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot,
 	return prot;
 }
 
-static struct gen_pool *atomic_pool;
+static struct gen_pool *atomic_pool __ro_after_init;
 
 #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
 static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
-- 
2.0.0
