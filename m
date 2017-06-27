From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 27 Jun 2017 05:32:00 +0000
Subject: [PATCH 1/2] RFC: ARM: dts: imx7d-sdb: remove 100k pull-down on
 USDHCx clock
In-Reply-To: <c69c5ffb-1142-74fa-4be4-1112c49ae67c@boundarydevices.com>
References: <1496857542-32200-1-git-send-email-troy.kisky@boundarydevices.com>
 <20170615033851.GA5902@dragon>
 <AM3PR04MB306DAC69AE94A872373206280C00@AM3PR04MB306.eurprd04.prod.outlook.com>
 <c69c5ffb-1142-74fa-4be4-1112c49ae67c@boundarydevices.com>
Message-ID: <AM3PR04MB306F527858F26C0F686617880DC0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Troy,

> -----Original Message-----
> From: Troy Kisky [mailto:troy.kisky at boundarydevices.com]
> Sent: Friday, June 16, 2017 1:46 AM
> To: A.s. Dong; Shawn Guo; Frank Li
> Cc: shawn.guo at linaro.org; Fabio Estevam; gary.bisson at boundarydevices.com;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/2] RFC: ARM: dts: imx7d-sdb: remove 100k pull-down
> on USDHCx clock
> 
> On 6/14/2017 9:31 PM, A.s. Dong wrote:
> > Hi Troy,
> >
> >> -----Original Message-----
> >> From: Shawn Guo [mailto:shawnguo at kernel.org]
> >> Sent: Thursday, June 15, 2017 11:39 AM
> >> To: Troy Kisky; A.s. Dong; Frank Li
> >> Cc: shawn.guo at linaro.org; Fabio Estevam;
> >> gary.bisson at boundarydevices.com; linux-arm-kernel at lists.infradead.org
> >> Subject: Re: [PATCH 1/2] RFC: ARM: dts: imx7d-sdb: remove 100k
> >> pull-down on USDHCx clock
> >>
> >> On Wed, Jun 07, 2017 at 10:45:41AM -0700, Troy Kisky wrote:
> >>> No i.mx6q board uses a 100k pull-down on clock, why should i.mx7d ?
> >>>
> >
> > I saw the mx7d evk clk resistor pull-down is DNP, then why we disable
> > internal pad pull-down?
> 
> 
> That sounds like a very good reason to disable to me.
> Why rely on a DNP? Also, consistency with imx6 is nice.
> 

Sorry missed your reply.

Not quite understand your point.
We would like to pull down the clk signal in default state,
But due to the board pull-down resistor is DNP (not exist),
That's why we use internal pull down function instead.

Regards
Dong Aisheng

> 
> >
> > Regards
> > Dong Aisheng
> >
> >>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> >>
> >> Add Dong and Frank who may help to confirm.
> >>
> >> Shawn
> >>
> >>> ---
> >>>  arch/arm/boot/dts/imx7d-sdb.dts | 14 +++++++-------
> >>>  1 file changed, 7 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts
> >>> b/arch/arm/boot/dts/imx7d-sdb.dts index 54c4540..cab9208 100644
> >>> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> >>> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> >>> @@ -591,7 +591,7 @@
> >>>  		pinctrl_usdhc1: usdhc1grp {
> >>>  			fsl,pins = <
> >>>  				MX7D_PAD_SD1_CMD__SD1_CMD		0x59
> >>> -				MX7D_PAD_SD1_CLK__SD1_CLK		0x19
> >>> +				MX7D_PAD_SD1_CLK__SD1_CLK		0x09
> >>>  				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
> >>>  				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
> >>>  				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
> >>> @@ -605,7 +605,7 @@
> >>>  		pinctrl_usdhc2: usdhc2grp {
> >>>  			fsl,pins = <
> >>>  				MX7D_PAD_SD2_CMD__SD2_CMD		0x59
> >>> -				MX7D_PAD_SD2_CLK__SD2_CLK		0x19
> >>> +				MX7D_PAD_SD2_CLK__SD2_CLK		0x09
> >>>  				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x59
> >>>  				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x59
> >>>  				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x59
> >>> @@ -616,7 +616,7 @@
> >>>  		pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {
> >>>  			fsl,pins = <
> >>>  				MX7D_PAD_SD2_CMD__SD2_CMD		0x5a
> >>> -				MX7D_PAD_SD2_CLK__SD2_CLK		0x1a
> >>> +				MX7D_PAD_SD2_CLK__SD2_CLK		0x0a
> >>>  				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5a
> >>>  				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x5a
> >>>  				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x5a
> >>> @@ -627,7 +627,7 @@
> >>>  		pinctrl_usdhc2_200mhz: usdhc2grp_200mhz {
> >>>  			fsl,pins = <
> >>>  				MX7D_PAD_SD2_CMD__SD2_CMD		0x5b
> >>> -				MX7D_PAD_SD2_CLK__SD2_CLK		0x1b
> >>> +				MX7D_PAD_SD2_CLK__SD2_CLK		0x0b
> >>>  				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5b
> >>>  				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x5b
> >>>  				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x5b
> >>> @@ -639,7 +639,7 @@
> >>>  		pinctrl_usdhc3: usdhc3grp {
> >>>  			fsl,pins = <
> >>>  				MX7D_PAD_SD3_CMD__SD3_CMD		0x59
> >>> -				MX7D_PAD_SD3_CLK__SD3_CLK		0x19
> >>> +				MX7D_PAD_SD3_CLK__SD3_CLK		0x09
> >>>  				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
> >>>  				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
> >>>  				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
> >>> @@ -655,7 +655,7 @@
> >>>  		pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
> >>>  			fsl,pins = <
> >>>  				MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
> >>> -				MX7D_PAD_SD3_CLK__SD3_CLK		0x1a
> >>> +				MX7D_PAD_SD3_CLK__SD3_CLK		0x0a
> >>>  				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5a
> >>>  				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5a
> >>>  				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5a
> >>> @@ -671,7 +671,7 @@
> >>>  		pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
> >>>  			fsl,pins = <
> >>>  				MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
> >>> -				MX7D_PAD_SD3_CLK__SD3_CLK		0x1b
> >>> +				MX7D_PAD_SD3_CLK__SD3_CLK		0x0b
> >>>  				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5b
> >>>  				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5b
> >>>  				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5b
> >>> --
> >>> 2.7.4
> >>>
> >>>
> >>> _______________________________________________
> >>> linux-arm-kernel mailing list
> >>> linux-arm-kernel at lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
