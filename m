From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 17:59:52 +0900
Subject: [PATCH 11/12] ARM: shmobile: fix sleep-r8a7740.S miscompiles
In-Reply-To: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645193-3595-12-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added sleep-r8a7740.S file in shmobile does not
actually build because of renamed symbols.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Bastian Hecht <hechtb+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/sleep-r8a7740.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
1.7.10.4
