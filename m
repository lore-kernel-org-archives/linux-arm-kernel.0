From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 11 Jun 2016 21:50:20 +0800
Subject: [PATCH 2/4] ARM: i.MX: Remove i.MX1 Synertronixx SCB9328 board
 support
In-Reply-To: <1465325585-1598-2-git-send-email-shc_work@mail.ru>
References: <1465325585-1598-1-git-send-email-shc_work@mail.ru>
 <1465325585-1598-2-git-send-email-shc_work@mail.ru>
Message-ID: <20160611135020.GQ20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 09:53:03PM +0300, Alexander Shiyan wrote:
> Synertronixx SCB9328 board is very similar to Armadeus APF9328,
> so it can be easily reimplemented in DT way.
> This patch removes support for non-DT support for this board.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-imx/Kconfig        |   7 --
>  arch/arm/mach-imx/Makefile       |   1 -
>  arch/arm/mach-imx/mach-scb9328.c | 143 ---------------------------------------
>  3 files changed, 151 deletions(-)
>  delete mode 100644 arch/arm/mach-imx/mach-scb9328.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 37447fb..1b7905a 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -106,13 +106,6 @@ if ARCH_MULTI_V4T
>  
>  comment "MX1 platforms:"
>  
> -config MACH_SCB9328

Can be dropped from imx_v4_v5_defconfig?

Shawn

> -	bool "Synertronixx scb9328"
> -	select IMX_HAVE_PLATFORM_IMX_UART
> -	select SOC_IMX1
> -	help
> -	  Say Y here if you are using a Synertronixx scb9328 board
> -
>  config MACH_IMX1_DT
>  	bool "Support i.MX1 platforms from device tree"
>  	select SOC_IMX1
