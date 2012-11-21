From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 Nov 2012 20:58:29 -0600
Subject: [PATCH 5/9] ARM: GIC: set handle_arch_irq in GIC initialization
In-Reply-To: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
Message-ID: <1353466713-18967-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Set handle_arch_irq to gic_handle_irq. Only the first GIC initialized can
setup the handler.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/common/gic.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 9ef226d..5abc750 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -740,6 +740,9 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 #ifdef CONFIG_SMP
 	set_smp_cross_call(gic_raise_softirq);
 #endif
+
+	set_handle_irq(gic_handle_irq);
+
 	gic_chip.flags |= gic_arch_extn.flags;
 	gic_dist_init(gic);
 	gic_cpu_init(gic);
-- 
1.7.10.4
