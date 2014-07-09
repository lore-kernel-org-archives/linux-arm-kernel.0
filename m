From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 09 Jul 2014 15:30:12 +0400
Subject: [RFC/PATCH RESEND -next 18/21] arm: mm: reserve shadow memory for
 kasan
In-Reply-To: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <1404905415-9046-19-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/arm/mm/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 659c75d..02fce2c 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -22,6 +22,7 @@
 #include <linux/memblock.h>
 #include <linux/dma-contiguous.h>
 #include <linux/sizes.h>
+#include <linux/kasan.h>
 
 #include <asm/cp15.h>
 #include <asm/mach-types.h>
@@ -324,6 +325,8 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
 	 */
 	dma_contiguous_reserve(min(arm_dma_limit, arm_lowmem_limit));
 
+	kasan_alloc_shadow();
+
 	arm_memblock_steal_permitted = false;
 	memblock_dump_all();
 }
-- 
1.8.5.5
