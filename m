From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 11 Jun 2016 21:44:18 +0800
Subject: [PATCH 1/4] ARM: i.MX: Remove i.MX1 Armadeus APF9328 board support
In-Reply-To: <1465325585-1598-1-git-send-email-shc_work@mail.ru>
References: <1465325585-1598-1-git-send-email-shc_work@mail.ru>
Message-ID: <20160611134418.GO20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 09:53:02PM +0300, Alexander Shiyan wrote:
> mach-apf9328.c can be replaced with devicetree equivalent: imx1-apf9328.dts,
> so remove the board file.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-imx/Kconfig        |   8 ---
>  arch/arm/mach-imx/Makefile       |   1 -
>  arch/arm/mach-imx/mach-apf9328.c | 148 ---------------------------------------
>  3 files changed, 157 deletions(-)
>  delete mode 100644 arch/arm/mach-imx/mach-apf9328.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index dd905b9..37447fb 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -113,14 +113,6 @@ config MACH_SCB9328
>  	help
>  	  Say Y here if you are using a Synertronixx scb9328 board
>  
> -config MACH_APF9328

Drop this one from imx_v4_v5_defconfig as well?

Shawn

> -	bool "APF9328"
> -	select IMX_HAVE_PLATFORM_IMX_I2C
> -	select IMX_HAVE_PLATFORM_IMX_UART
> -	select SOC_IMX1
> -	help
> -	  Say Yes here if you are using the Armadeus APF9328 development board
> -
>  config MACH_IMX1_DT
>  	bool "Support i.MX1 platforms from device tree"
>  	select SOC_IMX1
