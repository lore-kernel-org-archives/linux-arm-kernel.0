From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 May 2013 16:42:27 +0100
Subject: [PATCH v4 21/32] arm64: KVM: Build system integration
In-Reply-To: <1368540840-26750-22-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-22-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130521154227.GM27002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 03:13:49PM +0100, Marc Zyngier wrote:
> --- /dev/null
> +++ b/arch/arm64/kvm/Kconfig
...
> +config KVM_ARM_VGIC
> +        bool
> +	depends on KVM_ARM_HOST && OF
> +	select HAVE_KVM_IRQCHIP
> +	---help---
> +	  Adds support for a hardware assisted, in-kernel GIC emulation.
> +
> +config KVM_ARM_TIMER
> +        bool
> +	depends on KVM_ARM_VGIC
> +	select HAVE_KVM_IRQCHIP
> +	---help---
> +	  Adds support for the Architected Timers in virtual machines
> +
> +source drivers/virtio/Kconfig

Shouldn't the above configs go to drivers/virtio/Kconfig as well (or
drivers/virtio/arm/Kconfig)?

-- 
Catalin
