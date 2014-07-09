From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 09 Jul 2014 15:30:00 +0400
Subject: [RFC/PATCH RESEND -next 06/21] x86: mm: init: allocate shadow memory
 for kasan
In-Reply-To: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <1404905415-9046-7-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/x86/mm/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index f971306..d9925ee 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -4,6 +4,7 @@
 #include <linux/swap.h>
 #include <linux/memblock.h>
 #include <linux/bootmem.h>	/* for max_low_pfn */
+#include <linux/kasan.h>
 
 #include <asm/cacheflush.h>
 #include <asm/e820.h>
@@ -678,5 +679,7 @@ void __init zone_sizes_init(void)
 #endif
 
 	free_area_init_nodes(max_zone_pfns);
+
+	kasan_alloc_shadow();
 }
 
-- 
1.8.5.5
