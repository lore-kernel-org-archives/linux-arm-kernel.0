From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:44:13 +0900
Subject: [PATCH 03/11] ARM: shmobile: r8a7779: Fix shmobile_init_late()
In-Reply-To: <cover.1408671240.git.horms+renesas@verge.net.au>
References: <cover.1408671240.git.horms+renesas@verge.net.au>
Message-ID: <d5b00b90705d5fff53f611ba4746d79fedbb52be.1408671240.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Fix r8a7779 SoC machine vector to include shmobile_init_late()
so Suspend-to-RAM and CPUIdle are setup and platform devices
are omitted as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 236c1be..6875a9f 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -774,7 +774,7 @@ DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= r8a7779_add_standard_devices_dt,
-	.init_late	= r8a7779_init_late,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7779_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
2.0.1
