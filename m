From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 12 Jan 2011 10:40:33 +0100
Subject: [PATCH v3 2/4] ARM: i.MX53 EVK: add spi device
In-Reply-To: <1294821324-5688-3-git-send-email-yong.shen@freescale.com>
References: <1294821324-5688-1-git-send-email-yong.shen@freescale.com>
	<1294821324-5688-3-git-send-email-yong.shen@freescale.com>
Message-ID: <20110112094033.GE24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 04:35:22PM +0800, yong.shen at freescale.com wrote:
> From: Yong Shen <yong.shen@freescale.com>
> 
> 1. add platform data for spi device
> 2. Kconfig change
> 
> Signed-off-by: Yong Shen <yong.shen@freescale.com>
> ---
>  arch/arm/mach-mx5/Kconfig          |    1 +
>  arch/arm/mach-mx5/board-mx53_evk.c |   21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 23b0e3f..777740b 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -126,6 +126,7 @@ config MACH_MX53_EVK
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_IMX_I2C
>  	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
> +	select IMX_HAVE_PLATFORM_SPI_IMX
>  	help
>  	  Include support for MX53 EVK platform. This includes specific
>  	  configurations for the board and its peripherals.
> diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
> index 4043451..157fe12 100644
> --- a/arch/arm/mach-mx5/board-mx53_evk.c
> +++ b/arch/arm/mach-mx5/board-mx53_evk.c
> @@ -33,6 +33,8 @@
>  #include <mach/iomux-mx53.h>
>  
>  #define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
> +#define EVK_ECSPI1_CS0		IMX_GPIO_NR(2, 30)
> +#define EVK_ECSPI1_CS1		IMX_GPIO_NR(3, 19)
>  
>  #include "crm_regs.h"
>  #include "devices-imx53.h"
> @@ -52,6 +54,13 @@ static iomux_v3_cfg_t mx53_evk_pads[] = {
>  	MX53_PAD_ATA_CS_1__UART3_RXD,
>  	MX53_PAD_ATA_DA_1__UART3_CTS,
>  	MX53_PAD_ATA_DA_2__UART3_RTS,
> +
> +	MX53_PAD_EIM_D16__CSPI1_SCLK,
> +	MX53_PAD_EIM_D17__CSPI1_MISO,
> +	MX53_PAD_EIM_D18__CSPI1_MOSI,
did the v2 patch work at all?
> +
> +	MX53_PAD_EIM_EB2__GPIO_2_30,
> +	MX53_PAD_EIM_D19__GPIO_3_19,
IMO there's a comment missing what is the purpose of these.  I suggest
to remove the empty line above and write something like /* ecspi.0 with
chip select lines */ over MX53_PAD_EIM_D16__CSPI1_SCLK.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
