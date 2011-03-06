From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun,  6 Mar 2011 18:46:26 +0300
Subject: [PATCH] [ARM] tlb: fix build error with CONFIG_SWAP=n
Message-ID: <1299426386-28746-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix this build error with CONFIG_SWAP=n:

In file included from arch/arm/mm/init.c:28:
arch/arm/include/asm/tlb.h: In function ?tlb_flush_mmu?:
arch/arm/include/asm/tlb.h:104: error: implicit declaration of function ?release_pages?
arch/arm/include/asm/tlb.h: In function ?tlb_remove_page?:
arch/arm/include/asm/tlb.h:168: error: implicit declaration of function ?page_cache_release?

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/include/asm/tlb.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 82dfe5d..36e75e5 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -29,6 +29,7 @@
 
 #else /* !CONFIG_MMU */
 
+#include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-- 
1.7.2.3
