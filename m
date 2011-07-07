From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 13:23:23 +0200
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <alpine.LFD.2.00.1107061228250.14596@xanadu.home>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<201107061442.05182.arnd@arndb.de>
	<alpine.LFD.2.00.1107061228250.14596@xanadu.home>
Message-ID: <201107071323.24143.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Nicolas Pitre wrote:
> > Good idea. The related change that I want to do is to conditionalize
> > all drivers that require PC-style I/O on the respective bus they
> > use, so we can also remove the __io macro for platforms that don't
> > need it and catch all drivers using inb/outb at compile time.
> 
> In the spirit of removing as much machine specific and globally used 
> defines (see my patch series removing a bunch of mach/memory.h 
> instances), I'd like to see a solution that would make IO_SPACE_LIMIT 
> into a variable, or having the same definition with a fixed mapping, for 
> as many SOCs as possible.

I think we don't need to make it a variable as long as we don't need to
support all platforms together in one kernel. Any combinations of recent
platforms should be fine the way that Russell suggested (0xffff if
PCI/ISA/PCMCIA is enabled at compile-time, 0 otherwise).

	Arnd
