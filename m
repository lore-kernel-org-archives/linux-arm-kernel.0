From: nm@ti.com (Nishanth Menon)
Date: Thu, 8 Jan 2015 10:57:17 -0600
Subject: [PATCH v2 14/21] ARM: imx6: convert GPC to stacked domains
In-Reply-To: <1420652576-22309-15-git-send-email-marc.zyngier@arm.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150108165717.GA19124@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:42-20150107, Marc Zyngier wrote:
> IMX6 has been (ab)using the gic_arch_extn to provide
> wakeup from suspend, and it makes a lot of sense to convert
> this code to use stacked domains instead.
> 
> This patch does just this, updating the DT files to actually
> reflect what the HW provides.
> 
minor checkpatch warnings below:

@@ -0,0 +1,14 @@
+CHECK: Alignment should match open parenthesis
+#249: FILE: arch/arm/mach-imx/gpc.c:158:
++static int imx_gpc_domain_alloc(struct irq_domain *domain,
++				  unsigned int virq,
+WARNING: line over 80 characters
+#272: FILE: arch/arm/mach-imx/gpc.c:181:
++	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
+ERROR: code indent should use tabs where possible
+#305: FILE: arch/arm/mach-imx/gpc.c:209:
++^I        return -ENOMEM;$
+NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
+      scripts/cleanfile
-- 
Regards,
Nishanth Menon
