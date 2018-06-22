From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 22 Jun 2018 06:04:33 +0000
Subject: [PATCH V2 2/4] dt-bindings: arm: fsl: add mu binding doc
In-Reply-To: <20180622054932.ysqve7o7pvdnlp5k@pengutronix.de>
References: <1529239789-26849-1-git-send-email-aisheng.dong@nxp.com>
 <1529239789-26849-3-git-send-email-aisheng.dong@nxp.com>
 <20180620194310.GA28983@rob-hp-laptop>
 <20180621074641.sqqvudxebt3hd43m@pengutronix.de>
 <AM0PR04MB4211B39D5AFAB95FC2A91F9980760@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180622054932.ysqve7o7pvdnlp5k@pengutronix.de>
Message-ID: <AM0PR04MB42118587B7A0E0518EFE21F080750@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Friday, June 22, 2018 1:50 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: Rob Herring <robh@kernel.org>; linux-arm-kernel at lists.infradead.org;
> dongas86 at gmail.com; kernel at pengutronix.de; shawnguo at kernel.org;
> Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx <linux-
> imx at nxp.com>; Mark Rutland <mark.rutland@arm.com>;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH V2 2/4] dt-bindings: arm: fsl: add mu binding doc
> 
> On Thu, Jun 21, 2018 at 05:11:33PM +0000, A.s. Dong wrote:
> > Hi Sascha,
> >
> > > -----Original Message-----
> > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > Sent: Thursday, June 21, 2018 3:47 PM
> > > To: Rob Herring <robh@kernel.org>
> > > Cc: A.s. Dong <aisheng.dong@nxp.com>; linux-arm-
> > > kernel at lists.infradead.org; dongas86 at gmail.com;
> > > kernel at pengutronix.de; shawnguo at kernel.org; Fabio Estevam
> > > <fabio.estevam@nxp.com>; dl-linux- imx <linux-imx@nxp.com>; Mark
> > > Rutland <mark.rutland@arm.com>; devicetree at vger.kernel.org
> > > Subject: Re: [PATCH V2 2/4] dt-bindings: arm: fsl: add mu binding
> > > doc
> > >
> > > On Wed, Jun 20, 2018 at 01:43:10PM -0600, Rob Herring wrote:
> > > > On Sun, Jun 17, 2018 at 08:49:47PM +0800, Dong Aisheng wrote:
> > > > > The Messaging Unit module enables two processors within the SoC
> > > > > to communicate and coordinate by passing messages (e.g. data,
> > > > > status and control) through the MU interface.
> > > > >
> > > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > Cc: devicetree at vger.kernel.org
> > > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > > > ---
> > > > > v1->v2:
> > > > >  * typo fixes
> > > > >  * remove status property
> > > > >  * remove imx6&7 compatible string which may be added later for
> > > > >    the generic mailbox binding
> > > > >
> > > > > Note: Because MU used by SCU is not implemented as a mailbox
> > > > > driver, Instead, they're provided in library calls to gain higher
> performance.
> > > >
> > > > Using a binding doesn't mean you have to use an OS's subsystem.
> > > >
> > > > What needs higher performance? What's the performance difference?
> > > Why
> > > > can't the mailbox framework be improved?
> > >
> > > From what I see the performance is improved by polling the interrupt
> > > registers rather than using interrupts.
> > > I see no reason though why this can't be implemented with the
> > > mailbox framework as is.
> > >
> >
> > I thought you've agreed to not write generic MU(mailbox) driver for SCU.
> >
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fw
> ww
> > .spinics.net%2Flists%2Farm-
> kernel%2Fmsg650217.html&data=02%7C01%7Caish
> >
> eng.dong%40nxp.com%7Cfb1c9e5d6eff453207a908d5d803f139%7C686ea1d3
> bc2b4c
> >
> 6fa92cd99c5c301635%7C0%7C0%7C636652433808619368&sdata=vOFbr%2BSJ
> 1tkY5F
> > 8ha1wrxk3RMVxI4lzKkidD9cK%2Bl9A%3D&reserved=0
> > But seems it's still not quite certain...
> 
> My suggestion was that we change the compatible of the MU unit to
> something that the SCU driver matches. But since we do not do that and
> instead use a fsl,imx8qxp-mu compatible for the MU we have to come up
> with a MU driver that handles both the SCU case and the regular usecase.
> Otherwise we'll end up with a generic driver attaching to the device you are
> using under the hoods.
> 

Do you think checking mbox-cells can work?
E.g. SCU MU mbox-cells should be 0 while general purpose MU are 1.

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fww
> w.pengutronix.de%2F&data=02%7C01%7Caisheng.dong%40nxp.com%7Cfb1
> c9e5d6eff453207a908d5d803f139%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C636652433808619368&sdata=AYkDI3ubpKuxfKvmsvM8d65suEAkf
> 3h9Tq5KZdJxoNY%3D&reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
