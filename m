From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:44:16 +0900
Subject: [PATCH 06/11] ARM: shmobile: r7s72100: Add shmobile_init_late()
In-Reply-To: <cover.1408671240.git.horms+renesas@verge.net.au>
References: <cover.1408671240.git.horms+renesas@verge.net.au>
Message-ID: <9b0fd79af38cb1d68f5faf4fb528713116480e9f.1408671240.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend r7s72100 SoC machine vector to include shmobile_init_late()
so Suspend-to-RAM and CPUIdle are setup as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r7s72100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index f3b3b14..8cdc25d 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -53,6 +53,7 @@ static const char *r7s72100_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(R7S72100_DT, "Generic R7S72100 (Flattened Device Tree)")
 	.init_early	= shmobile_init_delay,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= r7s72100_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
2.0.1
