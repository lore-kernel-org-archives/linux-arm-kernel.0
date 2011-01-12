From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 12 Jan 2011 11:16:51 +0100
Subject: [PATCH v3 1/4] ARM: i.MX53: enable spi support
In-Reply-To: <AANLkTikS=cWfj1g0q8aj-d=5X8LvDduRn1xL4zJncJVs@mail.gmail.com>
References: <1294821324-5688-1-git-send-email-yong.shen@freescale.com>
	<1294821324-5688-2-git-send-email-yong.shen@freescale.com>
	<20110112093710.GD24920@pengutronix.de>
	<AANLkTikS=cWfj1g0q8aj-d=5X8LvDduRn1xL4zJncJVs@mail.gmail.com>
Message-ID: <20110112101651.GF24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 06:03:27PM +0800, Yong Shen wrote:
> hi Uwe,
> 
> >> -#define MX53_PAD_EIM_D16__GPIO_3_16          IOMUX_PAD(0x460, 0x118,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> >> -#define MX53_PAD_EIM_D17__GPIO_3_17          IOMUX_PAD(0x464, 0x11C,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> >> -#define MX53_PAD_EIM_D18__GPIO_3_18          IOMUX_PAD(0x468, 0x120,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> >> +#define MX53_PAD_EIM_D16__CSPI1_SCLK         IOMUX_PAD(0x460, 0x118,IOMUX_CONFIG_ALT4, 0x79c, 3, NO_PAD_CTRL)
> >> +#define MX53_PAD_EIM_D17__CSPI1_MISO         IOMUX_PAD(0x464, 0x11C,IOMUX_CONFIG_ALT4, 0x7a0, 3, NO_PAD_CTRL)
> >> +#define MX53_PAD_EIM_D18__CSPI1_MOSI         IOMUX_PAD(0x468, 0x120,IOMUX_CONFIG_ALT4, 0x7a4, 3, NO_PAD_CTRL)
> >> ?#define MX53_PAD_EIM_D20__GPIO_3_20 ? ? ? ? ?IOMUX_PAD(0x470, 0x128,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> >> ?#define MX53_PAD_EIM_D21__GPIO_3_21 ? ? ? ? ?IOMUX_PAD(0x474, 0x12C,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> > Why do you remove the GPIO definitions?
> >
> Why not? Anyway they are always used as cspi signals.
always as in "on the machines currently supported by mainline"?  This
can change.

>                                                       IMO, we don't
> need keep that many configures, and it's better to add them when
> needed.
This proved to not work nicely.  Better generate the complete header
using your excel sheet.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
