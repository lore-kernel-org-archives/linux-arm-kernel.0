From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 27 Nov 2014 09:31:27 +0100
Subject: [PATCH 2/2] ARM: tegra: irq: nuke leftovers from non-DT support
In-Reply-To: <1417024532-5777-3-git-send-email-marc.zyngier@arm.com>
References: <1417024532-5777-1-git-send-email-marc.zyngier@arm.com>
 <1417024532-5777-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20141127083126.GB19323@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 05:55:32PM +0000, Marc Zyngier wrote:
> The GIC is now always initialized from DT on tegra, and there is
> no point in keeping non-DT init code.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-tegra/irq.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
> index ab95f53..7f87a50 100644
> --- a/arch/arm/mach-tegra/irq.c
> +++ b/arch/arm/mach-tegra/irq.c
> @@ -283,13 +283,5 @@ void __init tegra_init_irq(void)
>  	gic_arch_extn.irq_set_wake = tegra_set_wake;
>  	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
>  
> -	/*
> -	 * Check if there is a devicetree present, since the GIC will be
> -	 * initialized elsewhere under DT.
> -	 */
> -	if (!of_have_populated_dt())
> -		gic_init(0, 29, distbase,
> -			IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
> -
>  	tegra114_gic_cpu_pm_registration();
>  }

I've been carrying the same patch in my tree locally for months and was
just waiting for the stacked domain code to settle. So if you prefer to
merge this as part of other stacked domain code, consider this:

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/db9a7c9a/attachment-0001.sig>
