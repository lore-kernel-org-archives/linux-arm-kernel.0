From: sbabic@denx.de (Stefano Babic)
Date: Mon, 19 Sep 2011 18:25:44 +0200
Subject: [PATCH] ARM: mach-qong: Add watchdog support
In-Reply-To: <1316440786-21118-1-git-send-email-fabio.estevam@freescale.com>
References: <1316440786-21118-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <4E776D08.1040201@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2011 03:59 PM, Fabio Estevam wrote:
> Add watchdog support for mach-qong target.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig     |    1 +
>  arch/arm/mach-imx/mach-qong.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 0519dd7..8748531 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -485,6 +485,7 @@ config MACH_QONG
>  	bool "Support Dave/DENX QongEVB-LITE platform"
>  	select SOC_IMX31
>  	select IMX_HAVE_PLATFORM_IMX_UART
> +	select IMX_HAVE_PLATFORM_IMX2_WDT
>  	help
>  	  Include support for Dave/DENX QongEVB-LITE platform. This includes
>  	  specific configurations for the board and its peripherals.
> diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
> index 3626f48..44462ce 100644
> --- a/arch/arm/mach-imx/mach-qong.c
> +++ b/arch/arm/mach-imx/mach-qong.c
> @@ -249,6 +249,7 @@ static void __init qong_init(void)
>  	mxc_init_imx_uart();
>  	qong_init_nor_mtd();
>  	qong_init_fpga();
> +	imx31_add_imx2_wdt(NULL);
>  }
>  

Thanks for fixing !

Tested-by : Stefano Babic <sbabic@denx.de>

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
=====================================================================
