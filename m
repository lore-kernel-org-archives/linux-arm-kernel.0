From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 12 Jan 2011 10:37:10 +0100
Subject: [PATCH v3 1/4] ARM: i.MX53: enable spi support
In-Reply-To: <1294821324-5688-2-git-send-email-yong.shen@freescale.com>
References: <1294821324-5688-1-git-send-email-yong.shen@freescale.com>
	<1294821324-5688-2-git-send-email-yong.shen@freescale.com>
Message-ID: <20110112093710.GD24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Yong,

On Wed, Jan 12, 2011 at 04:35:21PM +0800, yong.shen at freescale.com wrote:
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> @@ -131,9 +131,9 @@ typedef enum iomux_config {
>  #define MX53_PAD_JTAG_TDO__JTAG_TDO		IOMUX_PAD(0x454, NON_MUX_I, IOMUX_CONFIG_ALT0, 0x0, 0, NO_PAD_CTRL)
>  #define MX53_PAD_EIM_A25__GPIO_5_2		IOMUX_PAD(0x458, 0x110,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
>  #define MX53_PAD_EIM_EB2__GPIO_2_30		IOMUX_PAD(0x45C, 0x114,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> -#define MX53_PAD_EIM_D16__GPIO_3_16		IOMUX_PAD(0x460, 0x118,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> -#define MX53_PAD_EIM_D17__GPIO_3_17		IOMUX_PAD(0x464, 0x11C,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> -#define MX53_PAD_EIM_D18__GPIO_3_18		IOMUX_PAD(0x468, 0x120,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> +#define MX53_PAD_EIM_D16__CSPI1_SCLK		IOMUX_PAD(0x460, 0x118,IOMUX_CONFIG_ALT4, 0x79c, 3, NO_PAD_CTRL)
> +#define MX53_PAD_EIM_D17__CSPI1_MISO		IOMUX_PAD(0x464, 0x11C,IOMUX_CONFIG_ALT4, 0x7a0, 3, NO_PAD_CTRL)
> +#define MX53_PAD_EIM_D18__CSPI1_MOSI		IOMUX_PAD(0x468, 0x120,IOMUX_CONFIG_ALT4, 0x7a4, 3, NO_PAD_CTRL)
>  #define MX53_PAD_EIM_D19__GPIO_3_19		IOMUX_PAD(0x46C, 0x124,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
>  #define MX53_PAD_EIM_D20__GPIO_3_20		IOMUX_PAD(0x470, 0x128,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
>  #define MX53_PAD_EIM_D21__GPIO_3_21		IOMUX_PAD(0x474, 0x12C,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
Why do you remove the GPIO definitions?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
