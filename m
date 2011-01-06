From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Jan 2011 14:14:03 -0800
Subject: [PATCH] arm: mach-omap2: mux: fix buffer overrun
In-Reply-To: <1294245733-4126-1-git-send-email-aaro.koskinen@nokia.com>
References: <1294245733-4126-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <20110106221402.GB7771@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@nokia.com> [110105 08:39]:
> memcpy() copies 8 bytes too much (omap_mux_entry vs. omap_mux). Correct
> by replacing memcpy() with struct assignment, which is safer.

Thanks will queue as a fix after the merge window.

Tony
 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  arch/arm/mach-omap2/mux.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 17bd639..df8d2f2 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -893,7 +893,7 @@ static struct omap_mux * __init omap_mux_list_add(
>  		return NULL;
>  
>  	m = &entry->mux;
> -	memcpy(m, src, sizeof(struct omap_mux_entry));
> +	entry->mux = *src;
>  
>  #ifdef CONFIG_OMAP_MUX
>  	if (omap_mux_copy_names(src, m)) {
> -- 
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
