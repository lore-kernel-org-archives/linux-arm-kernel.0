From: swarren@nvidia.com (Stephen Warren)
Date: Tue,  6 Dec 2011 11:50:26 -0700
Subject: [PATCH] highmem: Fix ARM build break due to __kmap_atomic rename
Message-ID: <1323197426-10815-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Git commit 37bfbb9 "highmem: kill all __kmap_atomic()" renamed
__kmap_atomic to kmap_atomic. However, arch/arm/include/asm/highmem.h
wasn't updated for that change. This change does so, and fixes the
ARM build break.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This shows up in next-20111206 at least.

 arch/arm/include/asm/highmem.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index a4edd19..8c5e828 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -57,7 +57,7 @@ static inline void *kmap_high_get(struct page *page)
 #ifdef CONFIG_HIGHMEM
 extern void *kmap(struct page *page);
 extern void kunmap(struct page *page);
-extern void *__kmap_atomic(struct page *page);
+extern void *kmap_atomic(struct page *page);
 extern void __kunmap_atomic(void *kvaddr);
 extern void *kmap_atomic_pfn(unsigned long pfn);
 extern struct page *kmap_atomic_to_page(const void *ptr);
-- 
1.7.0.4
