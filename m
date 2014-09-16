From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 16 Sep 2014 10:57:52 +0900
Subject: [PATCH] ARM: shmobile: r8a7794: Remove unnecessary #ifdef
 CONFIG_USE_OF
In-Reply-To: <cover.1410832584.git.horms+renesas@verge.net.au>
References: <cover.1410832584.git.horms+renesas@verge.net.au>
Message-ID: <1370078db37de2aa5e906ae2b5dbbb6ba289adb4.1410832584.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The r8a7794 support is always compiled using ARCH_MULTIPLATFORM which
selects USE_OF. So #ifdef CONFIG_USE_OF is unnecessary.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7794.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7794.c b/arch/arm/mach-shmobile/setup-r8a7794.c
index 05e970c..c10acd1 100644
--- a/arch/arm/mach-shmobile/setup-r8a7794.c
+++ b/arch/arm/mach-shmobile/setup-r8a7794.c
@@ -19,8 +19,6 @@
 #include "rcar-gen2.h"
 #include <asm/mach/arch.h>
 
-#ifdef CONFIG_USE_OF
-
 static const char * const r8a7794_boards_compat_dt[] __initconst = {
 	"renesas,r8a7794",
 	NULL,
@@ -32,4 +30,3 @@ DT_MACHINE_START(R8A7794_DT, "Generic R8A7794 (Flattened Device Tree)")
 	.init_time	= rcar_gen2_timer_init,
 	.dt_compat	= r8a7794_boards_compat_dt,
 MACHINE_END
-#endif /* CONFIG_USE_OF */
-- 
2.0.1
