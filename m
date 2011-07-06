From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 19:59:44 +0200
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <20110706174248.GK8286@n2100.arm.linux.org.uk>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<alpine.LFD.2.00.1107061228250.14596@xanadu.home>
	<20110706174248.GK8286@n2100.arm.linux.org.uk>
Message-ID: <201107061959.45225.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011 19:42:48 Russell King - ARM Linux wrote:
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

If the problem is only with a few platforms, my preference would be
to hardcode this to 64k or 0, and leave the platforms that require
something else out of the common zImage for now.

For all platforms that only need the 64k window and don't have any
of other special needs, I would also like to hardcode the virtual
address window eventually, so that inb/outb can still be a single
instruction.

	Arnd
