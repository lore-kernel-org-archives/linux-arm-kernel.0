From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Apr 2013 09:59:16 +0100
Subject: [PATCH v9 1/2] arm: introduce psci_smp_ops
In-Reply-To: <1367160650-4888-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1304281544240.5398@kaball.uk.xensource.com>
 <1367160650-4888-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20130429085916.GB8805@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 28, 2013 at 03:50:49PM +0100, Stefano Stabellini wrote:
> Rename virt_smp_ops to psci_smp_ops and move them to arch/arm/kernel/psci_smp.c.
> Remove mach-virt/platsmp.c, now unused.
> Compile psci_smp if CONFIG_ARM_PSCI and CONFIG_SMP.
> 
> Add a cpu_die smp_op based on psci_ops.cpu_off.
> 
> Initialize PSCI before setting smp_ops in setup_arch.
> 
> If PSCI is available on the platform, prefer psci_smp_ops over the
> platform smp_ops.
> 
> Changes in v9:
> - move comment about PSCI interface from psci.h to psci_smp.c.
> 
> Changes in v8:
> - merge "prefer psci_smp_ops over mdesc->smp" into this patch.
> 
> Changes in v6:
> - fixed return values for psci_smp_available and psci_init ifndef
> CONFIG_ARM_PSCI.
> 
> Changes in v5:
> - document psci_operations;
> - psci_init returns NULL.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: Nicolas Pitre <nico@linaro.org>
> CC: Rob Herring <rob.herring@calxeda.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: arnd at arndb.de
> CC: marc.zyngier at arm.com
> CC: linux at arm.linux.org.uk


Acked-by: Will Deacon <will.deacon@arm.com>

Will
