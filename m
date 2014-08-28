From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Aug 2014 17:31:18 +0200
Subject: [PATCH v4 4/5] ARM: tegra: Remove unused GIC initialization
In-Reply-To: <1409239879-12376-1-git-send-email-thierry.reding@gmail.com>
References: <1409239879-12376-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1409239879-12376-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Tegra has been booting from DT exclusively for quite some time, so this
old code setting up the GIC for non-DT boot is unused and can therefore
be removed.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/irq.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 636ebfd466cb..b1760aa162f1 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -362,14 +362,5 @@ void __init tegra_init_irq(void)
 	gic_arch_extn.irq_set_wake = tegra_set_wake;
 	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
 
-	/*
-	 * Check if there is a devicetree present, since the GIC will be
-	 * initialized elsewhere under DT.
-	 */
-	if (!of_have_populated_dt()) {
-		void __iomem *cpubase = ioremap_nocache(0x50040000, 0x2000);
-		gic_init(0, 29, distbase, cpubase);
-	}
-
 	tegra114_gic_cpu_pm_registration();
 }
-- 
2.0.4
