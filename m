From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Aug 2011 01:55:55 +0300
Subject: [RFC/PATCH 7/7] WIP: HACK/RFC: omap_device: begin to decouple
	platform_device from omap_device
In-Reply-To: <87pqkon5n6.fsf@ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-9-git-send-email-khilman@ti.com>
	<20110730120332.GA15539@n2100.arm.linux.org.uk>
	<20110731025807.GA24334@ponder.secretlab.ca>
	<20110731150540.GA3019@n2100.arm.linux.org.uk>
	<871ux5nnop.fsf@ti.com>
	<CACxGe6t4tNeD-Pn6WFt1XOMC=_Q0cf4uD3kRkOckKH+S1JUJDA@mail.gmail.com>
	<20110801185009.GA5217@legolas.emea.dhcp.ti.com>
	<20110801200743.GA21535@n2100.arm.linux.org.uk>
	<87pqkon5n6.fsf@ti.com>
Message-ID: <20110801225554.GC6244@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 01, 2011 at 03:11:57PM -0700, Kevin Hilman wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > Help the typechecker do its job.  As we have only one (at the moment...)
> > And make it:
> >
> > +struct omap_device;
> >
> >  struct pdev_archdata {
> > +#ifdef CONFIG_ARCH_OMAP
> > +	struct omap_device *omap;
> > +#endif
> >  };
> >
> > for bonus points, so we only get the additional pointer for OMAP.
> 
> OK, will do it this way.

this has the tendency to grow larger, no ? What if all other ARMs decide
to add their own pointers there too ? Counting the mach directories we
have:

$ ls arch/arm/ | grep mach | wc -l
64

minus a few duplicates like mach-omap1 and mach-omap2. Still, if we
count 40 different subarchs and each one of them adds their own pointer
here, this will become quite a messy piece of code, no ?

I agree we should try to have type checks, but considering the
possibility of many different pointers, does it really make sense ?
Nothing against it either, though.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110802/934e7289/attachment.sig>
