From: labbott@redhat.com (Laura Abbott)
Date: Thu, 14 Dec 2017 14:39:14 -0800
Subject: [RFC][PATCH] arm64: Switch to %px for printing some addresses at
 bootup
Message-ID: <20171214223914.12532-1-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the move to stricter %p printing, several of the addresses
are no longer printed out. Switch to %px so they always get printed.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
I'll admit to finding the new %p restrictions particularly irritating
here because I like seeing the print out of the virtual addresses for
debugging and checking. It might also be worth discussing whether we
should be printing anything out?
---
 arch/arm64/mm/init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 5960bef0170d..9be53e050f50 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -613,15 +613,15 @@ void __init mem_init(void)
 		MLM(MODULES_VADDR, MODULES_END));
 	pr_notice("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n",
 		MLG(VMALLOC_START, VMALLOC_END));
-	pr_notice("      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("      .text : 0x%px" " - 0x%px" "   (%6ld KB)\n",
 		MLK_ROUNDUP(_text, _etext));
-	pr_notice("    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("    .rodata : 0x%px" " - 0x%px" "   (%6ld KB)\n",
 		MLK_ROUNDUP(__start_rodata, __init_begin));
-	pr_notice("      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("      .init : 0x%px" " - 0x%px" "   (%6ld KB)\n",
 		MLK_ROUNDUP(__init_begin, __init_end));
-	pr_notice("      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("      .data : 0x%px" " - 0x%px" "   (%6ld KB)\n",
 		MLK_ROUNDUP(_sdata, _edata));
-	pr_notice("       .bss : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("       .bss : 0x%px" " - 0x%px" "   (%6ld KB)\n",
 		MLK_ROUNDUP(__bss_start, __bss_stop));
 	pr_notice("    fixed   : 0x%16lx - 0x%16lx   (%6ld KB)\n",
 		MLK(FIXADDR_START, FIXADDR_TOP));
-- 
2.14.3
