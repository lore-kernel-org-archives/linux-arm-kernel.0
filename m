From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Feb 2015 13:56:10 +0800
Subject: [PATCH] ARM: vf610: use SMP_ON_UP for Vybrid SoC
In-Reply-To: <1421795565-3370-1-git-send-email-stefan@agner.ch>
References: <1421795565-3370-1-git-send-email-stefan@agner.ch>
Message-ID: <20150226055609.GE20028@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 12:12:45AM +0100, Stefan Agner wrote:
> The Vybrid SoC has only one Cortex-A5 core and hence should select
> the SMP_ON_UP configuration on a SMP kernel.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.

> ---
>  arch/arm/mach-imx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index e8627e0..b8d3ccd 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -634,6 +634,7 @@ config SOC_VF610
>  	select ARM_GIC
>  	select PINCTRL_VF610
>  	select PL310_ERRATA_769419 if CACHE_L2X0
> +	select SMP_ON_UP if SMP
>  
>  	help
>  	  This enable support for Freescale Vybrid VF610 processor.
> -- 
> 2.2.2
> 
