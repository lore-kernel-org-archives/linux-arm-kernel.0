From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:43 +0900
Subject: [PATCH 2/9] ARM: shmobile: r8a7779: Generic SMP ops
In-Reply-To: <cover.1437726584.git.horms+renesas@verge.net.au>
References: <cover.1437726584.git.horms+renesas@verge.net.au>
Message-ID: <44ade5edf90ccd38efa741240efb2586239c9751.1437726584.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a r8a7779-specific SMP operation pointer to support
all 4 CPU cores through SMP on r8a7779 without C board code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 5625fd1c89c0..2c3e433f84ca 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -772,6 +772,7 @@ static const char *r8a7779_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
+	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= shmobile_init_delay,
 	.init_time	= r8a7779_init_time,
-- 
2.1.4
