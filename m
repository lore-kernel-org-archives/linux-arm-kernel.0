From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 06 Jul 2011 14:09:49 -0400 (EDT)
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <20110706174248.GK8286@n2100.arm.linux.org.uk>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-2-git-send-email-bs14@csr.com>
	<20110706122501.GU8286@n2100.arm.linux.org.uk>
	<201107061442.05182.arnd@arndb.de>
	<alpine.LFD.2.00.1107061228250.14596@xanadu.home>
	<20110706174248.GK8286@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107061402370.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2011, Russell King - ARM Linux wrote:

> On Wed, Jul 06, 2011 at 12:35:54PM -0400, Nicolas Pitre wrote:
> > In the spirit of removing as much machine specific and globally used 
> > defines (see my patch series removing a bunch of mach/memory.h 
> > instances), I'd like to see a solution that would make IO_SPACE_LIMIT 
> > into a variable, or having the same definition with a fixed mapping, for 
> > as many SOCs as possible.
> 
> In theory it should be possible to have it defined as 64K across
> everything.  ISTR that you were against that with SA1100 platforms
> because of the PCMCIA problem though...

To be honest, if I was against it, the reasons have long been swapped 
out of my brain.  And since those machines with pretenses of ISA-type 
buses are fading away in terms of actual users, I don't really mind if 
they are not consolidated.  As long as those machines with PCI or none 
of it can rely on shared definitions that should be good enough.


Nicolas
