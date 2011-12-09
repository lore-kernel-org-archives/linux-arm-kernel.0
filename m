From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  9 Dec 2011 22:31:30 +0100
Subject: [PATCH] ARM: only show modules in the memory layout for MODULES=y
Message-ID: <1323466291-9679-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mm/init.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index fbdd12e..80def74 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -666,7 +666,9 @@ void __init mem_init(void)
 #ifdef CONFIG_HIGHMEM
 			"    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
 #endif
+#ifdef CONFIG_MODULES
 			"    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+#endif
 			"      .text : 0x%p" " - 0x%p" "   (%4d kB)\n"
 			"      .init : 0x%p" " - 0x%p" "   (%4d kB)\n"
 			"      .data : 0x%p" " - 0x%p" "   (%4d kB)\n"
@@ -685,7 +687,9 @@ void __init mem_init(void)
 			MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP) *
 				(PAGE_SIZE)),
 #endif
+#ifdef CONFIG_MODULES
 			MLM(MODULES_VADDR, MODULES_END),
+#endif
 
 			MLK_ROUNDUP(_text, _etext),
 			MLK_ROUNDUP(__init_begin, __init_end),
-- 
1.7.7.3
