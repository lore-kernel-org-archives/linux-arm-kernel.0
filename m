From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Feb 2011 09:20:08 +0100
Subject: [PATCH v3 2/6] ARM: mxs: make ssp error irq definition consistent
In-Reply-To: <1298284979-14853-3-git-send-email-shawn.guo@freescale.com>
References: <1298284979-14853-1-git-send-email-shawn.guo@freescale.com>
	<1298284979-14853-3-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110222082008.GT22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 06:42:55PM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/include/mach/mx23.h |    2 +-
>  arch/arm/mach-mxs/include/mach/mx28.h |    8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/include/mach/mx23.h b/arch/arm/mach-mxs/include/mach/mx23.h
> index 1730c9c..e858692 100644
> --- a/arch/arm/mach-mxs/include/mach/mx23.h
> +++ b/arch/arm/mach-mxs/include/mach/mx23.h
> @@ -93,7 +93,7 @@
>  #define MX23_INT_USB_WAKEUP		12
>  #define MX23_INT_GPMI_DMA		13
>  #define MX23_INT_SSP1_DMA		14
> -#define MX23_INT_SSP_ERROR		15
> +#define MX23_INT_SSP1_ERROR		15
SSP_ERROR matches the reference manual, but using SSP1 looks correct as
there are >1 SSPs.

>  #define MX23_INT_GPIO0			16
>  #define MX23_INT_GPIO1			17
>  #define MX23_INT_GPIO2			18
> diff --git a/arch/arm/mach-mxs/include/mach/mx28.h b/arch/arm/mach-mxs/include/mach/mx28.h
> index 3f3485a..75d8611 100644
> --- a/arch/arm/mach-mxs/include/mach/mx28.h
> +++ b/arch/arm/mach-mxs/include/mach/mx28.h
> @@ -163,10 +163,10 @@
>  #define MX28_INT_USB0			93
>  #define MX28_INT_USB1_WAKEUP		94
>  #define MX28_INT_USB0_WAKEUP		95
> -#define MX28_INT_SSP0			96
> -#define MX28_INT_SSP1			97
> -#define MX28_INT_SSP2			98
> -#define MX28_INT_SSP3			99
> +#define MX28_INT_SSP0_ERROR		96
> +#define MX28_INT_SSP1_ERROR		97
> +#define MX28_INT_SSP2_ERROR		98
> +#define MX28_INT_SSP3_ERROR		99
>  #define MX28_INT_ENET_SWI		100
>  #define MX28_INT_ENET_MAC0		101
>  #define MX28_INT_ENET_MAC1		102
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
