From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 09 Jul 2011 17:03:13 -0700
Subject: [PATCH] ARM: gic: Allow gic arch extensions to provide irqchip
	flags
In-Reply-To: <1307925960-28839-1-git-send-email-ccross@android.com>
References: <1307925960-28839-1-git-send-email-ccross@android.com>
Message-ID: <4E18EC41.2080102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/12/2011 5:45 PM, Colin Cross wrote:
> Tegra can benefit from the IRQCHIP_MASK_ON_SUSPEND flag, allow it
> to be passed to the gic irq chip.
>
> Signed-off-by: Colin Cross<ccross@android.com>

I missed this patch. Looks good to me and I think can
be merged in rc as well.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> ---
>   arch/arm/common/gic.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 8d62e07..a6c28a0 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -576,6 +576,7 @@ void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
>   	if (gic_nr == 0)
>   		gic_cpu_base_addr = cpu_base;
>
> +	gic_chip.flags |= gic_arch_extn.flags;
>   	gic_dist_init(gic, irq_start);
>   	gic_cpu_init(gic);
>   	gic_cpu_pm_init(gic);

Russell,
Any thoughts on this fix?

Regards
Santosh
