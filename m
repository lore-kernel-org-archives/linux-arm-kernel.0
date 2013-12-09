From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 10 Dec 2013 06:19:39 +0900
Subject: [PATCH] ARM: SAMSUNG: remove unused SAMSUNG_GPIOLIB_4BIT Kconfig
 parameter
In-Reply-To: <1386563907-18808-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <000001ced94433863209a92960$%han@samsung.com>
 <1386563907-18808-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <52A633EB.4070503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/13 13:38, Michael Opdenacker wrote:
> This removes the SAMSUNG_GPIOLIB_4BIT Kconfig parameter,
> which was no longer used anywhere in the source code
> and Makefiles.
>
> Signed-off-by: Michael Opdenacker<michael.opdenacker@free-electrons.com>
> Reviewed-by: Jingoo Han<jg1.han@samsung.com>
> ---
>   arch/arm/Kconfig              | 1 -
>   arch/arm/plat-samsung/Kconfig | 8 --------
>   2 files changed, 9 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c1f1a7eee953..5e227a371401 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -740,7 +740,6 @@ config ARCH_S3C64XX
>   	select S3C_DEV_NAND
>   	select S3C_GPIO_TRACK
>   	select SAMSUNG_ATAGS
> -	select SAMSUNG_GPIOLIB_4BIT
>   	select SAMSUNG_WAKEMASK
>   	select SAMSUNG_WDT_RESET
>   	select USB_ARCH_HAS_OHCI
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 6d95d60276d6..58645a58d0d8 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -24,7 +24,6 @@ config PLAT_S5P
>   	select S3C_GPIO_TRACK
>   	select S5P_GPIO_DRVSTR
>   	select SAMSUNG_CLKSRC if !COMMON_CLK
> -	select SAMSUNG_GPIOLIB_4BIT
>   	help
>   	  Base platform code for Samsung's S5P series SoC.
>
> @@ -115,13 +114,6 @@ config S5P_GPIO_INT
>
>   # options for gpio configuration support
>
> -config SAMSUNG_GPIOLIB_4BIT
> -	bool
> -	help
> -	  GPIOlib file contains the 4 bit modification functions for gpio
> -	  configuration. GPIOlib shall be compiled only for S3C64XX and S5P
> -	  series of processors.
> -
>   config S5P_GPIO_DRVSTR
>   	bool
>   	help

OK, applied.

Thanks
Kukjin
