From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Thu, 9 Apr 2015 15:31:39 +0000
Subject: [PATCH 2/2] arm/dts: Add nodes for flexcan devices present on
 LS1021A SoC
In-Reply-To: <55269444.7050707@pengutronix.de>
References: <1428591087-12831-1-git-send-email-bhupesh.sharma@freescale.com>
 <1428591087-12831-2-git-send-email-bhupesh.sharma@freescale.com>
 <55269444.7050707@pengutronix.de>
Message-ID: <BY1PR0301MB130321631BC01630EA87441282FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

> From: Marc Kleine-Budde [mailto:mkl at pengutronix.de]
> 
> On 04/09/2015 04:51 PM, Bhupesh Sharma wrote:
> > From: Sakar Arora <Sakar.Arora@freescale.com>
> >
> > This patch adds the device nodes for flexcan controller(s) present on
> > LS1021A SoC.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
> > ---
> >  arch/arm/boot/dts/ls1021a-qds.dts |    8 ++++++++
> >  arch/arm/boot/dts/ls1021a.dtsi    |   20 ++++++++++++++++++++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/ls1021a-qds.dts
> > b/arch/arm/boot/dts/ls1021a-qds.dts
> > index 9c5e16b..1641a04 100644
> > --- a/arch/arm/boot/dts/ls1021a-qds.dts
> > +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> > @@ -238,3 +238,11 @@
> >  &uart1 {
> >  	status = "okay";
> >  };
> > +
> > +&can0 {
> > +	status = "okay";
> > +};
> > +
> > +&can1 {
> > +	status = "okay";
> > +};
> > diff --git a/arch/arm/boot/dts/ls1021a.dtsi
> > b/arch/arm/boot/dts/ls1021a.dtsi index c70bb27..c44661b 100644
> > --- a/arch/arm/boot/dts/ls1021a.dtsi
> > +++ b/arch/arm/boot/dts/ls1021a.dtsi
> > @@ -332,6 +332,26 @@
> >  			status = "disabled";
> >  		};
> >
> > +		can0: can at 2a70000 {
> > +			compatible = "fsl,ls1021a-flexcan";
> > +			reg = <0x0 0x2a70000 0x0 0x1000>;
> > +			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&platform_clk 1>;
> > +			clock-frequency = <150000000>;
> 
> Please don't use clock-frequency, it's only needed for powerpcs without
> proper clock support.

Ok. Will fix in v2.

> 
> > +			clock-names = "per";
> 
> Please provide a per and ipg clock, otherwise the driver will not work
> properly.

Ok. Will fix in v2.

> > +			little-endian;
> > +		};
> 

Regards,
Bhupesh
