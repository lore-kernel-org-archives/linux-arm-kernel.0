From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:16:23 +0200
Subject: [PATCH 7/8] ARM: shmobile: r8a7790: Prioritize DT APMU support
In-Reply-To: <cover.1467293089.git.horms+renesas@verge.net.au>
References: <cover.1467293089.git.horms+renesas@verge.net.au>
Message-ID: <f5d70b9cee2282ecbd98c60e5faf46a896c188a3.1467293089.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the r8a7790 SoC support code to not configure any non-DT SMP code
in case the DT-based enable-method has been installed already.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 3a18af4922b4..3506327e0bed 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -28,6 +28,7 @@ static const char * const r8a7790_boards_compat_dt[] __initconst = {
 };
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
+	.smp_init	= shmobile_smp_init_fallback_ops,
 	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
-- 
2.7.0.rc3.207.g0ac5344
