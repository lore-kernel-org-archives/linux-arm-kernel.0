From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 26 Feb 2016 23:33:12 +0100
Subject: [PATCH] arm64: mm: list kernel sections in order
Message-ID: <1456525992-17297-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the boot log, instead of listing .init first, list .text, .rodata,
.init and .data in the same order they appear in memory

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e832f4ab0916..be64ff8b4280 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -361,9 +361,9 @@ void __init mem_init(void)
 #endif
 		  "    modules : 0x%16lx - 0x%16lx   (%6ld MB)\n"
 		  "    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n"
-		  "      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n"
 		  "      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n"
 		  "    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n"
+		  "      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n"
 		  "      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n"
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 		  "    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n"
@@ -377,9 +377,9 @@ void __init mem_init(void)
 #endif
 		  MLM(MODULES_VADDR, MODULES_END),
 		  MLG(VMALLOC_START, VMALLOC_END),
-		  MLK_ROUNDUP(__init_begin, __init_end),
 		  MLK_ROUNDUP(_text, __start_rodata),
 		  MLK_ROUNDUP(__start_rodata, _etext),
+		  MLK_ROUNDUP(__init_begin, __init_end),
 		  MLK_ROUNDUP(_sdata, _edata),
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 		  MLG(VMEMMAP_START,
-- 
2.5.0
