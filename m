From: josh.cartwright@ni.com (Josh Cartwright)
Date: Mon, 22 Oct 2012 10:37:00 -0500
Subject: [PATCH 1/4] ARM: annotate VMALLOC_END definition with _AC
Message-ID: <20121022153700.GA502@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the definition of VMALLOC_END suitable for use within
assembly code.  This is necessary to allow the use of VMALLOC_END in
defining where the early uart is mapped for use with DEBUG_LL.

Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 08c1231..72904a2 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -40,7 +40,7 @@
  */
 #define VMALLOC_OFFSET		(8*1024*1024)
 #define VMALLOC_START		(((unsigned long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
-#define VMALLOC_END		0xff000000UL
+#define VMALLOC_END		_AC(0xff000000,UL)
 
 #define LIBRARY_TEXT_START	0x0c000000
 
-- 
1.8.0
