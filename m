From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 15 Mar 2016 17:47:10 +0800
Subject: [PATCH] arm64: drop unused __local_flush_icache_all()
Message-ID: <1458035230-1038-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit 65da0a8e34a8 ("arm64: use non-global mappings for UEFI
runtime regions"), nobody use __local_flush_icache_all() anymore,
so drop it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/include/asm/cacheflush.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 22dda61..c64268d 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -116,13 +116,6 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
 
-static inline void __local_flush_icache_all(void)
-{
-	asm("ic iallu");
-	dsb(nsh);
-	isb();
-}
-
 static inline void __flush_icache_all(void)
 {
 	asm("ic	ialluis");
-- 
2.6.0.GIT
