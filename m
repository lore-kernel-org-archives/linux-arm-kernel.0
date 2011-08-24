From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Aug 2011 18:45:37 +0100
Subject: [PATCH v4 0/8] MMU disabling code and kexec fixes
In-Reply-To: <alpine.LFD.2.00.1108241323540.20358@xanadu.home>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1108232120590.20358@xanadu.home>
	<20110824105848.GE32688@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108241035400.20358@xanadu.home>
	<20110824165938.GT32688@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108241323540.20358@xanadu.home>
Message-ID: <20110824174537.GW32688@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 06:30:07PM +0100, Nicolas Pitre wrote:
> On Wed, 24 Aug 2011, Will Deacon wrote:
> 
> > On Wed, Aug 24, 2011 at 03:53:44PM +0100, Nicolas Pitre wrote:
> > > On Wed, 24 Aug 2011, Will Deacon wrote:
> > > > On top of that, I'd like to use the bottom of this page as a holding pen
> > > > for secondary CPUs when doing an SMP kexec. In this case, the new kernel
> > > > needs to take care not to allocate the page for general use. I suppose we
> > > > could fix this with a new ATAG / FDT property but that seems a bit overkill.
> > > 
> > > Is it?
> > 
> > Well it means re-encoding a DT blob from within the kernel so that we can
> > tell the next kernel not to allocate from a given page of physical memory.
> > If we already have this infrastructure, then great, but it looks to me like
> > it only lives within dtc (as libfdt) at the moment.
> 
> Hmmm... The kexec user space tools know how to manipulate a device tree 
> for the next kernel, right?  So it's only a matter for it to ask the 
> current kernel what the physical address for that page is and stuff it 
> into the FDT it is preparing already.

oo-er, it seems a bit odd telling userspace about that address but it does
fix the problem. I can't think of a better idea, so I'll start looking for a
sane interface for passing this address back.

Thanks for the help,

Will
