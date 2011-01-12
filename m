From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 12 Jan 2011 11:42:00 +0100
Subject: [PATCH v3 2/4] ARM: i.MX53 EVK: add spi device
In-Reply-To: <AANLkTimFGB1BysGiQhgpc9Dq=6t8JYdeKDY_iR1=HzO7@mail.gmail.com>
References: <1294821324-5688-1-git-send-email-yong.shen@freescale.com>
	<1294821324-5688-3-git-send-email-yong.shen@freescale.com>
	<20110112094033.GE24920@pengutronix.de>
	<AANLkTimFGB1BysGiQhgpc9Dq=6t8JYdeKDY_iR1=HzO7@mail.gmail.com>
Message-ID: <20110112104200.GG24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 06:10:26PM +0800, Yong Shen wrote:
> Hi Uwe,
> 
> >> + ? ? MX53_PAD_EIM_D16__CSPI1_SCLK,
> >> + ? ? MX53_PAD_EIM_D17__CSPI1_MISO,
> >> + ? ? MX53_PAD_EIM_D18__CSPI1_MOSI,
> > did the v2 patch work at all?
> 
> Yes, it did work. Only the pad names were wrong, the configurations
> were right, so v3 changed the names to match the configuration.
you didn't just rename the defines but really changed them.  (Which
might or might not mean something.):

> -#define MX53_PAD_EIM_D16__GPIO_3_16          IOMUX_PAD(0x460, 0x118,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> -#define MX53_PAD_EIM_D17__GPIO_3_17          IOMUX_PAD(0x464, 0x11C,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> -#define MX53_PAD_EIM_D18__GPIO_3_18          IOMUX_PAD(0x468, 0x120,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> +#define MX53_PAD_EIM_D16__CSPI1_SCLK         IOMUX_PAD(0x460, 0x118,IOMUX_CONFIG_ALT4, 0x79c, 3, NO_PAD_CTRL)
> +#define MX53_PAD_EIM_D17__CSPI1_MISO         IOMUX_PAD(0x464, 0x11C,IOMUX_CONFIG_ALT4, 0x7a0, 3, NO_PAD_CTRL)
> +#define MX53_PAD_EIM_D18__CSPI1_MOSI         IOMUX_PAD(0x468, 0x120,IOMUX_CONFIG_ALT4, 0x7a4, 3, NO_PAD_CTRL)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
