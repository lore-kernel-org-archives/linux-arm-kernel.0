From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 15 Jun 2017 04:52:43 +0000
Subject: [PATCH 2/2] RFC: ARM: dts: imx7d-sdb: swap pad settings for
 USDHCx 50Mhz and 100Mhz
In-Reply-To: <20170615033935.GB5902@dragon>
References: <1496857542-32200-1-git-send-email-troy.kisky@boundarydevices.com>
 <1496857542-32200-2-git-send-email-troy.kisky@boundarydevices.com>
 <20170615033935.GB5902@dragon>
Message-ID: <AM3PR04MB306D408040CC246D4CB3FBD80C00@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Thursday, June 15, 2017 11:40 AM
> To: Troy Kisky; A.s. Dong; Frank Li
> Cc: shawn.guo at linaro.org; Fabio Estevam; gary.bisson at boundarydevices.com;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 2/2] RFC: ARM: dts: imx7d-sdb: swap pad settings for
> USDHCx 50Mhz and 100Mhz
> 
> On Wed, Jun 07, 2017 at 10:45:42AM -0700, Troy Kisky wrote:
> > It does not make sense that 100 Mhz pad settings would use a x2
> > setting and 50 Mhz would use a x4 setting, so swap.
> >
> > Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> 
> Add Dong and Frank for this one as well.
> 

I'm ok with this one.

But you need double check PATCH 1/2 as CLK part in this one depends on it.

Regards
Dong Aisheng

> Shawn
> 
> > ---
> >  arch/arm/boot/dts/imx7d-sdb.dts | 72
> > ++++++++++++++++++++---------------------
> >  1 file changed, 36 insertions(+), 36 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx7d-sdb.dts
> > b/arch/arm/boot/dts/imx7d-sdb.dts index cab9208..70dcbf4 100644
> > --- a/arch/arm/boot/dts/imx7d-sdb.dts
> > +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> > @@ -590,31 +590,20 @@
> >
> >  		pinctrl_usdhc1: usdhc1grp {
> >  			fsl,pins = <
> > -				MX7D_PAD_SD1_CMD__SD1_CMD		0x59
> > -				MX7D_PAD_SD1_CLK__SD1_CLK		0x09
> > -				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
> > -				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
> > -				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
> > -				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
> > -				MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x59 /* CD */
> > -				MX7D_PAD_SD1_WP__GPIO5_IO1		0x59 /* WP */
> > -				MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0x59 /*
> vmmc */
> > +				MX7D_PAD_SD1_CMD__SD1_CMD		0x5a
> > +				MX7D_PAD_SD1_CLK__SD1_CLK		0x0a
> > +				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5a
> > +				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5a
> > +				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5a
> > +				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5a
> > +				MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x5a /* CD */
> > +				MX7D_PAD_SD1_WP__GPIO5_IO1		0x5a /* WP */
> > +				MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0x5a /*
> vmmc */
> >  			>;
> >  		};
> >
> >  		pinctrl_usdhc2: usdhc2grp {
> >  			fsl,pins = <
> > -				MX7D_PAD_SD2_CMD__SD2_CMD		0x59
> > -				MX7D_PAD_SD2_CLK__SD2_CLK		0x09
> > -				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x59
> > -				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x59
> > -				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x59
> > -				MX7D_PAD_SD2_DATA3__SD2_DATA3		0x59
> > -			>;
> > -		};
> > -
> > -		pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {
> > -			fsl,pins = <
> >  				MX7D_PAD_SD2_CMD__SD2_CMD		0x5a
> >  				MX7D_PAD_SD2_CLK__SD2_CLK		0x0a
> >  				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5a
> > @@ -624,6 +613,17 @@
> >  			>;
> >  		};
> >
> > +		pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {
> > +			fsl,pins = <
> > +				MX7D_PAD_SD2_CMD__SD2_CMD		0x59
> > +				MX7D_PAD_SD2_CLK__SD2_CLK		0x09
> > +				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x59
> > +				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x59
> > +				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x59
> > +				MX7D_PAD_SD2_DATA3__SD2_DATA3		0x59
> > +			>;
> > +		};
> > +
> >  		pinctrl_usdhc2_200mhz: usdhc2grp_200mhz {
> >  			fsl,pins = <
> >  				MX7D_PAD_SD2_CMD__SD2_CMD		0x5b
> > @@ -638,22 +638,6 @@
> >
> >  		pinctrl_usdhc3: usdhc3grp {
> >  			fsl,pins = <
> > -				MX7D_PAD_SD3_CMD__SD3_CMD		0x59
> > -				MX7D_PAD_SD3_CLK__SD3_CLK		0x09
> > -				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
> > -				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
> > -				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
> > -				MX7D_PAD_SD3_DATA3__SD3_DATA3		0x59
> > -				MX7D_PAD_SD3_DATA4__SD3_DATA4		0x59
> > -				MX7D_PAD_SD3_DATA5__SD3_DATA5		0x59
> > -				MX7D_PAD_SD3_DATA6__SD3_DATA6		0x59
> > -				MX7D_PAD_SD3_DATA7__SD3_DATA7		0x59
> > -				MX7D_PAD_SD3_STROBE__SD3_STROBE		0x19
> > -			>;
> > -		};
> > -
> > -		pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
> > -			fsl,pins = <
> >  				MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
> >  				MX7D_PAD_SD3_CLK__SD3_CLK		0x0a
> >  				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5a
> > @@ -668,6 +652,22 @@
> >  			>;
> >  		};
> >
> > +		pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
> > +			fsl,pins = <
> > +				MX7D_PAD_SD3_CMD__SD3_CMD		0x59
> > +				MX7D_PAD_SD3_CLK__SD3_CLK		0x09
> > +				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
> > +				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
> > +				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
> > +				MX7D_PAD_SD3_DATA3__SD3_DATA3		0x59
> > +				MX7D_PAD_SD3_DATA4__SD3_DATA4		0x59
> > +				MX7D_PAD_SD3_DATA5__SD3_DATA5		0x59
> > +				MX7D_PAD_SD3_DATA6__SD3_DATA6		0x59
> > +				MX7D_PAD_SD3_DATA7__SD3_DATA7		0x59
> > +				MX7D_PAD_SD3_STROBE__SD3_STROBE		0x19
> > +			>;
> > +		};
> > +
> >  		pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
> >  			fsl,pins = <
> >  				MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
