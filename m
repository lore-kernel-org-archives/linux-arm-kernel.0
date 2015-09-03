From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 03 Sep 2015 16:20:18 +0300
Subject: PING-2: [PATCH v2 TRIVIAL] Enable GICv2m on ARM virt machine
Message-ID: <018d01d0e64b$47cce390$d766aab0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Knock-knock!

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia


> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Pavel
> Fedin
> Sent: Friday, August 07, 2015 1:51 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: 'Marc Zyngier'; trivial at kernel.org; 'Russell King'
> Subject: [PATCH v2 TRIVIAL] Enable GICv2m on ARM virt machine
> 
> qemu implementation of "virt" includes GICv2m. This commit allows to use
> it also on ARM32 architecture.
> 
> msi.h is added because it is required by linux/msi.h
> if CONFIG_GENERIC_MSI_IRQ_DOMAIN is defined. It gets enabled by the
> following KConfig dependency chain:
> ARM_GIC_V2M => PCI_MSI_IRQ_DOMAIN => GENERIC_MSI_IRQ_DOMAIN
> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
> v1 => v2:
> Added verbose explanation in commit message
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
> --
> 1.9.5.msysgit.0
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
