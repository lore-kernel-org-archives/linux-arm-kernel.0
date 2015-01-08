From: nm@ti.com (Nishanth Menon)
Date: Thu, 8 Jan 2015 09:06:09 -0600
Subject: [PATCH v2 02/21] irqchip: tegra: add DT-based support for legacy
 interrupt controller
In-Reply-To: <1420652576-22309-3-git-send-email-marc.zyngier@arm.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150108150608.GA24654@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:42-20150107, Marc Zyngier wrote:
> Tegra's LIC (Legacy Interrupt Controller) has been so far only
> supported as a weird extension of the GIC, which is not exactly
> pretty.
> 
> The stacked irq domain framework fits this pretty well, and allows
> the LIC code to be turned into a standalone irqchip. In the process,
> make the driver DT aware, something that was sorely missing from
> the mach-tegra implementation.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

Saw a few checkpatch warnings as below: all of them seem minors.

@@ -0,0 +1,35 @@
+WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
+#36: 
+new file mode 100644
+WARNING: line over 80 characters
+#169: FILE: drivers/irqchip/irq-tegra.c:129:
++		tegra_ictlr_info->cpu_ier[i] = readl_relaxed(ictlr + ICTLR_CPU_IER);
+WARNING: line over 80 characters
+#170: FILE: drivers/irqchip/irq-tegra.c:130:
++		tegra_ictlr_info->cpu_iep[i] = readl_relaxed(ictlr + ICTLR_CPU_IEP_CLASS);
+WARNING: line over 80 characters
+#171: FILE: drivers/irqchip/irq-tegra.c:131:
++		tegra_ictlr_info->cop_ier[i] = readl_relaxed(ictlr + ICTLR_COP_IER);
+WARNING: line over 80 characters
+#172: FILE: drivers/irqchip/irq-tegra.c:132:
++		tegra_ictlr_info->cop_iep[i] = readl_relaxed(ictlr + ICTLR_COP_IEP_CLASS);
+WARNING: line over 80 characters
+#181: FILE: drivers/irqchip/irq-tegra.c:141:
++		writel_relaxed(tegra_ictlr_info->ictlr_wake_mask[i], ictlr + ICTLR_CPU_IER_SET);
+WARNING: Missing a blank line after declarations
+#196: FILE: drivers/irqchip/irq-tegra.c:156:
++		void __iomem *ictlr = tegra_ictlr_info->ictlr_reg_base[i];
++		writel_relaxed(tegra_ictlr_info->cpu_iep[i],
+WARNING: line over 80 characters
+#284: FILE: drivers/irqchip/irq-tegra.c:244:
++	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
+CHECK: Please don't use multiple blank lines
+#287: FILE: drivers/irqchip/irq-tegra.c:247:
++
++
+WARNING: Missing a blank line after declarations
+#296: FILE: drivers/irqchip/irq-tegra.c:256:
++		struct irq_data *d = irq_domain_get_irq_data(domain, virq + i);
++		irq_domain_reset_irq_data(d);
`
-- 
Regards,
Nishanth Menon
