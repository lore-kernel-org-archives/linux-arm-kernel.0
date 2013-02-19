From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Feb 2013 11:47:37 +0900
Subject: [PATCH v2 3/8] ARM: shmobile: sh73a0: Add smp ops to DT_MACHINE_START
In-Reply-To: <1361242062-6957-1-git-send-email-horms+renesas@verge.net.au>
References: <1361242062-6957-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1361242062-6957-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This a board to be brought up with SMP enabled
without a board file present.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index fc0c73c..8f00f3a 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -863,6 +863,7 @@ static const char *sh73a0_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
+	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices_dt,
 	.nr_irqs	= NR_IRQS_LEGACY,
-- 
1.7.10.4
