From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 16 Dec 2011 17:56:26 +0800
Subject: [PATCH v5 5/5] imx6q: Remove unconditional dependency on l2x0 L2
 cache support
In-Reply-To: <1323964434-6764-6-git-send-email-dave.martin@linaro.org>
References: <1323964434-6764-1-git-send-email-dave.martin@linaro.org>
 <1323964434-6764-6-git-send-email-dave.martin@linaro.org>
Message-ID: <20111216095625.GE3519@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 03:53:54PM +0000, Dave Martin wrote:
> The i.MX6 Quad SoC will work without the l2x0 L2 cache controller
> support built into the kernel, so this patch removes the dependency
> on CACHE_L2X0.
> 
> This makes the l2x0 support optional, so that it can be turned off
> when desired for debugging purposes etc.
> 
> Since SOC_IMX6Q already depends on ARCH_IMX_V6_V7 and
> ARCH_IMX_V6_V7 selects MIGHT_HAVE_CACHE_L2X0, there is no need to
> select that option explicitly from SOC_IMX6Q.
> 
> Thanks to Shawn Guo for this suggestion.  [1]
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074602.html
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-and-Tested-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn

> ---
> Changes:
> 
> v5: Don't select MIGHT_HAVE_CACHE_L2X0 directly from SOC_IMX6Q, but
>     instead select implicitly via ARCH_IMX_V6_V7 (which we expect
>     to be selected by other relevant SoCs).  Thanks to Shawn for
>     this suggestion.
> 
> 
>  arch/arm/mach-imx/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 29a3d61..1530678 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -609,7 +609,6 @@ comment "i.MX6 family:"
>  config SOC_IMX6Q
>  	bool "i.MX6 Quad support"
>  	select ARM_GIC
> -	select CACHE_L2X0
>  	select CPU_V7
>  	select HAVE_ARM_SCU
>  	select HAVE_IMX_GPC
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
