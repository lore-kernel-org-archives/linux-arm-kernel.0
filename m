From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 10 Feb 2017 07:49:44 +0100
Subject: i.MX7 clock support broken
In-Reply-To: <AM4PR0401MB22602ECF28CCB7172B917EC2FF440@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <20170207142225.zitac2r7g3kvowjw@pengutronix.de>
 <DB5PR04MB1431EB280E8B9BA929FF006D80420@DB5PR04MB1431.eurprd04.prod.outlook.com>
 <AM4PR0401MB22602ECF28CCB7172B917EC2FF440@AM4PR0401MB2260.eurprd04.prod.outlook.com>
Message-ID: <20170210064944.vshtcr62xqcvjsmh@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 03:37:38AM +0000, Andy Duan wrote:
> From: A.S. Dong Sent: Thursday, February 09, 2017 12:47 AM
> >To: Sascha Hauer <s.hauer@pengutronix.de>; linux-arm-
> >kernel at lists.infradead.org
> >Cc: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
> ><fabio.estevam@nxp.com>; kernel at pengutronix.de; Andy Duan
> ><fugang.duan@nxp.com>; Frank Li <frank.li@nxp.com>
> >Subject: RE: i.MX7 clock support broken
> >
> >Hi Sascha,
> >
> >> -----Original Message-----
> >> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> >> Sent: Tuesday, February 07, 2017 10:22 PM
> >> To: linux-arm-kernel at lists.infradead.org
> >> Cc: Shawn Guo; A.S. Dong; Fabio Estevam; kernel at pengutronix.de
> >> Subject: i.MX7 clock support broken
> >>
> >> Hi All,
> >>
> >> I recently adopted the i.MX7 clock tree from Linux to barebox and
> >> wondered why ethernet doesn't work.
> >
> >I just reproduced the issue on MX7D SDB board with latest upstream kernel
> >That kernel NULL point crash during boot on fec_enet_open->..-
> >>phy_attach_direct.
> >
> 
> The issue was caused by one patch submitted at 2017 Jan.31

The issue I was talking about is that the clock driver does not control
the real ethernet clocks, but instead some non existing clocks. This
issue does not cause any problems in the kernel at all, because when
the ethernet clocks have been enabled in the bootloader then everything
runs smoothly in the kernel. Nevertheless the kernel driver is buggy of
course, the actual clocks are never turned off when not needed.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
