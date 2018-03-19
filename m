From: anson.huang@nxp.com (Anson Huang)
Date: Mon, 19 Mar 2018 02:06:16 +0000
Subject: [PATCH] ARM: dts: imx7s: add anatop vdd1p2 regulator
In-Reply-To: <CAOMZO5DJ5-AdudGhk6VfTazJXBpReGHW-bxKM1=bLZO90PnXsg@mail.gmail.com>
References: <1521272215-22514-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5DJ5-AdudGhk6VfTazJXBpReGHW-bxKM1=bLZO90PnXsg@mail.gmail.com>
Message-ID: <AM3PR04MB1315193720D4160F00FF0590F5D40@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Monday, March 19, 2018 3:54 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Russell King - ARM Linux <linux@armlinux.org.uk>; dl-linux-imx
> <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC ARM
> ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] ARM: dts: imx7s: add anatop vdd1p2 regulator
> 
> Hi Anson,
> 
> On Sat, Mar 17, 2018 at 4:36 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > Add i.MX7S/D anatop vdd1p2 regulator.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx7s.dtsi | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx7s.dtsi
> > b/arch/arm/boot/dts/imx7s.dtsi index cd6964f..1210028 100644
> > --- a/arch/arm/boot/dts/imx7s.dtsi
> > +++ b/arch/arm/boot/dts/imx7s.dtsi
> > @@ -565,6 +565,21 @@
> >                                         anatop-max-voltage =
> <1200000>;
> >                                         anatop-enable-bit = <0>;
> >                                 };
> > +
> > +                               reg_1p2:
> regulator-vdd1p2 at 30360220 {
> > +                                       reg = <0x30360220>;
> > +                                       compatible =
> "fsl,anatop-regulator";
> > +                                       regulator-name = "vdd1p2";
> > +                                       regulator-min-microvolt =
> <1100000>;
> > +                                       regulator-max-microvolt =
> <1300000>;
> > +                                       anatop-reg-offset =
> <0x220>;
> > +                                       anatop-vol-bit-shift = <8>;
> > +                                       anatop-vol-bit-width = <5>;
> > +                                       anatop-min-bit-val =
> <0x14>;
> > +                                       anatop-min-voltage =
> <1100000>;
> > +                                       anatop-max-voltage =
> <1300000>;
> > +                                       anatop-enable-bit = <0>;
> > +                               };
> 
> Do you also plan to add a consumer for it?
 
This regulator is mainly for USB HSIC, the consumer will be added when HSIC
do upstream.

Anson.
