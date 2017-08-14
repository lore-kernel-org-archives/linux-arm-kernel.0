From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 14 Aug 2017 09:44:27 +0100
Subject: [PATCH] ARM: Remove leftover of fixmap_page_table
Message-ID: <1502700269-24384-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fixmap_page_table was removed by commit 836a24183273 (ARM: expand
fixmap region to 3MB), but some traces are still there - get rid of
them.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/highmem.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index 0a0e2d1..61736fd 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -18,7 +18,6 @@
 	} while (0)
 
 extern pte_t *pkmap_page_table;
-extern pte_t *fixmap_page_table;
 
 extern void *kmap_high(struct page *page);
 extern void kunmap_high(struct page *page);
-- 
2.0.0
