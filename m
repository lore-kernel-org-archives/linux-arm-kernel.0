From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 19 Jun 2012 17:55:32 +0900
Subject: [PATCH] ARM: exynos: add UART3 to DEBUG_LL ports
In-Reply-To: <1338785110-11465-1-git-send-email-olof@lixom.net>
References: <1338785110-11465-1-git-send-email-olof@lixom.net>
Message-ID: <01a501cd4df9$48b9e430$da2dac90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> Add support for using UART3 for DEBUG_LL on exynos.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/Kconfig.debug        | 11 +++++++++++
>  arch/arm/plat-samsung/Kconfig |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 01a1341..da84061 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -310,6 +310,17 @@ choice
>  		  The uncompressor code port configuration is now handled
>  		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
> 
> +	config DEBUG_S3C_UART3
> +		depends on PLAT_SAMSUNG
> +		bool "Use S3C UART 3 for low-level debug"
> +		help
> +		  Say Y here if you want the debug print routines to direct
> +		  their output to UART 3. The port must have been
initialised
> +		  by the boot-loader before use.
> +
> +		  The uncompressor code port configuration is now handled
> +		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
> +
>  	config DEBUG_LL_UART_NONE
>  		bool "No low-level debugging UART"
>  		help
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index a2fae4e..ed0b695 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -505,5 +505,6 @@ config DEBUG_S3C_UART
>  	default "0" if DEBUG_S3C_UART0
>  	default "1" if DEBUG_S3C_UART1
>  	default "2" if DEBUG_S3C_UART2
> +	default "3" if DEBUG_S3C_UART3
> 
>  endif
> --
> 1.7.10.1.488.g05fbf7a

Basically, looks ok to me, but don't we need to protect this config for 3
UARTs' Samsung SoC?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
