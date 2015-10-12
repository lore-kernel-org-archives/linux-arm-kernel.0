From: yalin.wang2010@gmail.com (yalin wang)
Date: Mon, 12 Oct 2015 14:52:59 +0800
Subject: [RFC] arm64: add kc_offset_to_vaddr and kc_vaddr_to_offset macro
Message-ID: <1444632779-23369-1-git-send-email-yalin.wang2010@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add kc_offset_to_vaddr() and kc_vaddr_to_offset(),
the default version doesn't work on arm64, because arm64 kernel address
is below the PAGE_OFFSET, like module address and vmemmap address are
all below PAGE_OFFSET address.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 arch/arm64/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4331d84..23070a8 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -658,6 +658,8 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 
 #define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
 
+#define	kc_vaddr_to_offset(v) ((v) & ~VA_START)
+#define	kc_offset_to_vaddr(o) ((o) | VA_START)
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
-- 
1.9.1
