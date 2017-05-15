From: tklauser@distanz.ch (Tobias Klauser)
Date: Mon, 15 May 2017 13:40:20 +0200
Subject: [PATCH] arm64: mm: explicity include linux/vmalloc.h
Message-ID: <20170515114020.8198-1-tklauser@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64's mm/mmu.c uses vm_area_add_early, struct vm_area and other
definitions  but relies on implict inclusion of linux/vmalloc.h which
means that changes in other headers could break the build. Thus, add an
explicit include.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/arm64/mm/mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0c429ec6fde8..23c2d89a362e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -31,6 +31,7 @@
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/mm.h>
+#include <linux/vmalloc.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
-- 
2.13.0
