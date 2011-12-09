From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 09 Dec 2011 18:14:49 -0500 (EST)
Subject: [PATCH] ARM: only show modules in the memory layout for MODULES=y
In-Reply-To: <1323466291-9679-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1323466291-9679-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1112091813130.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Dec 2011, Uwe Kleine-K?nig wrote:

> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

If compilation breaks without this with CONFIG_MODULES=n then please say 
so in the commit log.

Otherwise:

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/mm/init.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index fbdd12e..80def74 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -666,7 +666,9 @@ void __init mem_init(void)
>  #ifdef CONFIG_HIGHMEM
>  			"    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
>  #endif
> +#ifdef CONFIG_MODULES
>  			"    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> +#endif
>  			"      .text : 0x%p" " - 0x%p" "   (%4d kB)\n"
>  			"      .init : 0x%p" " - 0x%p" "   (%4d kB)\n"
>  			"      .data : 0x%p" " - 0x%p" "   (%4d kB)\n"
> @@ -685,7 +687,9 @@ void __init mem_init(void)
>  			MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP) *
>  				(PAGE_SIZE)),
>  #endif
> +#ifdef CONFIG_MODULES
>  			MLM(MODULES_VADDR, MODULES_END),
> +#endif
>  
>  			MLK_ROUNDUP(_text, _etext),
>  			MLK_ROUNDUP(__init_begin, __init_end),
> -- 
> 1.7.7.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
