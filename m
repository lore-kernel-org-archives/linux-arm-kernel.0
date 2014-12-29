From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:47:06 +0900
Subject: [PATCH 3/4] ARM: shmobile: r8a7779: No TWD setup in C for
 Multiplatform
In-Reply-To: <cover.1419810196.git.horms+renesas@verge.net.au>
References: <cover.1419810196.git.horms+renesas@verge.net.au>
Message-ID: <1dc13eee3a5c60131657482aa88c997e5fa8b50c.1419810196.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Skip the TWD setup in C for r8a7779 Multiplatform.
We should use DTS for the TWD device anyway.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7779.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 3f761f8..9fc280e 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -56,7 +56,7 @@ static struct rcar_sysc_ch *r8a7779_ch_cpu[4] = {
 	[3] = &r8a7779_ch_cpu3,
 };
 
-#ifdef CONFIG_HAVE_ARM_TWD
+#if defined(CONFIG_HAVE_ARM_TWD) && !defined(CONFIG_ARCH_MULTIPLATFORM)
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, R8A7779_SCU_BASE + 0x600, 29);
 void __init r8a7779_register_twd(void)
 {
-- 
2.1.3
