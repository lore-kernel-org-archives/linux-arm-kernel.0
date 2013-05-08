From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 14:18:04 +0200
Subject: [PATCH] ARM: shmobile: fix sleep-r8a7740.S miscompiles
Message-ID: <201305081418.05091.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added sleep-r8a7740.S file in shmobile does not
actually build because of renamed symbols.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Bastian Hecht <hechtb+renesas@gmail.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
---

Simon, please apply to whichever branch of yours has the broken commit,
or fold this patch into Bastian's patch.

linux-next doesn't build for me because of this, mainline is still fine.

diff --git a/arch/arm/mach-shmobile/sleep-r8a7740.S b/arch/arm/mach-shmobile/sleep-r8a7740.S
index 435531b..982eacb 100644
--- a/arch/arm/mach-shmobile/sleep-r8a7740.S
+++ b/arch/arm/mach-shmobile/sleep-r8a7740.S
@@ -32,7 +32,7 @@ ENTRY(r8a7740_shutdown)
 wfi_loop:
 	bl	cpu_v7_do_idle
 	b wfi_loop
-ENDPROC(r8a7740)
+ENDPROC(r8a7740_shutdown)
 
 	.text
 ENTRY(v7_cpu_resume)
@@ -53,5 +53,5 @@ ENDPROC(v7_cpu_resume)
 ENTRY(r8a7740_resume)
 	ldr	pc, 1f
 1:	.long	v7_cpu_resume - PAGE_OFFSET + PLAT_PHYS_OFFSET
-ENDPROC(r8a7740_resume_core_standby)
+ENDPROC(r8a7740_resume)
 #endif
