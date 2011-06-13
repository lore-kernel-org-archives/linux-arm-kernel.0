From: ccross@android.com (Colin Cross)
Date: Sun, 12 Jun 2011 17:45:59 -0700
Subject: [PATCH] ARM: gic: Allow gic arch extensions to provide irqchip flags
Message-ID: <1307925960-28839-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra can benefit from the IRQCHIP_MASK_ON_SUSPEND flag, allow it
to be passed to the gic irq chip.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/common/gic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 8d62e07..a6c28a0 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -576,6 +576,7 @@ void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
 	if (gic_nr == 0)
 		gic_cpu_base_addr = cpu_base;
 
+	gic_chip.flags |= gic_arch_extn.flags;
 	gic_dist_init(gic, irq_start);
 	gic_cpu_init(gic);
 	gic_cpu_pm_init(gic);
-- 
1.7.4.1
