From: miles.chen@mediatek.com (Miles Chen)
Date: Thu, 9 Feb 2017 10:20:07 +0800
Subject: [PATCH] arm64: use is_vmalloc_addr
Message-ID: <1486606807-32097-1-git-send-email-miles.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To is_vmalloc_addr() to check if an address is a vmalloc address
instead of checking VMALLOC_START and VMALLOC_END manually.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 arch/arm64/mm/ioremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 01e88c8..71d6b04 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -88,7 +88,7 @@ void __iounmap(volatile void __iomem *io_addr)
 	 * We could get an address outside vmalloc range in case
 	 * of ioremap_cache() reusing a RAM mapping.
 	 */
-	if (VMALLOC_START <= addr && addr < VMALLOC_END)
+	if (is_vmalloc_addr(addr))
 		vunmap((void *)addr);
 }
 EXPORT_SYMBOL(__iounmap);
-- 
1.9.1
