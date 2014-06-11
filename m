From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 11 Jun 2014 22:04:36 +0900
Subject: [PATCH 1/2] ARM: exynos: cleanup kconfig option display
In-Reply-To: <1402409170-1314-2-git-send-email-robherring2@gmail.com>
References: <1402409170-1314-1-git-send-email-robherring2@gmail.com>
 <1402409170-1314-2-git-send-email-robherring2@gmail.com>
Message-ID: <07fc01cf8575$b4fbc360$1ef34a20$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring wrote:
> 
> From: Rob Herring <robh@kernel.org>
> 
> The addition of Exynos to multi-platform configs creates a mess of config
> options with options appearing before the Exynos config option. This is
> due to arch/arm/plat-samsung/Kconfig being included out of order with the
> other Samsung platform kconfig files. Reorder the kconfig files and move
> all the options into a sub-menu. Some of the options are dead, so remove
> those as well.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Looks nice to me :-)

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin

> Cc: linux-samsung-soc at vger.kernel.org
> ---
>  arch/arm/Kconfig              |  3 +--
>  arch/arm/plat-samsung/Kconfig | 17 +++--------------
>  2 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 87b63fd..cbf0c37 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1009,8 +1009,6 @@ source "arch/arm/mach-rockchip/Kconfig"
> 
>  source "arch/arm/mach-sa1100/Kconfig"
> 
> -source "arch/arm/plat-samsung/Kconfig"
> -
>  source "arch/arm/mach-socfpga/Kconfig"
> 
>  source "arch/arm/mach-spear/Kconfig"
> @@ -1028,6 +1026,7 @@ source "arch/arm/mach-s5pc100/Kconfig"
>  source "arch/arm/mach-s5pv210/Kconfig"
> 
>  source "arch/arm/mach-exynos/Kconfig"
> +source "arch/arm/plat-samsung/Kconfig"
> 
>  source "arch/arm/mach-shmobile/Kconfig"
> 
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 243dfcb..ac032cd 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -35,27 +35,15 @@ config SAMSUNG_PM
>  	  Base platform power management code for samsung code
> 
>  if PLAT_SAMSUNG
> +menu "Samsung Common options"
> 
>  # boot configurations
> 
>  comment "Boot options"
> 
> -config S3C_BOOT_ERROR_RESET
> -	bool "S3C Reboot on decompression error"
> -	help
> -	  Say y here to use the watchdog to reset the system if the
> -	  kernel decompressor detects an error during decompression.
> -
> -config S3C_BOOT_UART_FORCE_FIFO
> -       bool "Force UART FIFO on during boot process"
> -       default y
> -       help
> -         Say Y here to force the UART FIFOs on during the kernel
> -	 uncompressor
> -
> -
>  config S3C_LOWLEVEL_UART_PORT
>  	int "S3C UART to use for low-level messages"
> +	depends on ARCH_S3C64XX
>  	default 0
>  	help
>  	  Choice of which UART port to use for the low-level messages,
> @@ -503,4 +491,5 @@ config DEBUG_S3C_UART
>  	default "2" if DEBUG_S3C_UART2
>  	default "3" if DEBUG_S3C_UART3
> 
> +endmenu
>  endif
> --
> 1.9.1
