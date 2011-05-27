From: rabin@rab.in (Rabin Vincent)
Date: Fri, 27 May 2011 21:27:53 +0530
Subject: [PATCH] ARM: include .bss in memory layout information
Message-ID: <1306511873-19788-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "Virtual memory kernel layout" message at startup already prints
.text and .data.  Print .bss too.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/mm/init.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index e5f6fc4..b58dfe0 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -587,7 +587,8 @@ void __init mem_init(void)
 			"    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
 			"      .init : 0x%p" " - 0x%p" "   (%4d kB)\n"
 			"      .text : 0x%p" " - 0x%p" "   (%4d kB)\n"
-			"      .data : 0x%p" " - 0x%p" "   (%4d kB)\n",
+			"      .data : 0x%p" " - 0x%p" "   (%4d kB)\n"
+			"       .bss : 0x%p" " - 0x%p" "   (%4d kB)\n",
 
 			MLK(UL(CONFIG_VECTORS_BASE), UL(CONFIG_VECTORS_BASE) +
 				(PAGE_SIZE)),
@@ -609,7 +610,8 @@ void __init mem_init(void)
 
 			MLK_ROUNDUP(__init_begin, __init_end),
 			MLK_ROUNDUP(_text, _etext),
-			MLK_ROUNDUP(_sdata, _edata));
+			MLK_ROUNDUP(_sdata, _edata),
+			MLK_ROUNDUP(__bss_start, __bss_stop));
 
 #undef MLK
 #undef MLM
-- 
1.7.5.1
