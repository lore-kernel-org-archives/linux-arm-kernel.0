From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 6 Jul 2015 14:24:50 +0200
Subject: [RFC v2 1/6] KVM: arm/arm64: select IRQ_BYPASS_MANAGER
In-Reply-To: <1436184692-20927-2-git-send-email-eric.auger@linaro.org>
References: <1436184692-20927-1-git-send-email-eric.auger@linaro.org>
 <1436184692-20927-2-git-send-email-eric.auger@linaro.org>
Message-ID: <559A7392.9020002@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/07/2015 14:11, Eric Auger wrote:
> Select IRQ_BYPASS_MANAGER when CONFIG_KVM is set
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> v1 -> v2:
> - also set IRQ_BYPASS_MANAGER for arm64
> ---
>  arch/arm/kvm/Kconfig   | 1 +
>  arch/arm64/kvm/Kconfig | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index bfb915d..7d38d25 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -31,6 +31,7 @@ config KVM
>  	select KVM_VFIO
>  	select HAVE_KVM_EVENTFD
>  	select HAVE_KVM_IRQFD
> +	select IRQ_BYPASS_MANAGER
>  	depends on ARM_VIRT_EXT && ARM_LPAE && ARM_ARCH_TIMER
>  	---help---
>  	  Support hosting virtualized guest machines.
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index bfffe8f..d1922b4 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -31,6 +31,7 @@ config KVM
>  	select KVM_VFIO
>  	select HAVE_KVM_EVENTFD
>  	select HAVE_KVM_IRQFD
> +	select HAVE_KVM_IRQFD

Obvious pasto. :)

Paolo

>  	---help---
>  	  Support hosting virtualized guest machines.
>  
> 
