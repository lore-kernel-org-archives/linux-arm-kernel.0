From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 23 Oct 2018 14:42:09 +0000
Subject: [PATCH V2 7/8] dts: fsl: add imx7ulp evk support
In-Reply-To: <CAOMZO5C3Fv+s-bLeHGZ6LEB=ZqRxf=gXuzbtwfNS=PvQeVJ1Ag@mail.gmail.com>
References: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
 <1540295058-26090-8-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5C3Fv+s-bLeHGZ6LEB=ZqRxf=gXuzbtwfNS=PvQeVJ1Ag@mail.gmail.com>
Message-ID: <AM0PR04MB42110E5309341D1626EB6EF980F50@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Tuesday, October 23, 2018 8:29 PM
[...] 
> On Tue, Oct 23, 2018 at 8:56 AM A.s. Dong <aisheng.dong@nxp.com> wrote:
> 
> > +/ {
> > +       model = "NXP i.MX7ULP EVK";
> > +       compatible = "fsl,imx7ulp-evk", "fsl,imx7ulp", "Generic DT
> > +based system";
> 
> This "Generic DT based system" should be removed.
> 

Got it

> > +       chosen {
> > +               stdout-path = &lpuart4;
> > +       };
> > +
> > +       memory at 60000000 {
> 
>        device_type = "memory";

Got it

> > +               reg = <0x60000000 0x40000000>;
> > +       };
> 
> > +&iomuxc1 {
> > +       pinctrl_lpuart4: lpuart4grp {
> > +               pinmux = <
> > +                       IMX7ULP_PAD_PTC3__LPUART4_RX
> > +                       IMX7ULP_PAD_PTC2__LPUART4_TX
> > +               >;
> > +               bias-pull-up;
> 
> Please change the mx7ulp pinctrl driver to accept the "old" notation and
> change the dts to use:
> 
> IMX7ULP_PAD_PTC3__LPUART4_RX 0x3
> 
> This way we use the same method for all i.MX devices.

I'm a bit hesitate to do that as the driver already supports it. There's no extra effort
to use it. And we probably could take ULP as a special case to test generic binding
rather then simply drop it and drop driver features. Once we get objection from users
later, we still can simply fallback as there's still only official boards using it.

Last, it's not correct that there's not only one method for all i.MX devices.
MX23/28 are different ones and ULP is more like MX23/28.
And I saw no objections from users for MX23/28.

Regards
Dong Aisheng
