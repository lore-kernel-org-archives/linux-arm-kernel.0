From: anson.huang@nxp.com (Anson Huang)
Date: Fri, 29 Jun 2018 08:27:41 +0000
Subject: [PATCH] ARM: dts: imx6: correct anatop regulators range
In-Reply-To: <1530260109.22468.60.camel@pengutronix.de>
References: <1530258861-11666-1-git-send-email-Anson.Huang@nxp.com>
 <1530260109.22468.60.camel@pengutronix.de>
Message-ID: <AM3PR04MB13157A4948E36BAE60A8DC49F54E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Lucas

Anson Huang
Best Regards!


> -----Original Message-----
> From: Lucas Stach [mailto:l.stach at pengutronix.de]
> Sent: Friday, June 29, 2018 4:15 PM
> To: Anson Huang <anson.huang@nxp.com>; shawnguo at kernel.org;
> s.hauer at pengutronix.de; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt at kernel.org; mark.rutland at arm.com;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> linux-kernel at vger.kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH] ARM: dts: imx6: correct anatop regulators range
> 
> Am Freitag, den 29.06.2018, 15:54 +0800 schrieb Anson Huang:
> > Correct some i.MX6 SoCs anatop regulators range according to reference
> > manual.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> NACK.
> 
> This is wrong. While the regulator supports this range, the SoC doesn't.?The
> current settings are derived from the allowed operating ranges of the SoC (at
> least for the MX6QDL), which is in accordance with how regulator constraints
> in DT are meant to be used.
 
Understand that normally these regulators' voltage are NOT adjusted, we just use
the default value, let's just call the operating range of the SoC "SoC range",
my intention is to make all i.MX6's anatop regulator settings aligned since they are in same series, 
I saw some i.MX6 SoCs use same SoC range as anatop ldo range, but some are
NOT, like imx6qdl/imx6sx/imx6sl use different SoC range than anatop ldo range,
but imx6ul/ull/sll use same regulator range as anatop ldo, and regulator 1p1/2p5/3p0
also have different settings, some are use SoC range and some are just same as anatop
ldo range....this looks really confused.

So, do you think we can adjust the imx6ul/ull/sll's regulator range to be SoC range rather than
anatop ldo range? And how to define the SoC range? Like the 1p1 ldo range, how do
we know which range is fine? As I saw it is 1v ~ 1.2v on imx6qdl, but 0.8v ~ 1.375v on imx6sl?

Thanks.

Anson.

> 
> Regards,
> Lucas
> 
> > ---
> > ?arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++++------
> > ?arch/arm/boot/dts/imx6sl.dtsi??|??4 ++--
> > ?arch/arm/boot/dts/imx6sx.dtsi??|??4 ++--
> > ?3 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi
> > b/arch/arm/boot/dts/imx6qdl.dtsi index 911141e..d9f98dd 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -689,8 +689,8 @@
> > > ?				regulator-1p1 {
> > > ?					compatible = "fsl,anatop-regulator";
> > > ?					regulator-name = "vdd1p1";
> > > -					regulator-min-microvolt = <1000000>;
> > > -					regulator-max-microvolt = <1200000>;
> > > +					regulator-min-microvolt = <800000>;
> > > +					regulator-max-microvolt = <1375000>;
> > > ?					regulator-always-on;
> > > ?					anatop-reg-offset = <0x110>;
> > > ?					anatop-vol-bit-shift = <8>;
> > @@ -704,8 +704,8 @@
> > > ?				regulator-3p0 {
> > > ?					compatible = "fsl,anatop-regulator";
> > > ?					regulator-name = "vdd3p0";
> > > -					regulator-min-microvolt = <2800000>;
> > > -					regulator-max-microvolt = <3150000>;
> > > +					regulator-min-microvolt = <2625000>;
> > > +					regulator-max-microvolt = <3400000>;
> > > ?					regulator-always-on;
> > > ?					anatop-reg-offset = <0x120>;
> > > ?					anatop-vol-bit-shift = <8>;
> > @@ -719,8 +719,8 @@
> > > ?				regulator-2p5 {
> > > ?					compatible = "fsl,anatop-regulator";
> > > ?					regulator-name = "vdd2p5";
> > > -					regulator-min-microvolt = <2250000>;
> > > -					regulator-max-microvolt = <2750000>;
> > > +					regulator-min-microvolt = <2100000>;
> > > +					regulator-max-microvolt = <2875000>;
> > > ?					regulator-always-on;
> > > ?					anatop-reg-offset = <0x130>;
> > > ?					anatop-vol-bit-shift = <8>;
> > diff --git a/arch/arm/boot/dts/imx6sl.dtsi
> > b/arch/arm/boot/dts/imx6sl.dtsi index 81f48116..3d7931b 100644
> > --- a/arch/arm/boot/dts/imx6sl.dtsi
> > +++ b/arch/arm/boot/dts/imx6sl.dtsi
> > @@ -539,8 +539,8 @@
> > > ?				regulator-3p0 {
> > > ?					compatible = "fsl,anatop-regulator";
> > > ?					regulator-name = "vdd3p0";
> > > -					regulator-min-microvolt = <2800000>;
> > > -					regulator-max-microvolt = <3150000>;
> > > +					regulator-min-microvolt = <2625000>;
> > > +					regulator-max-microvolt = <3400000>;
> > > ?					regulator-always-on;
> > > ?					anatop-reg-offset = <0x120>;
> > > ?					anatop-vol-bit-shift = <8>;
> > diff --git a/arch/arm/boot/dts/imx6sx.dtsi
> > b/arch/arm/boot/dts/imx6sx.dtsi index 7130ab8..f26f611 100644
> > --- a/arch/arm/boot/dts/imx6sx.dtsi
> > +++ b/arch/arm/boot/dts/imx6sx.dtsi
> > @@ -607,8 +607,8 @@
> > > ?				regulator-3p0 {
> > > ?					compatible = "fsl,anatop-regulator";
> > > ?					regulator-name = "vdd3p0";
> > > -					regulator-min-microvolt = <2800000>;
> > > -					regulator-max-microvolt = <3150000>;
> > > +					regulator-min-microvolt = <2625000>;
> > > +					regulator-max-microvolt = <3400000>;
> > > ?					regulator-always-on;
> > > ?					anatop-reg-offset = <0x120>;
> > > ?					anatop-vol-bit-shift = <8>;
