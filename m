From: will.deacon@arm.com (Will Deacon)
Date: Tue, 2 Apr 2013 17:46:38 +0100
Subject: [PATCH v5 1/3] arm: introduce psci_smp_ops
In-Reply-To: <1364919374-7836-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1304021700380.5078@kaball.uk.xensource.com>
 <1364919374-7836-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20130402164638.GG6608@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 05:16:12PM +0100, Stefano Stabellini wrote:
> Rename virt_smp_ops to psci_smp_ops and move them to arch/arm/kernel/psci_smp.c.
> Remove mach-virt/platsmp.c, now unused.
> Compile psci_smp if CONFIG_ARM_PSCI and CONFIG_SMP.
> 
> Add a cpu_die smp_op based on psci_ops.cpu_off.
> 
> Initialize PSCI before setting smp_ops in setup_arch.
> Use psci_smp_ops if the platform doesn't provide its own smp_ops.
> 
> 
> Changes in v5:
> - document psci_operations;
> - psci_init returns NULL.
> 
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> CC: will.deacon at arm.com
> CC: arnd at arndb.de
> CC: marc.zyngier at arm.com
> CC: linux at arm.linux.org.uk
> CC: nico at linaro.org
> ---
>  arch/arm/include/asm/psci.h  |   29 ++++++++++++++++++
>  arch/arm/kernel/Makefile     |    5 ++-
>  arch/arm/kernel/psci.c       |    7 ++--
>  arch/arm/kernel/psci_smp.c   |   67 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/setup.c      |    7 ++++-
>  arch/arm/mach-virt/Makefile  |    1 -
>  arch/arm/mach-virt/platsmp.c |   58 ------------------------------------
>  arch/arm/mach-virt/virt.c    |    3 --
>  8 files changed, 109 insertions(+), 68 deletions(-)
>  create mode 100644 arch/arm/kernel/psci_smp.c
>  delete mode 100644 arch/arm/mach-virt/platsmp.c

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
