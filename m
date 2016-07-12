From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 12 Jul 2016 21:15:41 +0200
Subject: [PATCH 3/6] ARM: dts: imx25: substitute NO_PAD_CTL by the
 respective reset value
In-Reply-To: <CAOMZO5D2E_G4ySUnj=yadziSunwMBSVZs-Rw=EvNybFKs2iD3w@mail.gmail.com>
References: <1468145266-7567-1-git-send-email-uwe@kleine-koenig.org>
 <1468145266-7567-4-git-send-email-uwe@kleine-koenig.org>
 <CAOMZO5A=6HLPacwp0seBn_s+AVF7zaUjUO8wOb1WoyvU1JrH7A@mail.gmail.com>
 <20160711073721.GM16643@pengutronix.de>
 <CAOMZO5ASsA88TQLAPdyit0xr3Lqh8e+8C_ZgoUa7w2rZxTb-ag@mail.gmail.com>
 <20160712073859.GQ16643@pengutronix.de>
 <CAOMZO5B+grtejgSMKrZMT9inEdh+bL0smZKE52qtcQD1NCHrqQ@mail.gmail.com>
 <CAOMZO5D2E_G4ySUnj=yadziSunwMBSVZs-Rw=EvNybFKs2iD3w@mail.gmail.com>
Message-ID: <20160712191541.GY16643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Tue, Jul 12, 2016 at 03:32:54PM -0300, Fabio Estevam wrote:
> On Tue, Jul 12, 2016 at 12:15 PM, Fabio Estevam <festevam@gmail.com> wrote:
> 
> > I will try to get access to a mx25pdk and will confirm soon. Thanks
> 
> Please find attached the patch after reading all the PAD_CTL
> registers. Feel free to submit it as part of your series.

> From a2b9e24841909868803576c68c2d2b064a00d4a9 Mon Sep 17 00:00:00 2001
> From: Fabio Estevam <fabio.estevam@nxp.com>
> Date: Tue, 12 Jul 2016 15:19:02 -0300
> Subject: [PATCH] ARM: dts: imx25-pdk: Explicitly setup PAD config in dts
> 
> When passing 0x80000000 as the PAD_CTL config value, the kernel does
> not touch the PAD_CTL egisters and use the value that comes from the
> bootloader.
> 
> Instead of relying on the bootloader it is better to have the kernel
> to explicitly configure the PAD_CTL registers.
> 
> Modified each 0x80000000 occurrance by reading the real PAD_CTL
> registers values in the bootloader and putting in the dts.
> 
> Also tested by booting the resulting dtb.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx25-pdk.dts | 58 ++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
> index 7029210..e997e2b 100644
> --- a/arch/arm/boot/dts/imx25-pdk.dts
> +++ b/arch/arm/boot/dts/imx25-pdk.dts
> @@ -159,56 +159,56 @@
>  			fsl,pins = <
>  				MX25_PAD_GPIO_A__CAN1_TX		0x0
>  				MX25_PAD_GPIO_B__CAN1_RX		0x0
> -				MX25_PAD_D14__GPIO_4_6 			0x80000000
> +				MX25_PAD_D14__GPIO_4_6 			0xa1
>  			>;
>  		};
>  
>  		pinctrl_esdhc1: esdhc1grp {
>  			fsl,pins = <
> -				MX25_PAD_SD1_CMD__SD1_CMD		0x80000000
> -				MX25_PAD_SD1_CLK__SD1_CLK		0x80000000
> -				MX25_PAD_SD1_DATA0__SD1_DATA0		0x80000000
> -				MX25_PAD_SD1_DATA1__SD1_DATA1		0x80000000
> -				MX25_PAD_SD1_DATA2__SD1_DATA2		0x80000000
> -				MX25_PAD_SD1_DATA3__SD1_DATA3		0x80000000
> -				MX25_PAD_A14__GPIO_2_0			0x80000000
> -				MX25_PAD_A15__GPIO_2_1			0x80000000
> +				MX25_PAD_SD1_CMD__SD1_CMD		0xe1
> +				MX25_PAD_SD1_CLK__SD1_CLK		0xd1
> +				MX25_PAD_SD1_DATA0__SD1_DATA0		0xe1
> +				MX25_PAD_SD1_DATA1__SD1_DATA1		0xd1
> +				MX25_PAD_SD1_DATA2__SD1_DATA2		0xd1
> +				MX25_PAD_SD1_DATA3__SD1_DATA3		0xe1
> +				MX25_PAD_A14__GPIO_2_0			0x80
> +				MX25_PAD_A15__GPIO_2_1			0x00
>  			>;
>  		};
>  
>  		pinctrl_fec: fecgrp {
>  			fsl,pins = <
> -				MX25_PAD_FEC_MDC__FEC_MDC		0x80000000
> +				MX25_PAD_FEC_MDC__FEC_MDC		0x00
>  				MX25_PAD_FEC_MDIO__FEC_MDIO		0x400001e0
> -				MX25_PAD_FEC_TDATA0__FEC_TDATA0		0x80000000
> -				MX25_PAD_FEC_TDATA1__FEC_TDATA1		0x80000000
> -				MX25_PAD_FEC_TX_EN__FEC_TX_EN		0x80000000
> -				MX25_PAD_FEC_RDATA0__FEC_RDATA0		0x80000000
> -				MX25_PAD_FEC_RDATA1__FEC_RDATA1		0x80000000
> -				MX25_PAD_FEC_RX_DV__FEC_RX_DV		0x80000000
> +				MX25_PAD_FEC_TDATA0__FEC_TDATA0		0x00
> +				MX25_PAD_FEC_TDATA1__FEC_TDATA1		0x00
> +				MX25_PAD_FEC_TX_EN__FEC_TX_EN		0x00
> +				MX25_PAD_FEC_RDATA0__FEC_RDATA0		0xc0
> +				MX25_PAD_FEC_RDATA1__FEC_RDATA1		0xc0
> +				MX25_PAD_FEC_RX_DV__FEC_RX_DV		0xc0
>  				MX25_PAD_FEC_TX_CLK__FEC_TX_CLK		0x1c0
> -				MX25_PAD_A17__GPIO_2_3			0x80000000
> -				MX25_PAD_D12__GPIO_4_8			0x80000000
> +				MX25_PAD_A17__GPIO_2_3			0x00
> +				MX25_PAD_D12__GPIO_4_8			0x00
>  			>;
>  		};
>  
>  		pinctrl_i2c1: i2c1grp {
>  			fsl,pins = <
> -				MX25_PAD_I2C1_CLK__I2C1_CLK		0x80000000
> -				MX25_PAD_I2C1_DAT__I2C1_DAT		0x80000000
> +				MX25_PAD_I2C1_CLK__I2C1_CLK		0xa8
> +				MX25_PAD_I2C1_DAT__I2C1_DAT		0xa8
>  			>;
>  		};
>  
>  		pinctrl_kpp: kppgrp {
>  			fsl,pins = <
> -				MX25_PAD_KPP_ROW0__KPP_ROW0	0x80000000
> -				MX25_PAD_KPP_ROW1__KPP_ROW1	0x80000000
> -				MX25_PAD_KPP_ROW2__KPP_ROW2	0x80000000
> -				MX25_PAD_KPP_ROW3__KPP_ROW3	0x80000000
> -				MX25_PAD_KPP_COL0__KPP_COL0	0x80000000
> -				MX25_PAD_KPP_COL1__KPP_COL1	0x80000000
> -				MX25_PAD_KPP_COL2__KPP_COL2	0x80000000
> -				MX25_PAD_KPP_COL3__KPP_COL3	0x80000000
> +				MX25_PAD_KPP_ROW0__KPP_ROW0	0xa0
> +				MX25_PAD_KPP_ROW1__KPP_ROW1	0xa0
> +				MX25_PAD_KPP_ROW2__KPP_ROW2	0xe0
> +				MX25_PAD_KPP_ROW3__KPP_ROW3	0xe0
> +				MX25_PAD_KPP_COL0__KPP_COL0	0xa8
> +				MX25_PAD_KPP_COL1__KPP_COL1	0xa8
> +				MX25_PAD_KPP_COL2__KPP_COL2	0xa8
> +				MX25_PAD_KPP_COL3__KPP_COL3	0xa8
>  			>;
>  		};
>  
> @@ -244,7 +244,7 @@
>  			fsl,pins = <
>  				MX25_PAD_UART1_RTS__UART1_RTS		0xe0
>  				MX25_PAD_UART1_CTS__UART1_CTS		0xe0
> -				MX25_PAD_UART1_TXD__UART1_TXD		0x80000000
> +				MX25_PAD_UART1_TXD__UART1_TXD		0x00
>  				MX25_PAD_UART1_RXD__UART1_RXD		0xc0

Are you sure here? According to the reference manual bit 0x40 of
IOMUXC_SW_PAD_CTL_PAD_UART1_RXD isn't valid. And my i.mx25 based machine
agrees:

	barebox at imx25:/ mw 0x43fac368 0xc0
	barebox at imx25:/ md 0x43fac368+4
	43fac368: 00000080                                           ....

(This entry was fixed in my series to 0x80.) So you only checked the
NO_PAD_CTL values, right?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
