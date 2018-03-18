From: anson.huang@nxp.com (Anson Huang)
Date: Sun, 18 Mar 2018 02:23:18 +0000
Subject: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
In-Reply-To: <CAOMZO5BzE46Dm24++j+xVA4KGFnpsopGfJ97h7sFGOAxVa19=g@mail.gmail.com>
References: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BzE46Dm24++j+xVA4KGFnpsopGfJ97h7sFGOAxVa19=g@mail.gmail.com>
Message-ID: <AM3PR04MB1315E1C3071C0BD2E7169968F5D50@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Saturday, March 17, 2018 10:53 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Robin Gong <yibin.gong@nxp.com>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <kernel@pengutronix.de>; Fabio Estevam
> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Russell King - ARM Linux <linux@armlinux.org.uk>;
> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
> 
> Hi Anson,
> 
> On Sat, Mar 17, 2018 at 3:57 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > Update sw1a/vldo4's voltage range according to latest pfuze3000
> > datasheet from:
> >
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fcach
> >
> e.freescale.com%2Ffiles%2Fanalog%2Fdoc%2Fdata_sheet%2FPF3000.pdf%3Ffsr
> >
> ch%3D1%26sr%3D1%26pageNum%3D1&data=02%7C01%7CAnson.Huang%40n
> xp.com%7Cc
> >
> 9614ae26f9443c2d0ae08d58c16cd8a%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0
> > %7C1%7C636568951923456037&sdata=OeM%2B3xPNlm9OETpZcrvG65LjH%
> 2Fp4CRZvyD
> > HT819kuPk%3D&reserved=0
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx6sx-udoo-neo.dtsi  | 2 +-
> > arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 4 ++--
> >  arch/arm/boot/dts/imx7d-nitrogen7.dts   | 2 +-
> >  arch/arm/boot/dts/imx7d-sdb.dts         | 6 +++---
> >  arch/arm/boot/dts/imx7s-warp.dts        | 2 +-
> >  5 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> > b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> > index 53b3eac..1de0a0f 100644
> > --- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> > +++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> > @@ -142,7 +142,7 @@
> >                 regulators {
> >                         sw1a_reg: sw1a {
> >                                 regulator-min-microvolt = <700000>;
> > -                               regulator-max-microvolt = <1475000>;
> > +                               regulator-max-microvolt =
> <3300000>;
> 
> This change does not look like a safe thing to do without carefully checking each
> one of the board schematics.
> 
> Even if the regulator itself is capable of driving a higher voltage, it does not
> mean that the circuitry that consumes such regulator is allowed to receive the
> higher voltages.
 
I thought the max value here means the capability of regulator itself, like the internal
anatop LDO regulator VDD_CORE, the max value defined in dtsi is 1.45V, but out i.MX6
SoCs can NOT receive to voltage higher than 1.3V.

The default setting of PMIC output is controlled by its OTP and the OTP value should
consider the board design, the rest of voltage setting should be taken care by device driver.
Here I think the max means PMIC's capability.

Anson.
