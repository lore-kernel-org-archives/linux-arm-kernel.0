From: hongxing.zhu@nxp.com (Richard Zhu)
Date: Mon, 15 Feb 2016 06:44:06 +0000
Subject: [RFC 3/4] ARM: imx: add the platform related rpmsg implementation
In-Reply-To: <20160215061009.GU6756@tiger>
References: <1452067604-10466-1-git-send-email-hongxing.zhu@nxp.com>
 <1452067604-10466-4-git-send-email-hongxing.zhu@nxp.com>
 <20160128013527.GA9070@tiger>
 <DBXPR04MB2708826D9E8C16E8EFE492E8CDA0@DBXPR04MB270.eurprd04.prod.outlook.com>
 <20160215061009.GU6756@tiger>
Message-ID: <DBXPR04MB27087D6DD453A62CEE368BF8CAC0@DBXPR04MB270.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Monday, February 15, 2016 2:10 PM
> To: Richard Zhu
> Cc: ohad at wizery.com; Stefan Agner; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [RFC 3/4] ARM: imx: add the platform related rpmsg
> implementation
> 
> +LAKML
> 
> On Thu, Jan 28, 2016 at 02:17:21AM +0000, Richard Zhu wrote:
> > Hi Shawn:
> > Thanks for your comments.
> > Further review would copied to Stefan Agner.
> 
> Please do not top-posting.
> 
> > On Wed, Jan 06, 2016 at 04:06:43PM +0800, Richard Zhu wrote:
> > > From: Richard Zhu <Richard.Zhu@freescale.com>
> > >
> > > - add mu driver support, the irq and 4bytes msg of the mu module are
> > > as the interaction channel between A# core and the M4 core on imx
> > > amp platforms.
> > > - register one notify in isr of the mu's irq used by rpmsg.
> > > - instance the virtual processor, and fill up the virtio_config_ops
> > > in the platform related rpmsg implementation codes.
> > > - hard-code the vring storage shared by A# core and M# core on AMP
> > > SOCs.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  arch/arm/mach-imx/Kconfig     |  12 ++
> > >  arch/arm/mach-imx/Makefile    |   2 +
> > >  arch/arm/mach-imx/imx_rpmsg.c | 364
> ++++++++++++++++++++++++++++++++++++++++++
> > >  arch/arm/mach-imx/mu.c        | 217 +++++++++++++++++++++++++
> >
> > I'm not rpmsg expert, but it seems to me that the driver should be put into
> drivers/rpmsg/ rather than mach-imx.
> > [Richard] This part rpmsg codes are closed related to the platform. For
> example, kinds of ops callback functions.
> > Thus, these codes are placed into arch/arm/mach-imx/ folder. BTW,  so does
> to omap rpmsg implementation.
> > http://omappedia.org/wiki/RPMsg_Kernel_Sources
> 
> I just took a closer look at this.  What the omappedia page above describes is
> an OMAP rpmsg implementation in a vendor tree which is in turn based on a
> relatively old kernel version, i.e. v3.0.
> 
> I guess the implementation is a base of what mainline has today on
> remoteproc/rpmsg support, but they are somehow different.  For example, on
> mainline kernel today, there is no remoteproc/rpmsg code in arch/arm/plat-
> omap.  And, instead of handling rpmsg with a platform specific driver,
> remoteproc encapsulates the rpmsg support.  You can find the details in
> commit ac8954a41393 (remoteproc: create rpmsg virtio device).
> 
> I suggest you look at the mainline code today instead of any old
> implementation for reference.  And in any case, with device tree support to
> populate platform device as needed, it's a wrong to put remoteproc/rpmsg
> related driver code into arch/arm/mach-imx.
> 
> Shawn
[Zhu hongxing]  Thanks a lot for your advice. I would take look into it, and re-organize my
patch-set.

Best Regards
hongxing zhu
