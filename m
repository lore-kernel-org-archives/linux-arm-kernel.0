From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 4 Apr 2012 11:19:17 +0200
Subject: [PATCH] ARM: mx53: fix pad definitions for
 MX53_PAD_EIM_D28__I2C1_SDA and MX53_PAD_GPIO_8__CAN1_RXCAN
In-Reply-To: <1333459179-9325-1-git-send-email-LW@KARO-electronics.de>
References: <1333459179-9325-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20120404091917.GP3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2012 at 03:19:39PM +0200, Lothar Wa?mann wrote:
> MX53_PAD_EIM_D28__I2C1_SDA uses an undefined PAD_CTRL_I2C
> MX53_PAD_GPIO_8__CAN1_RXCAN has an incorrect input_select value
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Applied, thanks

Sascha

> ---
>  arch/arm/plat-mxc/include/mach/iomux-mx53.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> index 527f8fe..9761e00 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> @@ -573,7 +573,7 @@
>  #define MX53_PAD_EIM_D28__UART2_CTS			IOMUX_PAD(0x494, 0x14C, 2, __NA_, 0, MX53_UART_PAD_CTRL)
>  #define MX53_PAD_EIM_D28__IPU_DISPB0_SER_DIO		IOMUX_PAD(0x494, 0x14C, 3, 0x82C, 1, NO_PAD_CTRL)
>  #define MX53_PAD_EIM_D28__CSPI_MOSI			IOMUX_PAD(0x494, 0x14C, 4, 0x788, 1, NO_PAD_CTRL)
> -#define MX53_PAD_EIM_D28__I2C1_SDA			IOMUX_PAD(0x494, 0x14C, 5 | IOMUX_CONFIG_SION, 0x818, 1, PAD_CTRL_I2C)
> +#define MX53_PAD_EIM_D28__I2C1_SDA			IOMUX_PAD(0x494, 0x14C, 5 | IOMUX_CONFIG_SION, 0x818, 1, NO_PAD_CTRL)
>  #define MX53_PAD_EIM_D28__IPU_EXT_TRIG			IOMUX_PAD(0x494, 0x14C, 6, __NA_, 0, NO_PAD_CTRL)
>  #define MX53_PAD_EIM_D28__IPU_DI0_PIN13			IOMUX_PAD(0x494, 0x14C, 7, __NA_, 0, NO_PAD_CTRL)
>  #define MX53_PAD_EIM_D29__EMI_WEIM_D_29			IOMUX_PAD(0x498, 0x150, 0, __NA_, 0, NO_PAD_CTRL)
> @@ -1187,7 +1187,7 @@
>  #define MX53_PAD_GPIO_8__ESAI1_TX5_RX0			IOMUX_PAD(0x6C8, 0x338, 0, 0x7F8, 1, NO_PAD_CTRL)
>  #define MX53_PAD_GPIO_8__GPIO1_8			IOMUX_PAD(0x6C8, 0x338, 1, __NA_, 0, NO_PAD_CTRL)
>  #define MX53_PAD_GPIO_8__EPIT2_EPITO			IOMUX_PAD(0x6C8, 0x338, 2, __NA_, 0, NO_PAD_CTRL)
> -#define MX53_PAD_GPIO_8__CAN1_RXCAN			IOMUX_PAD(0x6C8, 0x338, 3, 0x760, 3, NO_PAD_CTRL)
> +#define MX53_PAD_GPIO_8__CAN1_RXCAN			IOMUX_PAD(0x6C8, 0x338, 3, 0x760, 2, NO_PAD_CTRL)
>  #define MX53_PAD_GPIO_8__UART2_RXD_MUX			IOMUX_PAD(0x6C8, 0x338, 4, 0x880, 5, MX53_UART_PAD_CTRL)
>  #define MX53_PAD_GPIO_8__FIRI_TXD			IOMUX_PAD(0x6C8, 0x338, 5, __NA_, 0, NO_PAD_CTRL)
>  #define MX53_PAD_GPIO_8__SPDIF_SRCLK			IOMUX_PAD(0x6C8, 0x338, 6, __NA_, 0, NO_PAD_CTRL)
> -- 
> 1.7.2.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
