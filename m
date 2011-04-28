From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Apr 2011 09:31:12 +0100
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <1303940737.2513.190.camel@pasglop>
References: <201104212129.17013.arnd@arndb.de>
	<BANLkTinPbZZS9F1tRCA73fgoD-y__jSfCA@mail.gmail.com>
	<1303940737.2513.190.camel@pasglop>
Message-ID: <1303979472.26744.6.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-04-27 at 22:45 +0100, Benjamin Herrenschmidt wrote:
> On Wed, 2011-04-27 at 10:52 +0100, Catalin Marinas wrote:
> > It's not broken since we moved to using Normal non-cacheable memory
> > for the coherent DMA buffers (as long as you flush the cacheable alias
> > before using the buffer, as we already do). The ARM ARM currently says
> > unpredictable for such situations but this is being clarified in
> > future updates and the Normal non-cacheable vs cacheable aliases can
> > be used (given correct cache maintenance before using the buffer).
> 
> Don't you have a risk where speculative loads or prefetches might bring
> back some stuff into the cache via the cachable mapping ? Is that an
> issue ? As long as it's non-dirty and the cachable mapping isn't
> otherwise used, I suppose it might be a non-issue, tho I've seen in
> powerpc land cases of processors that can checkstop if a subsequent non
> cachable access "hits" the stuff that was loaded in the cache.

At the CPU cache level, unexpected cache hit is considered a miss, IOW
non-cacheable memory accesses ignore the cache lines that may have been
speculatively loaded.

-- 
Catalin
