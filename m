From: vkale@apm.com (Vinayak Kale)
Date: Mon, 27 Jan 2014 17:29:44 +0530
Subject: [PATCH] arm64: add DSB after icache flush in __flush_icache_all()
Message-ID: <1390823984-23046-1-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DSB after icache flush operation.

Signed-off-by: Vinayak Kale <vkale@apm.com>
---
 arch/arm64/include/asm/cacheflush.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index fea9ee3..88932498 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -116,6 +116,7 @@ extern void flush_dcache_page(struct page *);
 static inline void __flush_icache_all(void)
 {
 	asm("ic	ialluis");
+	dsb();
 }
 
 #define flush_dcache_mmap_lock(mapping) \
-- 
1.7.9.5
