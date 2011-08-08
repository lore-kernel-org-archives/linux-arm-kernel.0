From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 08 Aug 2011 20:52:55 +0100
Subject: [PATCH 09/12] ARM: mach-at91: Setup consistent dma size at boot
	time
In-Reply-To: <1312813712-22808-10-git-send-email-tixy@yxit.co.uk>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
	<1312813712-22808-10-git-send-email-tixy@yxit.co.uk>
Message-ID: <4E403E97.2050500@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2011 03:28 PM, Jon Medhurst wrote:
> Signed-off-by: Jon Medhurst<tixy@yxit.co.uk>
> CC: Nicolas Ferre<nicolas.ferre@atmel.com>

Thanks,

Acked-by: Nicolas Ferre<nicolas.ferre@atmel.com>

> ---
>   arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 --
>   arch/arm/mach-at91/at91sam9g45.c              |    2 ++
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
> index 2c611b9..406bb64 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
> @@ -128,8 +128,6 @@
>   #define AT91SAM9G45_EHCI_BASE	0x00800000	/* USB Host controller (EHCI) */
>   #define AT91SAM9G45_VDEC_BASE	0x00900000	/* Video Decoder Controller */
>
> -#define CONSISTENT_DMA_SIZE	SZ_4M
> -
>   /*
>    * DMA peripheral identifiers
>    * for hardware handshaking interface
> diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> index e04c5fb..1532b50 100644
> --- a/arch/arm/mach-at91/at91sam9g45.c
> +++ b/arch/arm/mach-at91/at91sam9g45.c
> @@ -12,6 +12,7 @@
>
>   #include<linux/module.h>
>   #include<linux/pm.h>
> +#include<linux/dma-mapping.h>
>
>   #include<asm/irq.h>
>   #include<asm/mach/arch.h>
> @@ -319,6 +320,7 @@ static void at91sam9g45_poweroff(void)
>   static void __init at91sam9g45_map_io(void)
>   {
>   	at91_init_sram(0, AT91SAM9G45_SRAM_BASE, AT91SAM9G45_SRAM_SIZE);
> +	init_consistent_dma_size(SZ_4M);
>   }
>
>   static void __init at91sam9g45_initialize(void)


-- 
Nicolas Ferre
