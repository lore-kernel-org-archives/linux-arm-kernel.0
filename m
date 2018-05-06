From: anson.huang@nxp.com (Anson Huang)
Date: Sun, 6 May 2018 06:04:11 +0000
Subject: [PATCH V6 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch
 screen support
In-Reply-To: <CAOMZO5D1H4+w=FGh+8icBziunDzM4jN7peA=mirGb9RBHHqMsg@mail.gmail.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
 <1525508963-7986-7-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5D1H4+w=FGh+8icBziunDzM4jN7peA=mirGb9RBHHqMsg@mail.gmail.com>
Message-ID: <AM3PR04MB1315A1673823C8B2BAA3169AF5840@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Saturday, May 5, 2018 7:56 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Haibo Chen <haibo.chen@freescale.com>; Andy Duan
> <fugang.duan@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>; Robin Gong
> <yibin.gong@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH V6 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch
> screen support
> 
> Hi Anson,
> 
> On Sat, May 5, 2018 at 5:29 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > Add egalax touch screen support on i2c2 bus.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> 
> Is Haibo the author of this patch? If so, his name should appear in the From field.

I made this patch based on NXP kernel tree, Haibo is the original author of this
feature, but the original patch can NOT be applied directly, I have to refine the patch
to meet the upstream requirement, so I added him as another signed-off tag,
to avoid confuse, I can remove this sign-off in next patch version. Same story
for other patches in this series.

> 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > changes since V5:
> >         improve pinctrl node name and touchscreen node name.
> >  arch/arm/boot/dts/imx6sx-sabreauto.dts | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > index 1dc5b58..3fe41d3 100644
> > --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > @@ -122,6 +122,12 @@
> >  };
> >
> >  &iomuxc {
> > +       pinctrl_egalax_int: egalax-intgrp {
> > +               fsl,pins = <
> > +                       MX6SX_PAD_SD4_RESET_B__GPIO6_IO_22
> 0x80000000
> > +               >;
> > +       };
> > +
> >         pinctrl_enet1: enet1grp {
> >                 fsl,pins = <
> >                         MX6SX_PAD_ENET1_MDIO__ENET1_MDIO
> 0xa0b1
> > @@ -264,6 +270,16 @@
> >         pinctrl-0 = <&pinctrl_i2c2>;
> >         status = "okay";
> >
> > +       egalax_touchscreen at 4 {
> 
> Should be touchscreen at 4.
 
Will improve it in next patch version.

Anson.
