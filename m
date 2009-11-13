From: rmk@arm.linux.org.uk (Russell King)
Date: Fri, 13 Nov 2009 15:12:58 +0000
Subject: [RFC 11/11] ARM: avoid flushing I-cache in flush_cache_mm()
In-Reply-To: <4AFD74CA.3040507@xenomai.org>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<f4e898a97589fdee3c689780212fe225e6732a6b.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<4AFD74CA.3040507@xenomai.org>
Message-ID: <20091113151258.GB27752@flint.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 04:01:30PM +0100, Gilles Chanteperdrix wrote:
> Russell King wrote:
> > flush_cache_mm() is called in two cases:
> > 1. when a process exits, just before the page tables are torn down.
> >    We can allow the stale lines to evict themselves over time without
> >    causing any harm.
> 
> Is not there any risk to see cache lines evicted at a time when there
> are no longer any page table entries for them? This was said to be a
> problem during the early discussions on FCSE:

The discussion here is about the instruction cache - that doesn't write
back cache lines.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
