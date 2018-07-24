From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 24 Jul 2018 02:04:57 +0000
Subject: [PATCH v6 4/5] ARM: dts: imx7s: add i.MX7 messaging unit support
In-Reply-To: <1532365033.3163.107.camel@pengutronix.de>
References: <20180722063923.30222-1-o.rempel@pengutronix.de>
 <20180722063923.30222-5-o.rempel@pengutronix.de>
 <1532365033.3163.107.camel@pengutronix.de>
Message-ID: <AM0PR04MB4211AAB88B1F694BF70D729A80550@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Lucas Stach [mailto:l.stach at pengutronix.de]
> Sent: Tuesday, July 24, 2018 12:57 AM
> To: Oleksij Rempel <o.rempel@pengutronix.de>; Shawn Guo
> <shawnguo@kernel.org>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; A.s.
> Dong <aisheng.dong@nxp.com>; Vladimir Zapolskiy
> <vladimir_zapolskiy@mentor.com>
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel at lists.infradead.org;
> kernel at pengutronix.de; devicetree at vger.kernel.org
> Subject: Re: [PATCH v6 4/5] ARM: dts: imx7s: add i.MX7 messaging unit
> support
> 
> Am Sonntag, den 22.07.2018, 08:39 +0200 schrieb Oleksij Rempel:
> > Define the Messaging Unit (MU) for i.MX7 in the processor's dtsi.
> > The respective driver is added in the next commit.
> >
> > > Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> > ?arch/arm/boot/dts/imx7s.dtsi | 19 +++++++++++++++++++
> > ?1 file changed, 19 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx7s.dtsi
> > b/arch/arm/boot/dts/imx7s.dtsi index ce85b3ca1a55..191a0286fa3b 100644
> > --- a/arch/arm/boot/dts/imx7s.dtsi
> > +++ b/arch/arm/boot/dts/imx7s.dtsi
> > @@ -1001,6 +1001,25 @@
> > > ?				status = "disabled";
> > > ?			};
> >
> > > > +			mu0a: mailbox at 30aa0000 {
> > +				compatible = "fsl,imx7s-mu", "fsl,imx6sx-mu";
> 
> Those compatibles are missing documentation in the binding.
> 

Sorry for the overlooking.
They seem to be got missed during a updated binding doc review.

Oleksij,
Would you add them back and resend the patch series?

Regards
Dong Aisheng

> > +				reg = <0x30aa0000 0x10000>;
> > > +				interrupts = <GIC_SPI 88
> IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX7D_MU_ROOT_CLK>;
> > > +				#mbox-cells = <1>;
> > > +				status = "disabled";
> > > +			};
> > +
> > > > +			mu0b: mailbox at 30ab0000 {
> > > +				compatible = "fsl,imx7s-mu", "fsl,imx6sx-mu";
> > > +				reg = <0x30ab0000 0x10000>;
> > > +				interrupts = <GIC_SPI 97
> IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&clks IMX7D_MU_ROOT_CLK>;
> > > +				#mbox-cells = <1>;
> > > +				fsl,mu-side-b;
> > > +				status = "disabled";
> > > +			};
> > +
> > > > ?			usbotg1: usb at 30b10000 {
> > > ?				compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
> > > ?				reg = <0x30b10000 0x200>;
