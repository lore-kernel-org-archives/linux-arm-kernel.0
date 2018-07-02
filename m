From: anson.huang@nxp.com (Anson Huang)
Date: Mon, 2 Jul 2018 01:09:02 +0000
Subject: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
In-Reply-To: <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon>
 <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
 <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
 <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com>
Message-ID: <AM3PR04MB13155B8D567ABEF7EF03249AF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Monday, July 2, 2018 9:05 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Robin Gong <yibin.gong@nxp.com>;
> Mark Rutland <mark.rutland@arm.com>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>;
> linux-kernel <linux-kernel@vger.kernel.org>; Rob Herring
> <robh+dt@kernel.org>; dl-linux-imx <linux-imx@nxp.com>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>;
> moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
> 
> On Sun, Jul 1, 2018 at 10:03 PM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> > So that mean such kind of kernel patch will never be into kernel? Even
> > if it is a necessary patch for fixing some other issues? I just wonder
> > how this case being handled.
> 
> What is the issue that 5fe156f1cab4f fixes? It is not clear by looking at the
> commit log.

On some new i.MX platforms, PFuze switches are used for supplying GPU/VPU
or other non-critical modules only, these switches need to be turned off by
runtime PM to avoid very high power leakage, like on mScale850D.

Anson
