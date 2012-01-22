From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 22 Jan 2012 12:13:27 +0100
Subject: [RFC PATCH 01/11] ARM: only show modules in the memory layout for
 MODULES=y
In-Reply-To: <20120122111230.GB14835@pengutronix.de>
References: <20120122111230.GB14835@pengutronix.de>
Message-ID: <1327230817-12855-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This line is irritating and wrong when modules are not supported, so
don't show it then.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mm/init.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 6ec1226..42d906f 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -659,7 +659,9 @@ void __init mem_init(void)
 #ifdef CONFIG_HIGHMEM
 			"    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
 #endif
+#ifdef CONFIG_MODULES
 			"    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+#endif
 			"      .text : 0x%p" " - 0x%p" "   (%4d kB)\n"
 			"      .init : 0x%p" " - 0x%p" "   (%4d kB)\n"
 			"      .data : 0x%p" " - 0x%p" "   (%4d kB)\n"
@@ -678,7 +680,9 @@ void __init mem_init(void)
 			MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP) *
 				(PAGE_SIZE)),
 #endif
+#ifdef CONFIG_MODULES
 			MLM(MODULES_VADDR, MODULES_END),
+#endif
 
 			MLK_ROUNDUP(_text, _etext),
 			MLK_ROUNDUP(__init_begin, __init_end),
-- 
1.7.8.3
