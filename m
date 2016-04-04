From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 4 Apr 2016 17:05:58 +0200
Subject: [PATCH 1/4] mm: add is_highmem_addr() helper
In-Reply-To: <57022253.70400@ti.com>
References: <1459427384-21374-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459427384-21374-2-git-send-email-boris.brezillon@free-electrons.com>
 <57022253.70400@ti.com>
Message-ID: <20160404170558.0e3278b5@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Apr 2016 13:44:11 +0530
Vignesh R <vigneshr@ti.com> wrote:

> Hi,
> 
> On 03/31/2016 05:59 PM, Boris Brezillon wrote:
> > Add an helper to check if a virtual address is in the highmem region.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  include/linux/highmem.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> > index bb3f329..13dff37 100644
> > --- a/include/linux/highmem.h
> > +++ b/include/linux/highmem.h
> > @@ -41,6 +41,14 @@ void kmap_flush_unused(void);
> >  
> >  struct page *kmap_to_page(void *addr);
> >  
> > +static inline bool is_highmem_addr(const void *x)
> > +{
> > +	unsigned long vaddr = (unsigned long)x;
> > +
> > +	return vaddr >=  PKMAP_BASE &&
> > +	       vaddr < ((PKMAP_BASE + LAST_PKMAP) * PAGE_SIZE);
> 
> 
> Shouldn't this be:
> 		vaddr < (PKMAP_BASE + (LAST_PKMAP * PAGE_SIZE)) ?

Oops, yes indeed.

Anyway, given Russell's feedback I don't think I'm gonna follow up on
this series.

Sorry.

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
