From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Jun 2017 02:44:10 -0700
Subject: [PATCH v5 4/7] drivers: dma-coherent: Introduce default DMA pool
In-Reply-To: <94e57caa-e7b9-d740-bca3-89950c10033e@arm.com>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <1495621472-9323-5-git-send-email-vladimir.murzin@arm.com>
 <20170620134932.GB31496@infradead.org>
 <94e57caa-e7b9-d740-bca3-89950c10033e@arm.com>
Message-ID: <20170626094410.GC21570@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 02:18:48PM +0100, Vladimir Murzin wrote:
> It is how it has been started [1] - defining memory which is not cacheable
> (i.e. suitable for coherent allocations) and building custom allocator on top
> of it, like it was done for c6x and blackfin. The annoying thing was that we
> needed to advertise such memory via command line parameter plus some "mem="
> adjustment to hide coherent memory from buddy allocator. So it was suggested
> to use reserved memory and this makes things look much better, but on the
> other hand require changes on dts side to "bind" devices with reserved memory
> - default DMA pool removes such drawback.

I like the idea in general, I'm just worried about the overlap with the
per-device coherent memory, especially when we have slight semantic
mismatches like the one about the physical (or rather dma) address
earlier.
