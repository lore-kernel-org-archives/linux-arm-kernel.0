From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 13 Nov 2014 10:34:25 +0100
Subject: [PATCH] ARM: at91: remove CONFIG_MACH_SAMA5_DT
In-Reply-To: <1415652353-15985-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1415652353-15985-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20141113103425.1cf5e8ea@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Nov 2014 21:45:53 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> CONFIG_MACH_SAMA5_DT is useless as the only way to boot on sama5 based boards is
> to use device tree.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/configs/sama5_defconfig |  1 -
>  arch/arm/mach-at91/Kconfig       | 10 +---------
>  arch/arm/mach-at91/Makefile      |  2 +-
>  3 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index c9089c927daf..299ca18bbd75 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -20,7 +20,6 @@ CONFIG_ARCH_AT91=y
>  CONFIG_SOC_SAM_V7=y
>  CONFIG_SOC_SAMA5D3=y
>  CONFIG_SOC_SAMA5D4=y
> -CONFIG_MACH_SAMA5_DT=y
>  CONFIG_AEABI=y
>  CONFIG_UACCESS_WITH_MEMCPY=y
>  CONFIG_ZBOOT_ROM_TEXT=0x0
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 0e6d548b70d9..81ddd7d31d1e 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -58,6 +58,7 @@ config SOC_SAMA5
>  	select USE_OF
>  	select MEMORY
>  	select ATMEL_SDRAMC
> +	select PHYLIB if NETDEVICES

Is this really related to this commit ?

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
