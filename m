From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 Jul 2011 09:45:55 +0200
Subject: [PATCH v2] ARM: mx50: Select IMX_HAVE_PLATFORM_FEC as done on
	other i.MX devices
In-Reply-To: <1311630006-7685-1-git-send-email-festevam@gmail.com>
References: <1311630006-7685-1-git-send-email-festevam@gmail.com>
Message-ID: <20110726074555.GJ20587@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 06:40:06PM -0300, Fabio Estevam wrote:
> Currently it is only the MX50_RDP board that selects IMX_HAVE_PLATFORM_FEC in its board Kconfig.
> 
> Do like the other i.MX processors, which select IMX_HAVE_PLATFORM_FEC based on the processor type.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> 
> - Keep the processor list sorted

Ok, took this one instead, now that you already reposted it.

Sascha

> 
>  arch/arm/mach-mx5/Kconfig         |    1 -
>  arch/arm/plat-mxc/devices/Kconfig |    2 +-
>  2 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index b4e7c58..a303445 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -52,7 +52,6 @@ config MACH_MX50_RDP
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
>  	select IMX_HAVE_PLATFORM_SPI_IMX
> -	select IMX_HAVE_PLATFORM_FEC
>  	help
>  	  Include support for MX50 reference design platform (RDP) board. This
>  	  includes specific configurations for the board and its peripherals.
> diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
> index bd294ad..4c8b00b 100644
> --- a/arch/arm/plat-mxc/devices/Kconfig
> +++ b/arch/arm/plat-mxc/devices/Kconfig
> @@ -1,6 +1,6 @@
>  config IMX_HAVE_PLATFORM_FEC
>  	bool
> -	default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || SOC_IMX51 || SOC_IMX53
> +	default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || SOC_IMX50 || SOC_IMX51 || SOC_IMX53
>  
>  config IMX_HAVE_PLATFORM_FLEXCAN
>  	select HAVE_CAN_FLEXCAN if CAN
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
