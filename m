From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 08 Jul 2011 09:38:56 -0400 (EDT)
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <20110708090302.GB2414@n2100.arm.linux.org.uk>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<201107071343.03591.arnd@arndb.de>
	<20110707123707.GN8286@n2100.arm.linux.org.uk>
	<201107071521.07070.arnd@arndb.de>
	<20110707141254.GR8286@n2100.arm.linux.org.uk>
	<CAGsJ_4wsc=Jx6+thKriX+x5KdX2m8O9HfrnC_MGYAXTUe-DoRg@mail.gmail.com>
	<20110708090302.GB2414@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107080937440.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Jul 2011, Russell King - ARM Linux wrote:

> On Fri, Jul 08, 2011 at 10:18:57AM +0800, Barry Song wrote:
> > simply adding a UL suffix will make compiling fail since
> > arch/arm/kernel/debug.S will refer to the macro calculating virtual
> > address of SIRFSOC_UART1_VA_BASE and UL is not legal in asm.
> 
> A solution for VMALLOC_END would be to include linux/const.h and use
> _AC(value, UL).  I think you're the only one who bases their IO
> addressing off VMALLOC_END.

This is also a bad idea to use VMALLOC_END like that since this is 
another per-architecture constant which is targetted for a global 
removal.


Nicolas
