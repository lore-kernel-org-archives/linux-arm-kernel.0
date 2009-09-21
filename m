From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Sep 2009 09:49:04 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090921083109.GC20006@shareable.org>
References: <4A7AEEB6.5060903@googlemail.com>
	<1250184014.14019.40.camel@pc1117.cambridge.arm.com>
	<1250501311.9858.24.camel@pc1117.cambridge.arm.com>
	<20090817140422.GA10764@n2100.arm.linux.org.uk>
	<1250529916.11185.80.camel@pc1117.cambridge.arm.com>
	<20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
Message-ID: <1253522944.1541.3.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-09-21 at 09:31 +0100, Jamie Lokier wrote:
> I'm not able to tell from this thread, and I don't have the hardware
> to test either:
> 
> I have some userspace ARM code which modifies instructions and data
> used by those instructions in a few pages, using mprotect() to make
> them writable, modify, and make them PROT_READ|PROT_EXEC again.

As Russell said, we have system call dedicated to flushing the caches if
you write instructions. Now it's arguable whether using mprotect(RX)
should also flush the cache.

> I expect the behaviour is the same as that toolchain which modifies
> instructions in the ELF PLT.  (Which, by the way, an ARM FDPIC-ELF
> for no-MMU I've been working on also does).

In this thread, the dynamic linker only writes data. The CoW mechanism
has the side-effect of incoherent I-D caches.

-- 
Catalin
