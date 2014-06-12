From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Thu, 12 Jun 2014 16:41:40 +0900
Subject: [PATCH v2 05/10] DMA, CMA: support arbitrary bitmap granularity
In-Reply-To: <20140612070811.GI12415@bbox>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-6-git-send-email-iamjoonsoo.kim@lge.com>
 <20140612070811.GI12415@bbox>
Message-ID: <20140612074140.GA20199@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 04:08:11PM +0900, Minchan Kim wrote:
> On Thu, Jun 12, 2014 at 12:21:42PM +0900, Joonsoo Kim wrote:
> > ppc kvm's cma region management requires arbitrary bitmap granularity,
> > since they want to reserve very large memory and manage this region
> > with bitmap that one bit for several pages to reduce management overheads.
> > So support arbitrary bitmap granularity for following generalization.
> > 
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Acked-by: Minchan Kim <minchan@kernel.org>
> 

Thanks.

[snip...]
> >  /**
> >   * dma_alloc_from_contiguous() - allocate pages from contiguous area
> >   * @dev:   Pointer to device for which the allocation is performed.
> > @@ -345,7 +372,8 @@ static void clear_cma_bitmap(struct cma *cma, unsigned long pfn, int count)
> >  static struct page *__dma_alloc_from_contiguous(struct cma *cma, int count,
> >  				       unsigned int align)
> >  {
> > -	unsigned long mask, pfn, pageno, start = 0;
> > +	unsigned long mask, pfn, start = 0;
> > +	unsigned long bitmap_maxno, bitmapno, nr_bits;
> 
> Just Nit: bitmap_maxno, bitmap_no or something consistent.
> I know you love consistent when I read description in first patch
> in this patchset. ;-)

Yeah, I will fix it. :)

Thanks.
