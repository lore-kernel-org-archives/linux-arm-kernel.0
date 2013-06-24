From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Jun 2013 15:03:07 +0800
Subject: [PATCH] ARM: imx: select syscon for IMX6L
In-Reply-To: <201306220039.43988.arnd@arndb.de>
References: <201306220039.43988.arnd@arndb.de>
Message-ID: <20130624070306.GE26254@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 12:39:43AM +0200, Arnd Bergmann wrote:
> This is required for building a kernel that enables only
> IMX6L but not IMX6Q, which would get a build error when
> syscon is not available.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index f25cf88..eef9590 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -823,6 +823,7 @@ config SOC_IMX6SL
>  	select HAVE_IMX_GPC
>  	select HAVE_IMX_MMDC
>  	select HAVE_IMX_SRC
> +	select MFD_SYSCON
>  	select PINCTRL
>  	select PINCTRL_IMX6SL
>  	select PL310_ERRATA_588369 if CACHE_PL310
