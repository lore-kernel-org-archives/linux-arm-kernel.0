From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Jul 2013 15:49:49 +0800
Subject: [PATCH v2] ARM: imx: Kconfig: Select ARM1136 related errata
In-Reply-To: <1373552782-14196-1-git-send-email-fabio.estevam@freescale.com>
References: <1373552782-14196-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130712074946.GD25501@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 11:26:22AM -0300, Fabio Estevam wrote:
> CONFIG_ARM_ERRATA_411920 and CONFIG_ARM_ERRATA_364296 should be selected for
> ARM1136 SoCs.
> 
Per help text of the erratums, 364296 affects ARM1136 r0p2, and 411920
affects ARM1136 before r1p4.  Do you know the revisions used on imx31
and imx35?  Or do you see that enabling the workaround help fix some
real issues?

Shawn

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Select the errata via Kconfig
> 
>  arch/arm/mach-imx/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index f7a5ad1..1d15d5c 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -123,6 +123,8 @@ config SOC_IMX27
>  
>  config SOC_IMX31
>  	bool
> +	select ARM_ERRATA_364296
> +	select ARM_ERRATA_411920
>  	select COMMON_CLK
>  	select CPU_V6
>  	select IMX_HAVE_PLATFORM_MXC_RNGA
> @@ -132,6 +134,8 @@ config SOC_IMX31
>  config SOC_IMX35
>  	bool
>  	select ARCH_MXC_IOMUX_V3
> +	select ARM_ERRATA_364296
> +	select ARM_ERRATA_411920
>  	select COMMON_CLK
>  	select CPU_V6K
>  	select HAVE_EPIT
> -- 
> 1.8.1.2
> 
> 
