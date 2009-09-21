From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2009 09:54:25 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <1253522944.1541.3.camel@pc1117.cambridge.arm.com>
References: <1250501311.9858.24.camel@pc1117.cambridge.arm.com>
	<20090817140422.GA10764@n2100.arm.linux.org.uk>
	<1250529916.11185.80.camel@pc1117.cambridge.arm.com>
	<20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
Message-ID: <20090921085425.GC27357@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2009 at 09:49:04AM +0100, Catalin Marinas wrote:
> On Mon, 2009-09-21 at 09:31 +0100, Jamie Lokier wrote:
> > I expect the behaviour is the same as that toolchain which modifies
> > instructions in the ELF PLT.  (Which, by the way, an ARM FDPIC-ELF
> > for no-MMU I've been working on also does).
> 
> In this thread, the dynamic linker only writes data. The CoW mechanism
> has the side-effect of incoherent I-D caches.

As I already said, that is not really the problem, otherwise all ARMv6
CPUs would fail to work.  This is clearly not the case.  The problem is
the data sitting in the data cache with write allocate caches.

The instruction cache issue is an entirely separate problem.
