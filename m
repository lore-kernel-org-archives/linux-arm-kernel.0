From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 12 Oct 2012 16:48:37 +0200
Subject: [PATCH V2 3/3] ARM: SPEAr13xx: Pass DW DMAC platform data from DT
In-Reply-To: <2039bc164224b0068bc078b6cd8df6218e754fce.1350051925.git.viresh.kumar@linaro.org>
References: <142ef9170a2c69657d8a05ac127a9970d7b04965.1350051925.git.viresh.kumar@linaro.org>
 <2039bc164224b0068bc078b6cd8df6218e754fce.1350051925.git.viresh.kumar@linaro.org>
Message-ID: <20121012144837.GE12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  
>  /* others */
> -#define DMAC0_BASE				UL(0xEA800000)
> -#define DMAC1_BASE				UL(0xEB000000)
>  #define MCIF_CF_BASE				UL(0xB2800000)
>  
>  /* Devices present in SPEAr1310 */
> diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
> index 9fbbfc5..0e60195 100644
> --- a/arch/arm/mach-spear13xx/spear1310.c
> +++ b/arch/arm/mach-spear13xx/spear1310.c
> @@ -36,9 +36,7 @@ static struct pl022_ssp_controller ssp1_plat_data = {
>  
>  /* Add SPEAr1310 auxdata to pass platform data */
>  static struct of_dev_auxdata spear1310_auxdata_lookup[] __initdata = {
> -	OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, &cf_dma_priv),
> -	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC0_BASE, NULL, &dmac_plat_data),
> -	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC1_BASE, NULL, &dmac_plat_data),
> +	OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, "cf"),
?/
>  	OF_DEV_AUXDATA("arm,pl022", SSP_BASE, NULL, &pl022_plat_data),
>  
>  	OF_DEV_AUXDATA("arm,pl022", SPEAR1310_SSP1_BASE, NULL, &ssp1_plat_data),
> diff --git a/arch/arm/mach-spear13xx/spear1340.c b/arch/arm/mach-spear13xx/spear1340.c
> index 081014f..7301f14 100644
> --- a/arch/arm/mach-spear13xx/spear1340.c
> +++ b/arch/arm/mach-spear13xx/spear1340.c
> @@ -20,7 +20,6 @@
>  #include <linux/of_platform.h>
>  #include <asm/hardware/gic.h>
>  #include <asm/mach/arch.h>
> -#include <mach/dma.h>
>  #include <mach/generic.h>
>  #include <mach/spear.h>
>  
> @@ -78,26 +77,10 @@
>  			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
>  			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
>  

Best Regards,
J.
