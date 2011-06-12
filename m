From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 12 Jun 2011 14:59:29 -0400 (EDT)
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <20110612155940.GM10283@n2100.arm.linux.org.uk>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612112219.GD16318@ibawizard.net>
	<20110612115820.GF10283@n2100.arm.linux.org.uk>
	<201106121615.24059.arnd@arndb.de>
	<20110612145751.GA4013@ponder.secretlab.ca>
	<20110612151931.GK10283@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1106121145570.2142@xanadu.home>
	<20110612155940.GM10283@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1106121454510.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 12 Jun 2011, Russell King - ARM Linux wrote:

> On Sun, Jun 12, 2011 at 11:47:59AM -0400, Nicolas Pitre wrote:
> > On Sun, 12 Jun 2011, Russell King - ARM Linux wrote:
> > > And we've ended up with a fucked up situation which is extremely
> > > fragile, and actually makes me _NOT_ want to convert any existing
> > > platforms to use DT in the least.
> > 
> > Agreed.  I don't think that anything older than OMAP2 is worth 
> > converting to DT.  The return on the investment is simply not worth it, 
> > other than for experimental purposes.
> 
> I think you haven't appreciated the situation - let's take PXA as an
> example.  PXA has been around for years, and IP in the latest silicon
> is present in many of the older silicons too.
> 
> There's two issues here:
> 
> 1. If we port existing drivers over to use DT as a means to shrink the
> size of the kernel, we need _all_ PXA using platforms to use DT.
> 
> 2. If we continue having board support for PXA submitted, we want it to
> use DT support.
> 
> The result will be a mess of some bits of PXA using DT, other bits using
> statically declared stuff.  It may get to the point where on some PXA
> platforms DT is used to describe some of the system, and on a different
> PXA platform, it describes some other but needs some static stuff.
> 
> I don't see this as a sustainable way forward.  If we're going to move a
> particular SoC over to DT, we need to move the entire SoC over.  We can't
> do this half-heartedly.
> 
> And that means we _must_ deal with accepting ATAGs from existing boot
> loaders, with that information taking precidence over the DT blob
> supplied with the kernel.

Well... OK.  Let's see how this can be accommodated with the existing 
patch floating around doing that.

@Grant: could you post the patch you have for that?  Let's see how this 
can be made to play nicely with the DTB append patch.


Nicolas
