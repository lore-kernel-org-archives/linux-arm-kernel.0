From: liuwenliang@huawei.com (Abbott Liu)
Date: Wed, 11 Oct 2017 16:22:27 +0800
Subject: [PATCH 11/11] Add KASan layout
In-Reply-To: <20171011082227.20546-1-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
Message-ID: <20171011082227.20546-12-liuwenliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add KASan layout into virtual kernel memory layout.

Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/arm/mm/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index ad80548..b490cf4 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -537,6 +537,9 @@ void __init mem_init(void)
 #ifdef CONFIG_MODULES
 			"    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
 #endif
+#ifdef CONFIG_KASAN
+			"    kasan   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+#endif
 			"      .text : 0x%p" " - 0x%p" "   (%4td kB)\n"
 			"      .init : 0x%p" " - 0x%p" "   (%4td kB)\n"
 			"      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
@@ -557,6 +560,9 @@ void __init mem_init(void)
 #ifdef CONFIG_MODULES
 			MLM(MODULES_VADDR, MODULES_END),
 #endif
+#ifdef CONFIG_KASAN
+			MLM(KASAN_SHADOW_START, KASAN_SHADOW_END),
+#endif
 
 			MLK_ROUNDUP(_text, _etext),
 			MLK_ROUNDUP(__init_begin, __init_end),
-- 
2.9.0
