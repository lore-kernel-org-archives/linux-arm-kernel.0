From: labbott@redhat.com (Laura Abbott)
Date: Thu, 17 Nov 2016 17:16:54 -0800
Subject: [PATCHv3 4/6] arm64: Add cast for virt_to_pfn
In-Reply-To: <1479431816-5028-1-git-send-email-labbott@redhat.com>
References: <1479431816-5028-1-git-send-email-labbott@redhat.com>
Message-ID: <1479431816-5028-5-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


virt_to_pfn lacks a cast at the top level. Don't rely on __virt_to_phys
and explicitly cast to unsigned long.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: No change
---
 arch/arm64/include/asm/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b4d2b32..d773e2c 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -204,7 +204,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
-#define virt_to_pfn(x)      __phys_to_pfn(__virt_to_phys(x))
+#define virt_to_pfn(x)      __phys_to_pfn(__virt_to_phys((unsigned long)(x)))
 
 /*
  *  virt_to_page(k)	convert a _valid_ virtual address to struct page *
-- 
2.7.4
