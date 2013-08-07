From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:38:35 +0900
Subject: [GIT PULL 08/26] ARM: shmobile: Use default ->init_time() on r8a7778
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
Message-ID: <0765f48a214af1ea9dd5ac7e3804c00ad6d16e15.1375840527.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Leave ->init_time() set to NULL to use the default ARM behaviour.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7778.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 1a154d4..604cf36 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -406,7 +406,6 @@ static const char *r8a7778_compat_dt[] __initdata = {
 DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
-	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a7778_compat_dt,
 	.init_late      = r8a7778_init_late,
 MACHINE_END
-- 
1.8.3.2
