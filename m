From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 8 Jul 2015 17:38:01 +0800
Subject: [PATCH v6 4/6] ARM: vf610: enable NAND Flash Controller
In-Reply-To: <1434668319-6651-5-git-send-email-stefan@agner.ch>
References: <1434668319-6651-1-git-send-email-stefan@agner.ch>
 <1434668319-6651-5-git-send-email-stefan@agner.ch>
Message-ID: <20150708093801.GG28488@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 12:58:37AM +0200, Stefan Agner wrote:
> Enable the NAND Flash Controller driver which is part of the Vybrid
> SoC by default.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/mach-imx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 3a3d3e9..9358135 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -589,6 +589,7 @@ config SOC_VF610
>  	select PINCTRL_VF610
>  	select PL310_ERRATA_769419 if CACHE_L2X0
>  	select SMP_ON_UP if SMP
> +	select HAVE_NAND_VF610_NFC

I'm not sure about the benefit of having this option, except we have to
have this additional architecture patch.

Shawn

>  
>  	help
>  	  This enables support for Freescale Vybrid VF610 processor.
> -- 
> 2.4.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
