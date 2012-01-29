From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 29 Jan 2012 20:51:46 +0000
Subject: [PATCHv19 00/15] Contiguous Memory Allocator
In-Reply-To: <20120127162624.40cba14e.akpm@linux-foundation.org>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <201201261531.40551.arnd@arndb.de>
 <20120127162624.40cba14e.akpm@linux-foundation.org>
Message-ID: <201201292051.46297.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 January 2012, Andrew Morton wrote:
> These patches don't seem to have as many acked-bys and reviewed-bys as
> I'd expect.  Given the scope and duration of this, it would be useful
> to gather these up.  But please ensure they are real ones - people
> sometimes like to ack things without showing much sign of having
> actually read them.

I reviewed early versions of this patch set and had a lot of comments on the
interfaces that were exposed to device drivers and platform maintainers.

All of the comments were addressed back then and I gave an Acked-by.
I assume that it was dropped in subsequent versions because the
implementation changed significantly since, but I'm still happy with the
way this looks to the user, in particular that it is practically invisible
because all users just go through the dma mapping API instead of the
horrors that were used in the original patches.

>From an ARM architecture perspective, we have come to the point (some
versions ago) where we actually require the CMA patchset for correctness,
even on IOMMU based systems because it avoids some nasty corner cases
with pages that are both in the linear kernel mapping and in an
uncached mapping for DMA: We know that the code we are using in mainline
is broken on ARMv6 and later and that CMA fixes that problem.

I'm not the right person to judge the memory management code changes,
others need to comment on that. Aside from that:

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
