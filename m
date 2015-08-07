From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 07 Aug 2015 09:52:32 +0100
Subject: [PATCH TRIVIAL] Enable GICv2m on ARM virt machine
In-Reply-To: <00f501d0ce9c$4d57bcc0$e8073640$@samsung.com>
References: <00f501d0ce9c$4d57bcc0$e8073640$@samsung.com>
Message-ID: <55C471D0.8050400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On 04/08/15 10:59, Pavel Fedin wrote:
> qemu implementation of "virt" includes GICv2m. This commit allows to use
> it also on ARM32 architecture.
> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
>  arch/arm/Kconfig            | 1 +
>  arch/arm/include/asm/Kbuild | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 45df48b..1091025 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -815,6 +815,7 @@ config ARCH_VIRT
>  	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
>  	select ARM_AMBA
>  	select ARM_GIC
> +	select ARM_GIC_V2M if PCI_MSI
>  	select ARM_PSCI
>  	select HAVE_ARM_ARCH_TIMER
>  
> diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
> index 3c4596d..01806f5 100644
> --- a/arch/arm/include/asm/Kbuild
> +++ b/arch/arm/include/asm/Kbuild
> @@ -14,6 +14,7 @@ generic-y += local.h
>  generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += msgbuf.h
> +generic-y += msi.h
>  generic-y += param.h
>  generic-y += parport.h
>  generic-y += poll.h
> 

You may want to add a comment about the dependency chain that requires
the generic msi.h.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
