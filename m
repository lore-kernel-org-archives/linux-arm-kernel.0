From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:44:14 +0900
Subject: [PATCH 04/11] ARM: shmobile: r8a7778: Fix shmobile_init_late()
In-Reply-To: <cover.1408671240.git.horms+renesas@verge.net.au>
References: <cover.1408671240.git.horms+renesas@verge.net.au>
Message-ID: <7759a7a8e9b07a9046c1bdb2cd4c9ce197280392.1408671240.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Fix r8a7778 SoC machine vector to include shmobile_init_late()
so Suspend-to-RAM and CPUIdle are setup and platform devices
are omitted as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7778.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 383e43b..e1a477b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -610,8 +610,8 @@ static const char *r8a7778_compat_dt[] __initdata = {
 DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7778_compat_dt,
-	.init_late      = r8a7778_init_late,
 MACHINE_END
 
 #endif /* CONFIG_USE_OF */
-- 
2.0.1
