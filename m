From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:53 +0900
Subject: [PATCH 6/9] ARM: shmobile: Use shmobile_init_delay() on r7s72100
In-Reply-To: <cover.1403487831.git.horms+renesas@verge.net.au>
References: <cover.1403487831.git.horms+renesas@verge.net.au>
Message-ID: <b42a6f7e8f22552aad0d8e595cd83f36316e312b.1403487831.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the r7s72100 SoC support code to use shmobile_init_delay()
together with CPU Frequency settings from the DTS. Get rid of the
C code version.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r7s72100.h | 1 -
 arch/arm/mach-shmobile/setup-r7s72100.c        | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r7s72100.h b/arch/arm/mach-shmobile/include/mach/r7s72100.h
index 5f34b20..efb723c 100644
--- a/arch/arm/mach-shmobile/include/mach/r7s72100.h
+++ b/arch/arm/mach-shmobile/include/mach/r7s72100.h
@@ -3,6 +3,5 @@
 
 void r7s72100_add_dt_devices(void);
 void r7s72100_clock_init(void);
-void r7s72100_init_early(void);
 
 #endif /* __ASM_R7S72100_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index 17a74d3..a55d68d 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -43,11 +43,6 @@ void __init r7s72100_add_dt_devices(void)
 	r7s72100_register_mtu2();
 }
 
-void __init r7s72100_init_early(void)
-{
-	shmobile_setup_delay(400, 1, 3); /* Cortex-A9 @ 400MHz */
-}
-
 #ifdef CONFIG_USE_OF
 static const char *r7s72100_boards_compat_dt[] __initdata = {
 	"renesas,r7s72100",
@@ -55,7 +50,7 @@ static const char *r7s72100_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R7S72100_DT, "Generic R7S72100 (Flattened Device Tree)")
-	.init_early	= r7s72100_init_early,
+	.init_early	= shmobile_init_delay,
 	.dt_compat	= r7s72100_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
2.0.0.rc2
