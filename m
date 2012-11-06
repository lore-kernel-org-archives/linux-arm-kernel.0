From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 6 Nov 2012 23:46:53 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <alpine.LFD.2.02.1211061826090.21033@xanadu.home>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <201211051908.34291.arnd@arndb.de>
 <20121106122011.GE29853@mudshark.cambridge.arm.com>
 <201211061733.44781.arnd@arndb.de>
 <alpine.LFD.2.02.1211061533490.21033@xanadu.home>
 <20121106225105.GD10187@jl-vm1.vm.bytemark.co.uk>
 <alpine.LFD.2.02.1211061826090.21033@xanadu.home>
Message-ID: <20121106234653.GF10187@jl-vm1.vm.bytemark.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> On Tue, 6 Nov 2012, Jamie Lokier wrote:
> 
> > Nicolas Pitre wrote:
> > > I really think that it makes no sense at all to support !MMU kernels in 
> > > a multi-platform kernel build, even if the set of included platforms 
> > > were all !MMU.  The kernel has to be linked for the physical address of 
> > > the target and not a common invariant virtual address.
> > 
> > Although there's likely to be approximately zero interest in
> > multi-platform !MMU, relocating at boot time doesn't sound onerous,
> > should it be needed.  x86 kernels already do that.  Maybe ARM kernels
> > will eventually do that anyway for the same reason as x86.
> 
> We already have something similar but simpler: CONFIG_ARM_PATCH_PHYS_VIRT.
> Except that the virtual address the kernel is using always remains the 
> same, even if the physical address can move.  Although this is not the 
> case at the moment, the ARM kdump implementation could take advantage of 
> this ability and avoid the copying of memory around.

I wonder why x86 didn't go that route.  Not that it matters.

-- Jamie
