From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 2 Mar 2015 14:58:41 +0000
Subject: EDAC on arm64
In-Reply-To: <20150302105919.GA4434@arm.com>
References: <54F11133.70909@redhat.com>
 <20150302105919.GA4434@arm.com>
Message-ID: <20150302145840.GQ22541@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 10:59:32AM +0000, Will Deacon wrote:
> On Sat, Feb 28, 2015 at 12:52:03AM +0000, Jon Masters wrote:
> > Have you considered reviving the patch you posted previously for EDAC
> > support (the atomic_scrub read/write test piece dependency)?
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/249039.html
> 
> Well, we'd need a way to handle the non-coherent DMA case and it's really
> not clear how to fix that.

I agree, that's where the discussions stopped. Basically the EDAC memory
writing is racy with any non-cacheable memory accesses (by CPU or
device). The only way we could safely use this is only if all the
devices are coherent *and* KVM is disabled. With KVM, guests may access
the memory uncached, so we hit the same problem.

-- 
Catalin
