From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 26 Nov 2014 17:58:58 +0100
Subject: [RFC PATCH 4/5] ARM: enable linking against eventfd and irqchip
In-Reply-To: <20141124212706.10605.50148.stgit@i3820>
References: <20141124212240.10605.46770.stgit@i3820>
 <20141124212706.10605.50148.stgit@i3820>
Message-ID: <547606D2.8000101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2014 10:27 PM, Nikolay Nikolaev wrote:
> This enables compilation of the eventfd feature on ARM.
Hi Nikolay,

why irqchip in the title?

Best Regards

Eric
> 
> Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
> ---
>  arch/arm/kvm/Kconfig  |    1 +
>  arch/arm/kvm/Makefile |    2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index 466bd29..a4b0312 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -20,6 +20,7 @@ config KVM
>  	bool "Kernel-based Virtual Machine (KVM) support"
>  	select PREEMPT_NOTIFIERS
>  	select ANON_INODES
> +	select HAVE_KVM_EVENTFD
>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
>  	select KVM_MMIO
>  	select KVM_ARM_HOST
> diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
> index 443b8be..539c1a5 100644
> --- a/arch/arm/kvm/Makefile
> +++ b/arch/arm/kvm/Makefile
> @@ -15,7 +15,7 @@ AFLAGS_init.o := -Wa,-march=armv7-a$(plus_virt)
>  AFLAGS_interrupts.o := -Wa,-march=armv7-a$(plus_virt)
>  
>  KVM := ../../../virt/kvm
> -kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o
> +kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o
>  
>  obj-y += kvm-arm.o init.o interrupts.o
>  obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
> 
