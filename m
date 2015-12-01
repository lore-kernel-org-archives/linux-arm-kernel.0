From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 1 Dec 2015 12:17:12 +0100
Subject: [PATCH] ARM: at91: fix pinctrl driver selection
In-Reply-To: <1448966680-30281-1-git-send-email-ludovic.desroches@atmel.com>
References: <1448966680-30281-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20151201111712.GR22136@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2015 at 11:44:40 +0100, Ludovic Desroches wrote :
> Move the selection of the pinctrl driver to SoC family level since we
> have two pinctrl drivers. It is useless to select one which is not
> compatible with the SoC.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
> 
> This patch is an improvement of this one (already acked by Linus and Nicolas):
> https://lkml.org/lkml/2015/9/16/522
> 
> Without it, at91 pio4 driver is not compiled causing boot failure for SAMA5D2.
> 
>  arch/arm/mach-at91/Kconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 9267300..28656c2 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -4,7 +4,6 @@ menuconfig ARCH_AT91
>  	select ARCH_REQUIRE_GPIOLIB
>  	select COMMON_CLK_AT91
>  	select PINCTRL
> -	select PINCTRL_AT91
>  	select SOC_BUS
>  
>  if ARCH_AT91
> @@ -17,6 +16,7 @@ config SOC_SAMA5D2
>  	select HAVE_AT91_USB_CLK
>  	select HAVE_AT91_H32MX
>  	select HAVE_AT91_GENERATED_CLK
> +	select PINCTRL_AT91PIO4
>  	help
>  	  Select this if ou are using one of Atmel's SAMA5D2 family SoC.
>  
> @@ -27,6 +27,7 @@ config SOC_SAMA5D3
>  	select HAVE_AT91_UTMI
>  	select HAVE_AT91_SMD
>  	select HAVE_AT91_USB_CLK
> +	select PINCTRL_AT91
>  	help
>  	  Select this if you are using one of Atmel's SAMA5D3 family SoC.
>  	  This support covers SAMA5D31, SAMA5D33, SAMA5D34, SAMA5D35, SAMA5D36.
> @@ -40,6 +41,7 @@ config SOC_SAMA5D4
>  	select HAVE_AT91_SMD
>  	select HAVE_AT91_USB_CLK
>  	select HAVE_AT91_H32MX
> +	select PINCTRL_AT91
>  	help
>  	  Select this if you are using one of Atmel's SAMA5D4 family SoC.
>  
> @@ -50,6 +52,7 @@ config SOC_AT91RM9200
>  	select CPU_ARM920T
>  	select HAVE_AT91_USB_CLK
>  	select MIGHT_HAVE_PCI
> +	select PINCTRL_AT91
>  	select SOC_SAM_V4_V5
>  	select SRAM if PM
>  	help
> @@ -65,6 +68,7 @@ config SOC_AT91SAM9
>  	select HAVE_AT91_UTMI
>  	select HAVE_FB_ATMEL
>  	select MEMORY
> +	select PINCTRL_AT91
>  	select SOC_SAM_V4_V5
>  	select SRAM if PM
>  	help
> -- 
> 2.5.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
