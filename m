From: cdall@linaro.org (Christoffer Dall)
Date: Sat, 26 Aug 2017 21:49:38 +0200
Subject: [PATCH v3 36/59] KVM: arm: Select ARM_GIC_V3 and ARM_GIC_V3_ITS
In-Reply-To: <20170731172637.29355-37-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
 <20170731172637.29355-37-marc.zyngier@arm.com>
Message-ID: <20170826194938.GG11074@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 06:26:14PM +0100, Marc Zyngier wrote:
> The GICv4 support introduces a hard dependency between the KVM
> core and the ITS infrastructure. arm64 already selects it at
> the architecture level, but 32bit doesn't. In order to avoid
> littering the kernel with #ifdefs, let's just select the whole
> of the GICv3 suport code.
>
> You know you want it.

Acked-by: Christoffer Dall <cdall@linaro.org>

>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index 4e2b192a030a..52b50af04e3b 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -23,6 +23,8 @@ config KVM
>   select PREEMPT_NOTIFIERS
>   select ANON_INODES
>   select ARM_GIC
> + select ARM_GIC_V3
> + select ARM_GIC_V3_ITS
>   select HAVE_KVM_CPU_RELAX_INTERCEPT
>   select HAVE_KVM_ARCH_TLB_FLUSH_ALL
>   select KVM_MMIO
> --
> 2.11.0
>
