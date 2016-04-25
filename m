From: niso@kth.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Mon, 25 Apr 2016 16:26:19 +0200
Subject: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
In-Reply-To: <20160421134942.GA3325@infradead.org>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160311125846.GF1111@bigcity.dyn.berto.se>
 <20160315082254.GE9136@infradead.org> <3286525.zPAGiD4Xk2@avalon>
 <20160321152601.GA11674@infradead.org>
 <20160413132916.GC19650@bigcity.dyn.berto.se>
 <20160421134942.GA3325@infradead.org>
Message-ID: <20160425142619.GJ28777@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On 2016-04-21 06:49:42 -0700, Christoph Hellwig wrote:
> On Wed, Apr 13, 2016 at 03:29:17PM +0200, Niklas S?derlund wrote:
> > > Yes, it would be good to do an audit of all the ARM dma_ops as well
> > > as generic code like drivers/base/dma-*.c, lib/dma-debug.c and
> > > include/linux/dma-*.h
> 
> What about things like the phys_addr() helper in lib/dma-debug.c?  That
> was in fact what prompted my question for an audit, and it seems
> to not even feature on your list.  What patterns / symbols did you look
> for?


I have followed the call path from the usage in 
drivers/dma/sh/rcar-dmac.c and made sure the dma_addr_t is not used in a 
bad way.

I also looked at the dma-mapping API and ruled out that the only 
function that make sens to use with a dma_addr_t from dma_map_resource() 
are dma_unmap_resource() and dma_mapping_error(). With that I can't see 
how a dma_addr_t would end up in lib/dma-debug.c. But I might be missing 
something?

In the big picture do you feel the approach I have is the correct way to 
solve my problem? Provided we can work out this issues ofc?

-- 
Regards,
Niklas S?derlund
