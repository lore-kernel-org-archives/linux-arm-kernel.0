From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 30 Nov 2011 15:43:50 -0500 (EST)
Subject: [PATCH v3 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <20111130175410.GJ2045@localhost.localdomain>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-5-git-send-email-pawel.moll@arm.com>
 <20111130153749.GE2045@localhost.localdomain>
 <1322673302.3180.25.camel@hornet.cambridge.arm.com>
 <20111130175410.GJ2045@localhost.localdomain>
Message-ID: <alpine.LFD.2.02.1111301522340.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Nov 2011, Dave Martin wrote:

> On Wed, Nov 30, 2011 at 05:15:02PM +0000, Pawel Moll wrote:
> > On Wed, 2011-11-30 at 15:37 +0000, Dave Martin wrote:
> > >
> > > This results in a uImage which is a bit broken if using a normal u-Boot
> > > configured for vexpress-v2p-ca9, because the bootloader makes some
> > > memory map assumptions, and anyway we don't expect the kernel to work
> > > unless it's loaded at the start of RAM:

> > Yes, this is known problem with U-boot. Could you try again with
> > "mem=512M" parameter?
> 
> U-Boot's built-in assumption about using addresses around 0x7f000000 to
> relocate the dtb and initrd are clearly a problem here, though if that
> was the only problem, the kernel would have booted further than this...
> 
> It would be nice to know what's going on here, but I'm reasonably
> convinced that we're just booting the kernel in a silly way here, and
> U-Boot really needs to be fixed to avoid the fixed-load-address
> limitation.
> 
> > > Was the hard-coded uImage load address/entry point problem ever fixed?
> > > (It totally defeats loading a single uImage on multiple board variants.)
> > 
> > I simply don't use U-boot at all, what solves the problem
> > "systematically" ;-) I wonder if it was possible to override the
> > load/entry address in the runtime?
> 
> I believe not, but there have been some discussions about loading to a
> default "start of RAM" location if the uImage's load address/entry point
> are zero, or having some header flag to indicate this.
> 
> I don't know about the implementation status of this, though.

Stephen Warren posted some patches to fix this.  The u-Boot maintainer 
was having some "issues" with them.  I don't know if this has been 
resolved at this point.

Of course this would help if more people other than Stephen and myself 
were putting some pressure on the maintainer for this problem to get 
fixed satisfactorily.

I have changes to the kernel which are pending some resolution on the 
u-Boot side for this very issue at the moment which is getting rather 
annoying.  If nothing moves I might just go ahead with those changes and 
simply rip the uImage make target out of the kernel as well.  Maybe the 
inconvenience will be a sufficient incentive for people to lobby proper 
u-Boot support.  And it is not like if the u-Boot patches didn't exist 
already.


Nicolas
