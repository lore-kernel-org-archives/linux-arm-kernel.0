From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 21 Aug 2012 12:14:51 +0200
Subject: [PATCH 2/3] ARM: DMA-Mapping: print warning when atomic coherent
 allocation fails
In-Reply-To: <20120820230058.GA755@harshnoise.musicnaut.iki.fi>
References: <1345459648-24263-1-git-send-email-m.szyprowski@samsung.com>
 <1345459648-24263-3-git-send-email-m.szyprowski@samsung.com>
 <20120820230058.GA755@harshnoise.musicnaut.iki.fi>
Message-ID: <000d01cd7f85$d091b3c0$71b51b40$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, August 21, 2012 1:01 AM Aaro Koskinen wrote:

> On Mon, Aug 20, 2012 at 12:47:27PM +0200, Marek Szyprowski wrote:
> > @@ -461,6 +461,9 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
> >  		bitmap_set(pool->bitmap, pageno, count);
> >  		ptr = pool->vaddr + PAGE_SIZE * pageno;
> >  		*ret_page = pool->page + pageno;
> > +	} else {
> > +		pr_err("Atomic coherent pool too small!\n"
> > +		       "Please increase it with coherent_pool= kernel parameter!\n");
> 
> This should be rate limited, perhaps even printed only once.

Ok, I will change it to pr_err_once().

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
