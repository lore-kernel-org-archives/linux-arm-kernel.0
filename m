From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 19:15:14 +0100
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <alpine.LFD.2.00.1107061409580.14596@xanadu.home>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<alpine.LFD.2.00.1107061228250.14596@xanadu.home>
	<20110706174248.GK8286@n2100.arm.linux.org.uk>
	<201107061959.45225.arnd@arndb.de>
	<alpine.LFD.2.00.1107061409580.14596@xanadu.home>
Message-ID: <20110706181514.GM8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 02:11:29PM -0400, Nicolas Pitre wrote:
> On Wed, 6 Jul 2011, Arnd Bergmann wrote:
> > If the problem is only with a few platforms, my preference would be
> > to hardcode this to 64k or 0, and leave the platforms that require
> > something else out of the common zImage for now.
> > 
> > For all platforms that only need the 64k window and don't have any
> > of other special needs, I would also like to hardcode the virtual
> > address window eventually, so that inb/outb can still be a single
> > instruction.
> 
> I would say that hardcoding the virtual mapping is probably the first 
> thing to do.  That would certainly simplify the rest of the kernel.

We _used_ to hard-code that mapping, but it became painful to supply
that information into soc_common, which isn't supposed to be ARM
specific.

So going back to hard-coded mappings is a backwards step - essentially
reintroducing one problem which was already solved to resolve a different
problem.

That isn't progress, that's merely changing one resolution for another.
