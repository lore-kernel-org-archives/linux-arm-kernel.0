From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Thu, 27 Sep 2012 15:06:34 +0530
Subject: [RFC PATCH 10/13] spi: omap2-mcspi:
 dma_request_slave_channel() support for DT platforms
In-Reply-To: <20120921183729.GI16522@beef>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-11-git-send-email-mporter@ti.com>
 <20120920220931.GJ28835@atomide.com> <201209210816.01473.arnd@arndb.de>
 <20120921154247.GZ28835@atomide.com>  <20120921183729.GI16522@beef>
Message-ID: <1348738594.1648.9.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-21 at 14:37 -0400, Matt Porter wrote:
> On Fri, Sep 21, 2012 at 08:42:47AM -0700, Tony Lindgren wrote:
> > 
> > Can't we come up with a version of dma_request_slave_channel that works
> > both ways for now:
> > 
> > 	mcspi_dma->dma_rx =
> > 		dma_request_slave_channel_compat(mask, omap_dma_filter_fn, &sig,
> > 					&master->dev, mcspi_dma->dma_rx_ch_name);
> > 	...			
> > 
> > Then it's just question of patching away two lines later on rather than
> > having to add all this if else to all the drivers first, then patching
> > it away again.
> 
> I think that something like that is workable with the implementation
> simply checking for of_node to do the right thing.
Yes, I think it would be better to have common API but underneath two
implementations in transitional phase.



-- 
~Vinod
