From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 27 Apr 2011 18:24:55 +0530
Subject: [PATCH] ARM: cache-l2x0: fix wrong print of AUX_CTRL register
In-Reply-To: <1303907194-3121-1-git-send-email-srinidhi.kasagar@stericsson.com>
References: <1303907194-3121-1-git-send-email-srinidhi.kasagar@stericsson.com>
Message-ID: <4DB8121F.5070204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/27/2011 5:56 PM, srinidhi kasagar wrote:
> On platforms where l2x0 is already enabled and configured
> by the secure code, printing the masked value of the
> AUX_CTRL register seems to be wrong and differ from the
> programmed value.
>
> Fix it by reading the AUX_CTRL register again.
>
> Signed-off-by: srinidhi kasagar<srinidhi.kasagar@stericsson.com>
> Signed-off-by: Vijaya Kumar Kilari<vijay.kilari@stericsson.com>
> ---
>   arch/arm/mm/cache-l2x0.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index ef59099..d07f8cb 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -340,6 +340,8 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
>   	outer_cache.disable = l2x0_disable;
>   	outer_cache.set_debug = l2x0_set_debug;
>
> +	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
> +

Can you not read this register in your machine code and pass
the right 'aux_val' as part of l2x0_init() ?

Regards
Santosh
