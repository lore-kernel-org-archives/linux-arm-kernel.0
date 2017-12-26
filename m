From: peng.fan@nxp.com (Peng Fan)
Date: Tue, 26 Dec 2017 09:18:12 +0000
Subject: [PATCH] arm: imx: suspend/resume: use outer_disable/resume
In-Reply-To: <20171226090902.GO23070@X250>
References: <20171210120718.15197-1-peng.fan@nxp.com>
 <20171226033125.GA4210@X250>
 <DB6PR04MB32218D8A75D4D9F6CB2D2F3C88060@DB6PR04MB3221.eurprd04.prod.outlook.com>
 <20171226090902.GO23070@X250>
Message-ID: <DB6PR04MB3221E320A214A3441C96739E88060@DB6PR04MB3221.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Shawn,

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Tuesday, December 26, 2017 5:09 PM
> To: Peng Fan <peng.fan@nxp.com>
> Cc: A.s. Dong <aisheng.dong@nxp.com>; linux-kernel at vger.kernel.org; Russell
> King <linux@armlinux.org.uk>; van.freenix at gmail.com; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] arm: imx: suspend/resume: use outer_disable/resume
> 
> On Tue, Dec 26, 2017 at 06:52:45AM +0000, Peng Fan wrote:
> > Hi Shawn,
> >
> > > -----Original Message-----
> > > From: Shawn Guo [mailto:shawnguo at kernel.org]
> > > Sent: Tuesday, December 26, 2017 11:31 AM
> > > To: Peng Fan <peng.fan@nxp.com>
> > > Cc: A.s. Dong <aisheng.dong@nxp.com>; linux-kernel at vger.kernel.org;
> > > Russell King <linux@armlinux.org.uk>; Fabio Estevam
> > > <fabio.estevam@nxp.com>; Sascha Hauer <kernel@pengutronix.de>;
> > > van.freenix at gmail.com; linux-arm- kernel at lists.infradead.org
> > > Subject: Re: [PATCH] arm: imx: suspend/resume: use
> > > outer_disable/resume
> > >
> > > On Sun, Dec 10, 2017 at 08:07:18PM +0800, Peng Fan wrote:
> > > > Use outer_disable/resume for suspend/resume.
> > > > With the two APIs used, code could be simplified and easy to
> > > > extend to introduce l2c_write_sec for i.MX platforms when moving
> > > > Linux Kernel runs in non-secure world.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > Cc: Russell King <linux@armlinux.org.uk>
> > > > Cc: Dong Aisheng <aisheng.dong@nxp.com>
> > > > ---
> > > >  arch/arm/mach-imx/pm-imx6.c      |  2 ++
> > > >  arch/arm/mach-imx/suspend-imx6.S | 24 ------------------------
> > >
> > > I'm fine with the patch in general.  But this piece of code is
> > > running on a few
> > > i.MX6 platforms, and I'm wondering on which SoCs you have verified
> > > the change work fine.
> >
> > I tested it on 6Q-SDB board. Is it ok?
> 
> Okay, I will get it into linux-next for a bit wider testing.

Thanks. I missed to note that, I applied this patch in my testing
https://www.spinics.net/lists/arm-kernel/msg623610.html
to avoid suspicious RCU usage.

Thanks,
Peng.

> 
> Shawn
