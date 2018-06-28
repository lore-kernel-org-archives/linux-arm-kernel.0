From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 28 Jun 2018 01:14:44 +0000
Subject: [PATCH] ARM: dts: imx6sll-evk: enable usdhc3 slot
In-Reply-To: <CAOMZO5DoRUSOfV_oh242w6s_1Zs8yAy9Kf4D+WdYym5c+6nucg@mail.gmail.com>
References: <1530088605-9264-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5DoRUSOfV_oh242w6s_1Zs8yAy9Kf4D+WdYym5c+6nucg@mail.gmail.com>
Message-ID: <AM3PR04MB1315128EA1000FD6D0903CEAF54F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Wednesday, June 27, 2018 10:31 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> Estevam <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] ARM: dts: imx6sll-evk: enable usdhc3 slot
> 
> Hi Anson,
> 
> On Wed, Jun 27, 2018 at 5:36 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> 
> > +&usdhc3 {
> > +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +       pinctrl-0 = <&pinctrl_usdhc3>;
> > +       pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> > +       pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> > +       cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
> > +       keep-power-in-suspend;
> > +       enable-sdio-wakeup;
> > +       vmmc-supply = <&reg_sd3_vmmc>;
> > +       status = "okay";
> > +};
> > +
> >  &usbotg1 {
> 
> Please keep the nodes sorted in alphabetical order.

Thanks, it is because original code does NOT do it in alphabetical order, so I just added
usdhc3 at the end of usdhc1, but I sent V2 patch to re-sort it anyway, please review it.  

Anson.
