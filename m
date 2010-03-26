From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Mar 2010 13:23:16 +0000
Subject: ARM caches variants.
In-Reply-To: <20100326054508.GA19308@shareable.org>
References: <20100323234949.GG20130@shareable.org>
	<1269423728.29073.11.camel@e102109-lin.cambridge.arm.com>
	<20100326054508.GA19308@shareable.org>
Message-ID: <1269609796.807.45.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-03-26 at 05:45 +0000, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > Note that the I-cache on ARMv7 is an aliasing VIPT (when the way size >
> > PAGE_SIZE).
> 
> Aliases in a read-only cache (I-cache) don't matter, so I presume you
> mean it has multiple aliases against the D-cache?
> 
> I think that would only affect what you have to do when flushing
> I-cache lines after writing data, and then only if flushing has to use
> the virtual address, not physical.  Is that right?

Flushing the L1 cache has to use the virtual address even on PIPT
caches. In the Linux case, you can't use the kernel linear mapping to
invalidate an I-cache line if the intention is to use the code in user
space with a different virtual address.

-- 
Catalin
