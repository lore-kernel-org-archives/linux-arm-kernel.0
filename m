From: balbi@ti.com (Felipe Balbi)
Date: Thu, 6 Sep 2012 16:16:24 +0300
Subject: [PATCH v7 1/7] drivers: usb: phy: add a new driver for omap usb2
 phy
In-Reply-To: <201209061303.02454.arnd@arndb.de>
References: <1344258480-4304-1-git-send-email-kishon@ti.com>
 <1344258480-4304-2-git-send-email-kishon@ti.com>
 <CAAe_U6KBNZpT03xATmPTNTgxm5hj+wJdsShdnm08EmF4Q=hTCw@mail.gmail.com>
 <201209061303.02454.arnd@arndb.de>
Message-ID: <20120906131623.GI29202@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 01:03:02PM +0000, Arnd Bergmann wrote:
> On Thursday 06 September 2012, ABRAHAM, KISHON VIJAY wrote:
> > > diff --git a/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt b/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
> > > index d2fe064..bb0c7f4 100644
> > > --- a/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
> > > +++ b/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
> > > @@ -8,3 +8,6 @@ properties:
> > >
> > >  Sub-nodes:
> > >  All the devices connected to ocp2scp are described using sub-node to ocp2scp
> > > +- usb2phy :
> > > +   The binding details of usb2phy can be found in:
> > > +   Documentation/devicetree/bindings/usb/omap-usb.txt
> > 
> > The above two lines should be added in omap-ocp2scp.txt (this file was
> > added as part of omap: add ocp2scp as a bus driver and is in
> > linux-next). However this file is still not in Felipe's xceiv branch.
> > So I'm not sure how I can get this patch merged in Felipe's tree
> > without conflict.
> > 
> 
> There are three possible ways to do that:
> 
> * Not add that text. Is is actually required? The ocp2scp bus driver 
> doesn't actually care what is connected to it, does it?
> 
> * Ask Felipe to merge the drivers/ocp2scp branch from arm-soc into
> his branch, then apply your patch on top. The branch is scheduled
> for merging in 3.7 and is stable, so there is no harm merging it
> into his tree, as long as Olof and I are aware of this.
> 
> * Split out this change and apply the patch to add this documentation
> change on top of the drivers/ocp2scp branch in the arm-soc tree.
> There is no strict dependency between this change and the others
> you want to merge, so it does not matter which tree it is merged through.

I'd be more comfortable with option 3 or 1, whatever you guys decide is
fine ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120906/30dd4690/attachment.sig>
