From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 13 Jul 2012 12:21:12 +0530
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <Pine.LNX.4.64.1207061315470.29809@axis700.grange>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FE896F9.2020806@ti.com> <1340647463.1562.127.camel@vkoul-udesk3>
 <201206252030.56025.arnd@arndb.de>
 <Pine.LNX.4.64.1207061315470.29809@axis700.grange>
Message-ID: <1342162272.1726.29.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-07-06 at 13:36 +0200, Guennadi Liakhovetski wrote:
> On Mon, 25 Jun 2012, Arnd Bergmann wrote:
> 
> [snip]
> 
> > The channel data in the device tree is still in a format
> > that is specific to that dmaengine driver and interpreted
> > by it. Using the regular dma_filter_fn prototype is not
> > necessary, but it would be convenient because the dmaengine
> > code already knows how to deal with it. If we don't use this
> > method, how about adding another callback to struct dma_device
> > like
> > 
> > bool (*device_match)(struct dma_chan *chan, struct property *req);
> 
> I like this idea, but why don't we extend it to also cover the non-DT 
> case? I.e., why don't we add the above callback (call it "match" or 
> "filter" or anything else) to dmaengine operations and inside (the 
> extended) dma_request_channel(), instead of calling the filter function, 
> passed as a parameter, we loop over all registered DMAC devices and call 
> their filter callbacks, 
And I have told you many times, that dmacs should not know anything
about clients. They should be totally agnostic to it.

Clients need to request a specific channel, and that is where changes
should come for. Not having dmac provide one.


-- 
~Vinod
