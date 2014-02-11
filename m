From: vkale@apm.com (Vinayak Kale)
Date: Tue, 11 Feb 2014 14:40:11 +0530
Subject: [PATCH RESEND] arm: add DSB after icache flush in __flush_icache_all()
Message-ID: <1392109811-8525-1-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DSB after icache flush to complete the cache maintenance operation.

Signed-off-by: Vinayak Kale <vkale@apm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---

PS:
- This patch is tested for ARM-v7.

 arch/arm/include/asm/cacheflush.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index ee753f1..ab91ebb 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -212,6 +212,7 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
 static inline void __flush_icache_all(void)
 {
 	__flush_icache_preferred();
+	dsb();
 }
 
 /*
-- 
1.7.9.5
