From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:15 -0600
Subject: [PATCH v4 06/19] ARM: GIC: set handle_arch_irq in GIC initialization
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Set handle_arch_irq to gic_handle_irq. Only the first GIC initialized can
setup the handler.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/common/gic.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 788658c..4b4ccf3 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -767,6 +767,9 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
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
