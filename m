From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 11 Sep 2012 13:39:10 -0400
Subject: [PATCH v3 12/17] ARM: LPAE: define ARCH_LOW_ADDRESS_LIMIT for bootmem
In-Reply-To: <1347385155-11643-1-git-send-email-cyril@ti.com>
References: <1347385155-11643-1-git-send-email-cyril@ti.com>
Message-ID: <1347385155-11643-13-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an architecture defined override for ARCH_LOW_ADDRESS_LIMIT.
On PAE systems, the absence of this override causes bootmem to incorrectly
limit itself to 32-bit addressable physical memory.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---
 arch/arm/include/asm/memory.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 0643454..73caaeb 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -307,6 +307,8 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 #define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
 
+#define ARCH_LOW_ADDRESS_LIMIT		PHYS_MASK
+
 #endif
 
 #include <asm-generic/memory_model.h>
-- 
1.7.9.5
