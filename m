From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 22 Jun 2018 07:49:32 +0200
Subject: [PATCH V2 2/4] dt-bindings: arm: fsl: add mu binding doc
In-Reply-To: <AM0PR04MB4211B39D5AFAB95FC2A91F9980760@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1529239789-26849-1-git-send-email-aisheng.dong@nxp.com>
 <1529239789-26849-3-git-send-email-aisheng.dong@nxp.com>
 <20180620194310.GA28983@rob-hp-laptop>
 <20180621074641.sqqvudxebt3hd43m@pengutronix.de>
 <AM0PR04MB4211B39D5AFAB95FC2A91F9980760@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20180622054932.ysqve7o7pvdnlp5k@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 05:11:33PM +0000, A.s. Dong wrote:
> Hi Sascha,
> 
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > Sent: Thursday, June 21, 2018 3:47 PM
> > To: Rob Herring <robh@kernel.org>
> > Cc: A.s. Dong <aisheng.dong@nxp.com>; linux-arm-
> > kernel at lists.infradead.org; dongas86 at gmail.com; kernel at pengutronix.de;
> > shawnguo at kernel.org; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-
> > imx <linux-imx@nxp.com>; Mark Rutland <mark.rutland@arm.com>;
> > devicetree at vger.kernel.org
> > Subject: Re: [PATCH V2 2/4] dt-bindings: arm: fsl: add mu binding doc
> > 
> > On Wed, Jun 20, 2018 at 01:43:10PM -0600, Rob Herring wrote:
> > > On Sun, Jun 17, 2018 at 08:49:47PM +0800, Dong Aisheng wrote:
> > > > The Messaging Unit module enables two processors within the SoC to
> > > > communicate and coordinate by passing messages (e.g. data, status
> > > > and control) through the MU interface.
> > > >
> > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: devicetree at vger.kernel.org
> > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > > ---
> > > > v1->v2:
> > > >  * typo fixes
> > > >  * remove status property
> > > >  * remove imx6&7 compatible string which may be added later for
> > > >    the generic mailbox binding
> > > >
> > > > Note: Because MU used by SCU is not implemented as a mailbox driver,
> > > > Instead, they're provided in library calls to gain higher performance.
> > >
> > > Using a binding doesn't mean you have to use an OS's subsystem.
> > >
> > > What needs higher performance? What's the performance difference?
> > Why
> > > can't the mailbox framework be improved?
> > 
> > From what I see the performance is improved by polling the interrupt
> > registers rather than using interrupts.
> > I see no reason though why this can't be implemented with the mailbox
> > framework as is.
> > 
> 
> I thought you've agreed to not write generic MU(mailbox) driver for SCU.
> https://www.spinics.net/lists/arm-kernel/msg650217.html
> But seems it's still not quite certain...

My suggestion was that we change the compatible of the MU unit to
something that the SCU driver matches. But since we do not do that and
instead use a fsl,imx8qxp-mu compatible for the MU we have to come up
with a MU driver that handles both the SCU case and the regular usecase.
Otherwise we'll end up with a generic driver attaching to the device you
are using under the hoods.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
