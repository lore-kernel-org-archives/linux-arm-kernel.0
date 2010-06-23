From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Jun 2010 10:32:42 +0100
Subject: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
	check for it on V6
In-Reply-To: <20100623092843.GC12255@atomide.com>
References: <20100621133749.24299.36154.stgit@baageli.muru.com>
	<20100621135120.24299.98499.stgit@baageli.muru.com>
	<20100622170020.GF4371@shareable.org>
	<20100623073912.GA12255@atomide.com>
	<20100623081218.GA16385@n2100.arm.linux.org.uk>
	<20100623092843.GC12255@atomide.com>
Message-ID: <20100623093242.GA17948@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 23, 2010 at 12:28:44PM +0300, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100623 11:06]:
> > On Wed, Jun 23, 2010 at 10:39:13AM +0300, Tony Lindgren wrote:
> > > Yeah that can be done for __kuser_get_tls if it's always writable.
> > > But __switch_to is trickier because of the CONFIG_MMU ifdefs there.
> > 
> > And impossible with XIP kernels.
> > 
> > > What if we have optional __switch_to and __kuser_get_tls implementations
> > > in the mm/proc-*.S files that get copied over the current locations
> > > if implemented?
> > 
> > Also problematical with XIP - if we go down the route of implementing
> > these by copying code fragments into the kernel, we need to strip out
> > XIP support or implement a second way.  Obviously having a second way
> > adds maintainence burden, and the second way will probably lose out
> > on updates.
> 
> How about if we implement the default XIP-safe unoptimized functions,
> with minimal iffdeffery and then allow optional override for non-XIP
> kernels from mm/proc-*.S files?

That's what I was referring to by "second way".
