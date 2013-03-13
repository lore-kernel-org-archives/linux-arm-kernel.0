From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 13 Mar 2013 15:17:01 +0100
Subject: [PATCH 2/3] ARM: at91: rename board-dt to more specific name
 board-dt-sam9
In-Reply-To: <1362666113-16434-2-git-send-email-plagnioj@jcrosoft.com>
References: <20130307130842.GA4590@game.jcrosoft.org>
 <1362666113-16434-1-git-send-email-plagnioj@jcrosoft.com>
 <1362666113-16434-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <51408A5D.6020402@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2013 03:21 PM, Jean-Christophe PLAGNIOL-VILLARD :
> as we will introduce the Cortex-A5 sama5 support

We may need more arguments here (Cf. discussion about the sama5d3
support). Let's discuss this and modify this commit message quickly.

Bye,

> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/configs/at91_dt_defconfig                 |    2 +-
>  arch/arm/configs/at91sam9260_defconfig             |    2 +-
>  arch/arm/configs/at91sam9g20_defconfig             |    2 +-
>  arch/arm/configs/at91sam9g45_defconfig             |    2 +-
>  arch/arm/mach-at91/Kconfig                         |    2 +-
>  arch/arm/mach-at91/Makefile                        |    2 +-
>  arch/arm/mach-at91/{board-dt.c => board-dt-sam9.c} |    0
>  7 files changed, 6 insertions(+), 6 deletions(-)
>  rename arch/arm/mach-at91/{board-dt.c => board-dt-sam9.c} (100%)
> 
> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
> index 1ea9590..047f2a4 100644
> --- a/arch/arm/configs/at91_dt_defconfig
> +++ b/arch/arm/configs/at91_dt_defconfig
> @@ -20,7 +20,7 @@ CONFIG_SOC_AT91SAM9263=y
>  CONFIG_SOC_AT91SAM9G45=y
>  CONFIG_SOC_AT91SAM9X5=y
>  CONFIG_SOC_AT91SAM9N12=y
> -CONFIG_MACH_AT91SAM_DT=y
> +CONFIG_MACH_AT91SAM9_DT=y
>  CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
>  CONFIG_AT91_TIMER_HZ=128
>  CONFIG_AEABI=y
> diff --git a/arch/arm/configs/at91sam9260_defconfig b/arch/arm/configs/at91sam9260_defconfig
> index 0ea5d2c..05618eb 100644
> --- a/arch/arm/configs/at91sam9260_defconfig
> +++ b/arch/arm/configs/at91sam9260_defconfig
> @@ -22,7 +22,7 @@ CONFIG_MACH_QIL_A9260=y
>  CONFIG_MACH_CPU9260=y
>  CONFIG_MACH_FLEXIBITY=y
>  CONFIG_MACH_SNAPPER_9260=y
> -CONFIG_MACH_AT91SAM_DT=y
> +CONFIG_MACH_AT91SAM9_DT=y
>  CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
>  # CONFIG_ARM_THUMB is not set
>  CONFIG_ZBOOT_ROM_TEXT=0x0
> diff --git a/arch/arm/configs/at91sam9g20_defconfig b/arch/arm/configs/at91sam9g20_defconfig
> index 3b18810..892e828 100644
> --- a/arch/arm/configs/at91sam9g20_defconfig
> +++ b/arch/arm/configs/at91sam9g20_defconfig
> @@ -22,7 +22,7 @@ CONFIG_MACH_PCONTROL_G20=y
>  CONFIG_MACH_GSIA18S=y
>  CONFIG_MACH_USB_A9G20=y
>  CONFIG_MACH_SNAPPER_9260=y
> -CONFIG_MACH_AT91SAM_DT=y
> +CONFIG_MACH_AT91SAM9_DT=y
>  CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
>  # CONFIG_ARM_THUMB is not set
>  CONFIG_AEABI=y
> diff --git a/arch/arm/configs/at91sam9g45_defconfig b/arch/arm/configs/at91sam9g45_defconfig
> index 606d48f..5f551b7 100644
> --- a/arch/arm/configs/at91sam9g45_defconfig
> +++ b/arch/arm/configs/at91sam9g45_defconfig
> @@ -18,7 +18,7 @@ CONFIG_MODULE_UNLOAD=y
>  CONFIG_ARCH_AT91=y
>  CONFIG_ARCH_AT91SAM9G45=y
>  CONFIG_MACH_AT91SAM9M10G45EK=y
> -CONFIG_MACH_AT91SAM_DT=y
> +CONFIG_MACH_AT91SAM9_DT=y
>  CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
>  CONFIG_AT91_SLOW_CLOCK=y
>  CONFIG_AEABI=y
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 98c2e05..440682b 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -108,7 +108,7 @@ config MACH_AT91RM9200_DT
>  	  Select this if you want to experiment device-tree with
>  	  an Atmel RM9200 Evaluation Kit.
>  
> -config MACH_AT91SAM_DT
> +config MACH_AT91SAM9_DT
>  	bool "Atmel AT91SAM Evaluation Kits with device-tree support"
>  	depends on SOC_AT91SAM9
>  	select USE_OF
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index 39218ca..5eca35a 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -88,7 +88,7 @@ obj-$(CONFIG_MACH_AT91SAM9M10G45EK) += board-sam9m10g45ek.o
>  
>  # AT91SAM board with device-tree
>  obj-$(CONFIG_MACH_AT91RM9200_DT) += board-rm9200-dt.o
> -obj-$(CONFIG_MACH_AT91SAM_DT) += board-dt.o
> +obj-$(CONFIG_MACH_AT91SAM9_DT) += board-dt-sam9.o
>  
>  # AT91X40 board-specific support
>  obj-$(CONFIG_MACH_AT91EB01)	+= board-eb01.o
> diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt-sam9.c
> similarity index 100%
> rename from arch/arm/mach-at91/board-dt.c
> rename to arch/arm/mach-at91/board-dt-sam9.c
> 


-- 
Nicolas Ferre
