From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:38:33 +0900
Subject: [GIT PULL 06/26] ARM: shmobile: Use default ->init_time() on r8a73a4
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
Message-ID: <58909ae593e8e6fc7e89d88ffe61effedf09389a.1375840527.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Leave ->init_time() set to NULL to use the default ARM behaviour.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a73a4.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 2ee45d5..8949170 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -223,7 +223,6 @@ static const char *r8a73a4_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
 	.init_early	= r8a73a4_init_delay,
-	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a73a4_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
1.8.3.2
