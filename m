From: cyril@ti.com (Cyril Chemparathy)
Date: Fri, 21 Sep 2012 11:56:10 -0400
Subject: [PATCH v3 RESEND 12/17] ARM: LPAE: define ARCH_LOW_ADDRESS_LIMIT for
 bootmem
In-Reply-To: <1348242975-19184-1-git-send-email-cyril@ti.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
Message-ID: <1348242975-19184-13-git-send-email-cyril@ti.com>
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
index f3e8f88..19221c2 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -315,6 +315,8 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
 #define arch_is_coherent()		0
 #endif
 
+#define ARCH_LOW_ADDRESS_LIMIT		PHYS_MASK
+
 #endif
 
 #include <asm-generic/memory_model.h>
-- 
1.7.9.5
