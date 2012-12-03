From: bhutchings@solarflare.com (Ben Hutchings)
Date: Mon, 3 Dec 2012 14:01:30 +0000
Subject: [PATCH] net/macb: Use dmapool to align descriptors on 64bits
In-Reply-To: <1354536914-6315-1-git-send-email-nicolas.ferre@atmel.com>
References: <1354536914-6315-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1354543290.7030.26.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-12-03 at 13:15 +0100, Nicolas Ferre wrote:
> Depending on datapath, some revisions of GEM need
> 64bits aligned descriptors. Use dmapool to allocate
> these descriptors.
> Note that different size between RX and TX rings
> leads to the creation of two pools.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
[...]

dma_alloc_coherent() allocates whole pages, which I think is quite
enough alignment.  You can't save memory by doing this, since each pool
needs at least one page.  So what is this change meant to achieve?

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
