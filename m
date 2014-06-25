From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 Jun 2014 16:35:16 +0900
Subject: [PATCH 04/14] ARM: shmobile: r8a7791: Support Core-Standby for
 Suspend to RAM
In-Reply-To: <cover.1403681315.git.horms+renesas@verge.net.au>
References: <cover.1403681315.git.horms+renesas@verge.net.au>
Message-ID: <7f6234013a835476f1503be2c9287f1fe3497457.1403681315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: keita kobayashi <keita.kobayashi.ym@renesas.com>

Add r8a7791 Core-Standby state for Suspend to RAM support.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7791.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index 1772086..c6543b6 100644
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ b/arch/arm/mach-shmobile/smp-r8a7791.c
@@ -52,6 +52,7 @@ static void __init r8a7791_smp_prepare_cpus(unsigned int max_cpus)
 	iounmap(p);
 
 	r8a7791_pm_init();
+	shmobile_smp_apmu_suspend_init();
 }
 
 static int r8a7791_smp_boot_secondary(unsigned int cpu,
-- 
2.0.0.rc2
