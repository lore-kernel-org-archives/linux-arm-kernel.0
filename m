From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 10 Jun 2010 08:36:28 +0200
Subject: [PATCH 1/8] MX25: put define for OTG base address in right include
In-Reply-To: <1275987782-16094-1-git-send-email-eric@eukrea.com>
References: <1275987782-16094-1-git-send-email-eric@eukrea.com>
Message-ID: <20100610063627.GF20799@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

applied all but the last one which needs another patch.

Sascha

On Tue, Jun 08, 2010 at 11:02:55AM +0200, Eric B?nard wrote:
> the standard place for this define is include/mach/mx25.h
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  arch/arm/mach-mx25/devices.c          |    2 --
>  arch/arm/plat-mxc/include/mach/mx25.h |    1 +
>  2 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
> index 3a405fa..032a347 100644
> --- a/arch/arm/mach-mx25/devices.c
> +++ b/arch/arm/mach-mx25/devices.c
> @@ -117,8 +117,6 @@ struct platform_device mxc_uart_device4 = {
>  	.num_resources = ARRAY_SIZE(uart4),
>  };
>  
> -#define MX25_OTG_BASE_ADDR 0x53FF4000
> -
>  static u64 otg_dmamask = DMA_BIT_MASK(32);
>  
>  static struct resource mxc_otg_resources[] = {
> diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
> index 4eb6e33..bc0ba27 100644
> --- a/arch/arm/plat-mxc/include/mach/mx25.h
> +++ b/arch/arm/plat-mxc/include/mach/mx25.h
> @@ -34,6 +34,7 @@
>  #define MX25_NFC_BASE_ADDR		0xbb000000
>  #define MX25_DRYICE_BASE_ADDR		0x53ffc000
>  #define MX25_LCDC_BASE_ADDR		0x53fbc000
> +#define MX25_OTG_BASE_ADDR		0x53ff4000
>  
>  #define MX25_INT_DRYICE	25
>  #define MX25_INT_FEC	57
> -- 
> 1.6.3.3
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
