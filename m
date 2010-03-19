From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 19 Mar 2010 14:51:39 -0400 (EDT)
Subject: Highmem issues with MMC filesystem
In-Reply-To: <20100319183820.GB27710@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1003171050160.31128@xanadu.home>
	<20100318092352.GD8267@n2100.arm.linux.org.uk>
	<c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
	<20100318112453.GA19544@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003180904440.31128@xanadu.home>
	<1269009677.31227.10.camel@e102109-lin.cambridge.arm.com>
	<20100319144647.GG21280@n2100.arm.linux.org.uk>
	<1269010320.31227.13.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1003191347230.31128@xanadu.home>
	<alpine.LFD.2.00.1003191359440.31128@xanadu.home>
	<20100319183820.GB27710@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1003191449180.31128@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Mar 2010, Russell King - ARM Linux wrote:

> On Fri, Mar 19, 2010 at 02:27:24PM -0400, Nicolas Pitre wrote:
> > But on ARMv6 this is different.  The L1 cache is VIPT and it therefore 
> > doesn't have to be flushed as often as a VIVT cache.  Still, as far as I 
> > know, the highmem code currently always flush any page to be unmapped.  
> > But somewhere somehow an unmapped highmem page becomes subject to DMA 
> > and apparently can still be L1 cached.
> 
> This does not explain the corrupted ext2 metadata, which is in lowmem
> pages.

Please could you forget about EXT2 for now?  Let's pretend I never 
mentioned it.  As a matter of fact I can,t see EXT2 errors anymore in 
the flood of user space segfaults.


Nicolas
> Let's get a fresh set of clear bug reports giving all relevant information.
> Let's not continue to scatter small little bits of information in multiple
> emails.

I think I did, less than 30 minutes ago.


Nicolas
