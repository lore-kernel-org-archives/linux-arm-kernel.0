From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Mon, 8 Dec 2014 17:51:15 +0800
Subject: [PATCH] mm:add VM_BUG_ON() for page_mapcount()
In-Reply-To: <010b01d012ca$05244060$0f6cc120$@alibaba-inc.com>
References: <010b01d012ca$05244060$0f6cc120$@alibaba-inc.com>
Message-ID: <35FD53F367049845BC99AC72306C23D103E688B313F8@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Hillf Danton [mailto:hillf.zj at alibaba-inc.com]
> Sent: Monday, December 08, 2014 5:33 PM
> To: Wang, Yalin
> Cc: linux-kernel; linux-mm at kvack.org; linux-arm-kernel at lists.infradead.org;
> Andrew Morton; Hillf Danton
> Subject: Re: [PATCH] mm:add VM_BUG_ON() for page_mapcount()
> 
> >
> > This patch add VM_BUG_ON() for slab page, because _mapcount is an
> > union with slab struct in struct page, avoid access _mapcount if this
> > page is a slab page.
> > Also remove the unneeded bracket.
> >
> > Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
> > ---
> >  include/linux/mm.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h index
> > 11b65cf..34124c4 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -373,7 +373,8 @@ static inline void reset_page_mapcount(struct page
> > *page)
> >
> >  static inline int page_mapcount(struct page *page)  {
> > -	return atomic_read(&(page)->_mapcount) + 1;
> > +	VM_BUG_ON(PageSlab(page));
> 
> s/ VM_BUG_ON/ VM_BUG_ON_PAGE/ ?
Yes, I will send again .
