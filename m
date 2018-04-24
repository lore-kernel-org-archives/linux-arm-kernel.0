From: anson.huang@nxp.com (Anson Huang)
Date: Tue, 24 Apr 2018 02:09:58 +0000
Subject: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
In-Reply-To: <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
 <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
Message-ID: <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Monday, April 23, 2018 7:09 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
> 
> Hi Anson,
> 
> On Mon, Apr 23, 2018 at 12:46 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > Add FEC support on i.MX6SX Sabre Auto board.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx6sx-sabreauto.dts | 70
> ++++++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > index 812f40b..eadd483 100644
> > --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > @@ -41,6 +41,40 @@
> >         clock-frequency = <24576000>;
> >  };
> >
> > +&fec1 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_enet1_1>;
> > +       phy-mode = "rgmii";
> > +       phy-handle = <&ethphy1>;
> > +       pinctrl-assert-gpios = <&max7322 0 GPIO_ACTIVE_HIGH>;
> 
> This property does not exist in mainline, only in the NXP vendor kernel.

Ah, yes, thanks for pointing out this issue, I just removed it and the function is still working,
already sent out V2 patch set, thanks.

Anson.
 
