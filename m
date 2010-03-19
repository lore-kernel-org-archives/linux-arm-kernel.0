From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 19 Mar 2010 14:56:28 -0400 (EDT)
Subject: Highmem issues with MMC filesystem
In-Reply-To: <1269023212.22473.5.camel@e102109-lin.cambridge.arm.com>
References: <alpine.LFD.2.00.1003191348231.31128@xanadu.home>
	<1269023212.22473.5.camel@e102109-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1003191451460.31128@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Mar 2010, Catalin Marinas wrote:

> On Fri, 2010-03-19 at 17:59 +0000, Nicolas Pitre wrote:
> > On Fri, 19 Mar 2010, Russell King - ARM Linux wrote:
> > 
> > > On Fri, Mar 19, 2010 at 09:17:19AM -0400, Nicolas Pitre wrote:
> > > > And in this case, the same SATA driver is used on two different system,
> > > > one being ARMv5 with absolutely no issues with highmem, and the other
> > > > being ARMv6 with highmem problems.  So that pretty much rules out IDE
> > > > driver bugs.
> > >
> > > No it doesn't - there's more changes between ARMv5 and ARMv6 than just
> > > the cache model.  There's weak memory ordering effects too.
> > 
> > Sure.  But at the moment we have:
> > 
> >  - ARMv5 without highmem -> works
> > 
> >  - ARMv5 with highmem -> works
> > 
> >  - ARMv6 without highmem -> works
> > 
> >  - ARMv6 with highmem -> fails
> > 
> > In all four cases the SATA driver, the hard disk and the filesystem on
> > it are identical.  In the two ARMv5 cases the system and the kernel are
> > identical.  Ditto for the two ARMv6 cases.
> 
> Which ARMv6 processor is this?

Marvell 88AP510 aka Dove.  But the same issue was reported on OMAP.

> Is the SATA driver using DMA (I think I read this in the thread but it
> started as MMC issues and got confused)?

Any block device using DMA is affected.  Drivers using PIO are not, 
neither is NFS.  And again, using the _same_ kernel with mem=512m so to 
be sure highmem doesn't kick in exhibits no issue even with DMA.


Nicolas
