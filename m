From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Sep 2016 09:41:38 +0200
Subject: [PATCH 2/3] ARM: shmobile: r8a7790: only use smp_init when SMP is
 selected
In-Reply-To: <cover.1473233986.git.horms+renesas@verge.net.au>
References: <cover.1473233986.git.horms+renesas@verge.net.au>
Message-ID: <274607942b789f3a26a11f68464f1f0c15995e87.1473233986.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We use the helper function which populates the smp_init pointer only in
case of SMP.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 3506327e0bed..78d3e859bd64 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -28,7 +28,7 @@ static const char * const r8a7790_boards_compat_dt[] __initconst = {
 };
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
-	.smp_init	= shmobile_smp_init_fallback_ops,
+	.smp_init	= smp_init_ops(shmobile_smp_init_fallback_ops),
 	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
-- 
2.7.0.rc3.207.g0ac5344
