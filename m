From: anson.huang@nxp.com (Anson Huang)
Date: Mon, 19 Mar 2018 02:09:39 +0000
Subject: [PATCH 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz clock
 source
In-Reply-To: <CAOMZO5CG6XuJ7N8W--zEwEVd9JHj887_7aNp+K8D-Xt1OnKh7A@mail.gmail.com>
References: <1521342853-2941-1-git-send-email-Anson.Huang@nxp.com>
 <1521342853-2941-2-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CG6XuJ7N8W--zEwEVd9JHj887_7aNp+K8D-Xt1OnKh7A@mail.gmail.com>
Message-ID: <AM3PR04MB1315E9D8E8C4492876E6CFF3F5D40@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Sunday, March 18, 2018 9:04 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Russell King - ARM Linux <linux@armlinux.org.uk>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; S.j. Wang
> <shengjiu.wang@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-kernel
> <linux-kernel@vger.kernel.org>; linux-clk <linux-clk@vger.kernel.org>
> Subject: Re: [PATCH 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz clock
> source
> 
> On Sun, Mar 18, 2018 at 12:14 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> 
> > diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > index 72da5ac..83f7cac 100644
> > --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > @@ -18,6 +18,14 @@
> >                 reg = <0x80000000 0x80000000>;
> >         };
> >
> > +       clocks {
> > +               codec_osc: anaclk2 {
> > +                       #clock-cells = <0>;
> > +                       compatible = "fixed-clock";
> > +                       clock-frequency = <24576000>;
> > +               };
> > +       };
> 
> The clocks container should be removed and the clock node could be put directly
> into the root node.
> 
> Also, I do not see 'codec_osc' being used in this dts.
 
This clock will be used by cs42888 codec, this patch is only to add basic clock source
to complete the clock tree. Thanks.

Anson.
