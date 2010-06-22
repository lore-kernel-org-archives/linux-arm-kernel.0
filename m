From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Jun 2010 12:34:01 +0100
Subject: [PATCH v4 0/4] Patches for -next
In-Reply-To: <AANLkTimFl8rOzipTjsJ39HyPQDkEjZeliKHssxyL4df6@mail.gmail.com>
References: <20100621144409.26309.87173.stgit@e102109-lin.cambridge.arm.com>
	<AANLkTimFl8rOzipTjsJ39HyPQDkEjZeliKHssxyL4df6@mail.gmail.com>
Message-ID: <1277206441.22719.41.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-06-22 at 11:29 +0100, Rabin Vincent wrote:
> On Mon, Jun 21, 2010 at 8:16 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > Pretty much the same content as v3 but I reordered the last three
> > patches to make sure that switching to lazy cache flushing on ARMv7 SMP
> > doesn't make the set_pte/cache flushing race more visible (issue handled
> > by the set_pte_at patch).
> >
> >
> > Catalin Marinas (4):
> >      ARM: Remove the domain switching on ARMv6k/v7 CPUs
> >      ARM: Assume new page cache pages have dirty D-cache
> >      ARM: Synchronise the I and D caches via set_pte_at() on SMP systems
> >      ARM: Use lazy cache flushing on ARMv7 SMP systems
> 
> I've tried patches 2, 3, and 4 on a Cortex-A9 SMP system and it resolves the
> MMC rootfs init crash without the need for the flush_kernel_dcache_page()
> change.
> 
> Tested-by: Rabin Vincent <rabin.vincent@stericsson.com>

Thanks.

> P.S.: Patch 1 (at least the version on your proposed branch), doesn't seem to
> apply cleanly on linux-next.

It's a bit more intrusive and I'd like to push it to linux-next (but
still waiting for review on this list).

-- 
Catalin
