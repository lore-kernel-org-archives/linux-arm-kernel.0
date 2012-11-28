From: tony@atomide.com (Tony Lindgren)
Date: Wed, 28 Nov 2012 08:42:01 -0800
Subject: [PATCH v5 3/4] ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
In-Reply-To: <1354113509-7972-4-git-send-email-zonque@gmail.com>
References: <1354113509-7972-1-git-send-email-zonque@gmail.com>
 <1354113509-7972-4-git-send-email-zonque@gmail.com>
Message-ID: <20121128164200.GC5312@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Daniel Mack <zonque@gmail.com> [121128 06:40]:

Please add a patch description here.

Regards,

Tony

> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  arch/arm/mach-omap2/gpmc-nand.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> index f9f23a2..c8a72ba 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -92,17 +92,18 @@ static int omap2_nand_gpmc_retime(
>  static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
>  {
>  	/* support only OMAP3 class */
> -	if (!cpu_is_omap34xx()) {
> +	if (!cpu_is_omap34xx() && !soc_is_am33xx()) {
>  		pr_err("BCH ecc is not supported on this CPU\n");
>  		return 0;
>  	}
>  
>  	/*
> -	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1.
> -	 * Other chips may be added if confirmed to work.
> +	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1
> +	 * and AM33xx derivates. Other chips may be added if confirmed to work.
>  	 */
>  	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW) &&
> -	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0))) {
> +	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0)) &&
> +	    (!soc_is_am33xx())) {
>  		pr_err("BCH 4-bit mode is not supported on this CPU\n");
>  		return 0;
>  	}
> -- 
> 1.7.11.7
> 
