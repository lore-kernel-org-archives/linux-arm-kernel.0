From: qiangqing.zhang@nxp.com (Joakim Zhang)
Date: Mon, 12 Nov 2018 01:58:35 +0000
Subject: [PATCH V1 1/4] ARM: dts: imx6sx: Add flexcan stop mode wakeup
 support
In-Reply-To: <20181104073931.GC26016@tiger>
References: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
 <20181023052831.2553-2-qiangqing.zhang@nxp.com>
 <20181104073931.GC26016@tiger>
Message-ID: <DB7PR04MB461869CFD28338F9A812F334E6C10@DB7PR04MB4618.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: 2018?11?4? 15:40
> To: Joakim Zhang <qiangqing.zhang@nxp.com>
> Cc: s.hauer at pengutronix.de; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> robh+dt at kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; A.s. Dong
> <aisheng.dong@nxp.com>
> Subject: Re: [PATCH V1 1/4] ARM: dts: imx6sx: Add flexcan stop mode wakeup
> support
> 
> On Tue, Oct 23, 2018 at 05:30:44AM +0000, Joakim Zhang wrote:
> > From: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > Add stop-mode property which is required by stop mode wakeup feature.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx6sx.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6sx.dtsi
> > b/arch/arm/boot/dts/imx6sx.dtsi index 844caa39364f..3f459d6da7fc
> > 100644
> > --- a/arch/arm/boot/dts/imx6sx.dtsi
> > +++ b/arch/arm/boot/dts/imx6sx.dtsi
> > @@ -448,6 +448,7 @@
> >  				clocks = <&clks IMX6SX_CLK_CAN1_IPG>,
> >  					 <&clks IMX6SX_CLK_CAN1_SERIAL>;
> >  				clock-names = "ipg", "per";
> > +				stop-mode = <&gpr 0x10 1 0x10 17>;
> 
> Is it supported by upstream?  I cannot find this property in ether flexcan
> bindings doc or kernel driver.
> 
> Shawn

Hi Shawn,
This property has been reviewed by maintainer in flexcan bindings and kernel driver has sent to review.

Best Regards,
Joakim Zhang

> >  				status = "disabled";
> >  			};
> >
> > @@ -458,6 +459,7 @@
> >  				clocks = <&clks IMX6SX_CLK_CAN2_IPG>,
> >  					 <&clks IMX6SX_CLK_CAN2_SERIAL>;
> >  				clock-names = "ipg", "per";
> > +				stop-mode = <&gpr 0x10 2 0x10 18>;
> >  				status = "disabled";
> >  			};
> >
> > --
> > 2.17.1
> >
