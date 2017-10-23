From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Oct 2017 13:54:14 +0100
Subject: [PATCH] arm64: Fix flush_icache_range prototype
Message-ID: <20171023125414.10758-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

flush_icache_range can return -EFAULT, and yet its prototype
has void as a return type. Fix it by aligning it to that of
__flush_cache_user_range.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/cacheflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 76d1cc85d5b1..377fa6b5d67f 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -65,7 +65,7 @@
  *		- kaddr  - page address
  *		- size   - region size
  */
-extern void flush_icache_range(unsigned long start, unsigned long end);
+extern long flush_icache_range(unsigned long start, unsigned long end);
 extern void __flush_dcache_area(void *addr, size_t len);
 extern void __inval_dcache_area(void *addr, size_t len);
 extern void __clean_dcache_area_poc(void *addr, size_t len);
-- 
2.11.0
