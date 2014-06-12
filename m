From: minchan@kernel.org (Minchan Kim)
Date: Thu, 12 Jun 2014 15:42:55 +0900
Subject: [PATCH v2 05/10] DMA, CMA: support arbitrary bitmap granularity
In-Reply-To: <20140612064355.GC19918@js1304-P5Q-DELUXE>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-6-git-send-email-iamjoonsoo.kim@lge.com>
 <20140612060610.GH12415@bbox>
 <20140612064355.GC19918@js1304-P5Q-DELUXE>
Message-ID: <20140612064255.GA12663@bbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 03:43:55PM +0900, Joonsoo Kim wrote:
> On Thu, Jun 12, 2014 at 03:06:10PM +0900, Minchan Kim wrote:
> > On Thu, Jun 12, 2014 at 12:21:42PM +0900, Joonsoo Kim wrote:
> > > ppc kvm's cma region management requires arbitrary bitmap granularity,
> > > since they want to reserve very large memory and manage this region
> > > with bitmap that one bit for several pages to reduce management overheads.
> > > So support arbitrary bitmap granularity for following generalization.
> > > 
> > > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > 
> > > diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> > > index bc4c171..9bc9340 100644
> > > --- a/drivers/base/dma-contiguous.c
> > > +++ b/drivers/base/dma-contiguous.c
> > > @@ -38,6 +38,7 @@ struct cma {
> > >  	unsigned long	base_pfn;
> > >  	unsigned long	count;
> > >  	unsigned long	*bitmap;
> > > +	int order_per_bit; /* Order of pages represented by one bit */
> > 
> > Hmm, I'm not sure it's good as *general* interface even though it covers
> > existing usecases.
> > 
> > It forces a cma area should be handled by same size unit. Right?
> > It's really important point for this patchset's motivation so I will stop
> > review and wait other opinions.
> 
> If you pass 0 to order_per_bit, you can manage cma area in every
> size(page unit) you want. If you pass certain number to order_per_bit,
> you can allocate and release cma area in multiple of such page order.
> 
> I think that this is more general implementation than previous versions.

Fair enough.

-- 
Kind regards,
Minchan Kim
