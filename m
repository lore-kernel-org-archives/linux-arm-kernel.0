From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 10:32:05 +0530
Subject: [PATCH 10/16] ARM: tegra: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1479099731-28108-11-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now as we have of_scu_enable which takes care of mapping
scu base from DT, lets use it.

CC: Stephen Warren <swarren@wwwdotorg.org>
CC: linux-tegra at vger.kernel.org
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-tegra/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 75620ae..3467617 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -179,7 +179,7 @@ static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
 	cpumask_set_cpu(0, &tegra_cpu_init_mask);
 
 	if (scu_a9_has_base())
-		scu_enable(IO_ADDRESS(scu_a9_get_base()));
+		of_scu_enable();
 }
 
 const struct smp_operations tegra_smp_ops __initconst = {
-- 
2.7.4
