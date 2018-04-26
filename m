From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 26 Apr 2018 03:06:15 +0000
Subject: [PATCH V4 3/6] ARM: dts: imx6sx-sabreauto: add IO expander
 max7310 support
In-Reply-To: <CAOMZO5Dm6rcEe=zAJ9_nqKce3g2tdyWPqb=Uv-N5nfc_96jc-g@mail.gmail.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
 <1524634571-5914-3-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Dm6rcEe=zAJ9_nqKce3g2tdyWPqb=Uv-N5nfc_96jc-g@mail.gmail.com>
Message-ID: <AM3PR04MB13150654494B8D251988F76CF58E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Thursday, April 26, 2018 5:46 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Russell King - ARM Linux <linux@armlinux.org.uk>; dl-linux-imx
> <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC ARM
> ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH V4 3/6] ARM: dts: imx6sx-sabreauto: add IO expander
> max7310 support
> 
> On Wed, Apr 25, 2018 at 2:36 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> 
> > +&i2c3 {
> > +       clock-frequency = <100000>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_i2c3_2>;
> > +       status = "okay";
> > +
> > +       max7310_a: gpio at 30 {
> > +               compatible = "maxim,max7310";
> > +               reg = <0x30>;
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +       };
> > +
> > +       max7310_b: gpio at 32 {
> > +               compatible = "maxim,max7310";
> > +               reg = <0x32>;
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +       };
> 
> Please also add the users for the MAX7310 pins, such as Ethernet PHY.
 
MAX7310 pins are for PCIe, CAN, MLB. GPS etc., these modules are NOT enabled yet, so
I can NOT test it, I think we should add MAX7310 users when these modules are enabled,
ethernet PHY is NOT controlled by it.

Anson.
