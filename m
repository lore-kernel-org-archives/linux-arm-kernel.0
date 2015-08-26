From: yalin.wang2010@gmail.com (yalin wang)
Date: Wed, 26 Aug 2015 09:24:26 +0800
Subject: [PATCH] arm: insn: use set_fixmap_offset to make it more clear
Message-ID: <1440552266-19940-1-git-send-email-yalin.wang2010@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A little change to patch_map() function,
use set_fixmap_offset() to make code more clear.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 arch/arm/kernel/patch.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index 69bda1a..5779105 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -36,9 +36,8 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 	else
 		__acquire(&patch_lock);
 
-	set_fixmap(fixmap, page_to_phys(page));
-
-	return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
+	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
+			(uintaddr & ~PAGE_MASK));
 }
 
 static void __kprobes patch_unmap(int fixmap, unsigned long *flags)
-- 
1.9.1
