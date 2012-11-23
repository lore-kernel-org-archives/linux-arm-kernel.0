From: will.deacon@arm.com (Will Deacon)
Date: Fri, 23 Nov 2012 16:31:09 +0000
Subject: [PATCH v4 5/5] ARM: KVM: arch_timers: Wire the init code and
 config option
In-Reply-To: <20121110154632.3274.37896.stgit@chazy-air>
References: <20121110154554.3274.77777.stgit@chazy-air>
 <20121110154632.3274.37896.stgit@chazy-air>
Message-ID: <20121123163109.GM32200@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:46:32PM +0000, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> It is now possible to select CONFIG_KVM_ARM_TIMER to enable the
> KVM architected timer support.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> ---
>  arch/arm/kvm/Kconfig  |    7 +++++++
>  arch/arm/kvm/Makefile |    1 +
>  arch/arm/kvm/arm.c    |   11 +++++++++++
>  arch/arm/kvm/vgic.c   |    1 +
>  4 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index 3c979ce..eaecb9f 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -58,6 +58,13 @@ config KVM_ARM_VGIC
>  	---help---
>  	  Adds support for a hardware assisted, in-kernel GIC emulation.
>  
> +config KVM_ARM_TIMER
> +        bool "KVM support for Architected Timers"
> +	depends on KVM_ARM_VGIC && ARM_ARCH_TIMER
> +	select HAVE_KVM_IRQCHIP
> +	---help---
> +	  Adds support for the Architected Timers in virtual machines
> +

This should probably be default y

Will
