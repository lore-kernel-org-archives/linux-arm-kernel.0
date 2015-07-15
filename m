From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Wed, 15 Jul 2015 23:53:55 +0200
Subject: [PATCH v2 3/4] arm64: Add Broadcom iProc family support
In-Reply-To: <1436935343-4437-4-git-send-email-rjui@broadcom.com>
References: <1436935343-4437-1-git-send-email-rjui@broadcom.com>
 <1436935343-4437-4-git-send-email-rjui@broadcom.com>
Message-ID: <55A6D673.1040908@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2015 06:42 AM, Ray Jui wrote:
> This patch adds support to Broadcom's iProc family of arm64 based SoCs
> in the arm64 Kconfig and defconfig files
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  arch/arm64/Kconfig           |    5 +++++
>  arch/arm64/configs/defconfig |    2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 318175f..969ef4a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -162,6 +162,11 @@ source "kernel/Kconfig.freezer"
>  
>  menu "Platform selection"
>  
> +config ARCH_BCM_IPROC
> +	bool "Broadcom iProc SoC Family"
> +	help
> +	  This enables support for Broadcom iProc based SoCs
> +

Is this working correctly if we have ARCH_BCM_IPROC under ARM and ARM64?
They are guarding the same SoC line, which now uses ARM64 CPUS.

>  config ARCH_EXYNOS
>  	bool
>  	help
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 4e17e7e..c83d51f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -31,6 +31,7 @@ CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  # CONFIG_BLK_DEV_BSG is not set
>  # CONFIG_IOSCHED_DEADLINE is not set
> +CONFIG_ARCH_BCM_IPROC=y
>  CONFIG_ARCH_EXYNOS7=y
>  CONFIG_ARCH_FSL_LS2085A=y
>  CONFIG_ARCH_HISI=y
> @@ -102,6 +103,7 @@ CONFIG_SERIO_AMBAKMI=y
>  CONFIG_LEGACY_PTY_COUNT=16
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_DW=y
>  CONFIG_SERIAL_8250_MT6577=y
>  CONFIG_SERIAL_AMBA_PL011=y
>  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> 
