From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 10 Nov 2012 23:52:21 +0400
Subject: [PATCH v4 13/13] ARM: KVM: Add VGIC configuration option
In-Reply-To: <20121110154546.3061.12922.stgit@chazy-air>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154546.3061.12922.stgit@chazy-air>
Message-ID: <509EB075.70508@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10-11-2012 19:45, Christoffer Dall wrote:

> From: Marc Zyngier <marc.zyngier@arm.com>

> It is now possible to select the VGIC configuration option.

> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> ---
>   arch/arm/kvm/Kconfig |    7 +++++++
>   1 file changed, 7 insertions(+)

> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index bfa3174..3c979ce 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -51,6 +51,13 @@ config KVM_ARM_MAX_VCPUS
>   	  large, so only choose a reasonable number that you expect to
>   	  actually use.
>
> +config KVM_ARM_VGIC
> +        bool "KVM support for Virtual GIC"

    Indent with tabs uniformaly, please.

> +	depends on KVM_ARM_HOST && OF
> +	select HAVE_KVM_IRQCHIP
> +	---help---
> +	  Adds support for a hardware assisted, in-kernel GIC emulation.
> +

WBR, Sergei
