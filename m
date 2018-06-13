From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 13 Jun 2018 09:36:39 +0000
Subject: [PATCH v1 0/4] add mailbox support for i.MX7D
In-Reply-To: <20180601083411.s35c2floqdas6qni@pengutronix.de>
References: <20180601065821.28234-1-o.rempel@pengutronix.de>
 <20180601083411.s35c2floqdas6qni@pengutronix.de>
Message-ID: <AM0PR04MB4211ABBDBEE2982312E15F6F807E0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

Thanks for the forwarding.

> -----Original Message-----
> From: Robert Schwebel [mailto:r.schwebel at pengutronix.de]
> Sent: Friday, June 1, 2018 4:34 PM
> To: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; linux-clk at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; kernel at pengutronix.de;
> devicetree at vger.kernel.org; A.s. Dong <aisheng.dong@nxp.com>; dl-linux-
> imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v1 0/4] add mailbox support for i.MX7D
> 
> On Fri, Jun 01, 2018 at 08:58:17AM +0200, Oleksij Rempel wrote:
> > This patches are providing support for mailbox (Messaging Unit) for
> > i.MX7D. Functionality was tested on PHYTEC phyBOARD-Zeta i.MX7D with
> > Linux running on all cores: ARM Cortex-A7 and ARM Cortex-M4.
> >

Thanks for the patch.

> > Both parts of i.MX messaging Unit are visible for all CPUs available
> > on i.MX7D. Communication worked independent of MU side in
> combination
> > with CPU. For example MU-A used on ARM Cortex-A7 and MU-B used on
> ARM
> > Cortex-M4 or other ways around.
> >
> > The question to NXP developers: are there are limitations or
> > recommendations about MU vs CPU combination? The i.MX7D
> documentation
> > talks about "Processor A" and "Processor B". It is not quite clear
> > what processor it actually is (A7 or M4).

The MU vs CPU combination usually are defined by HW design.
It, MU Side A/B,  can either be used by both CPU (A core and M core)
or fixed to one side.
For MX7D case, both side memory map can be accessed by both CPU
Including Interrupt signals. But the recommendation is A core using
MU side A and M core using MU side B.

Regards
Dong Aisheng

> 
> Adding Dong Aisheng and NXP linux team to Cc:.
> 
> rsc
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fww
> w.pengutronix.de%2F&data=02%7C01%7Caisheng.dong%40nxp.com%7Cf53
> d9c9cdd744878740f08d5c79a7a1e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C636634388645464924&sdata=2ehh92tNbfwf3fJTp%2Fx7IUOgGSU
> h6pyrc2XsdRJkTw4%3D&reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
