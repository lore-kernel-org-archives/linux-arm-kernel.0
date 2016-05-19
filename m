From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Thu, 19 May 2016 13:29:26 +0200
Subject: [PATCHv6 3/8] dma-mapping: add dma_{map,unmap}_resource
In-Reply-To: <20160517145445.GE4074@char.us.oracle.com>
References: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1462812247-3414-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160517145445.GE4074@char.us.oracle.com>
Message-ID: <20160519112926.GO29375@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Konrad,

Thanks for your feedback.

On 2016-05-17 10:54:45 -0400, Konrad Rzeszutek Wilk wrote:
> >  
> > -In some circumstances dma_map_single() and dma_map_page() will fail to create
> > -a mapping. A driver can check for these errors by testing the returned
> > -DMA address with dma_mapping_error(). A non-zero return value means the mapping
> > -could not be created and the driver should take appropriate action (e.g.
> > -reduce current DMA mapping usage or delay and try again later).
> > +In some circumstances dma_map_single(), dma_map_page() and dma_map_resource()
> > +will fail to create a mapping. A driver can check for these errors by testing
> > +the returned DMA address with dma_mapping_error(). A non-zero return value
> > +means the mapping could not be created and the driver should take appropriate
> > +action (e.g. reduce current DMA mapping usage or delay and try again later).
> 
> This looks like it belongs to another patch?

No it is correct (at least intended to be in this patch). All it really 
do is inject dma_map_resource() (which is added in this patch) as one of 
the calls which return dma_addr_t should be checked for error using 
dma_mapping_error().  But yes the change effect all lines in the 
paragraph due to line wrapping.

Hum or maybe I'm misunderstanding your question.

-- 
Regards,
Niklas S?derlund
