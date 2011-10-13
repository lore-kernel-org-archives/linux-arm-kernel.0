From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Oct 2011 09:52:43 +0100
Subject: change_page_attr() implementation for ARM?
In-Reply-To: <401E54CE964CD94BAE1EB4A729C7087E3722519EE2@HQMAIL04.nvidia.com>
References: <D19EBEE1D7B1F742A8ED7130E050A38A4CA460FF0C@HQMAIL02.nvidia.com>
	<CAHkRjk4mqhu+HhoSAnowk6=5GzXXhmKCE-3jrjhMpVzbtakFYg@mail.gmail.com>
	<401E54CE964CD94BAE1EB4A729C7087E3722519EE2@HQMAIL04.nvidia.com>
Message-ID: <20111013085243.GB6300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 03:27:58AM +0100, Krishna Reddy wrote:
> >> On Cortex-A9, we have observed stale data being read from
> >> write-combine (C=0 B=1) memory regions mapped into userspace which
> >> have a duplicate cacheable mapping in the kernel address space (due
> >> to the kernel linear mapping).
> >>
> >> The issue appears to be due to speculative prefetch on the
> >> cacheable kernel linear mapping which gets lines into the L2 cache.
> >> When reads are performed on the write-combine mapping for this
> >> address range, these reads get the stale data from L2 instead of
> >> memory.
> 
> >If your system has a PL310, there is bit 22 in the auxiliary control
> >register which makes reads via the non-cacheable mapping not to hit
> >the L2 cache. I had this patch queued in Russell's system for a long
> >time:
> >http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6529/1
> >Alternatively, you can pass this bit via your platform code.
> 
> Is this is a quick fix for ARM processors with PL310. Can this be
> expected in future versions of ARM processors with different L2 cache?

That's specific to the PL310 cache controller, nothing to do with the
CPU. It's a configuration bit that may be useful in some scenarios.

-- 
Catalin
