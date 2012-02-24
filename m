From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 24 Feb 2012 16:30:16 +0100
Subject: [PATCHv6 7/7] ARM: dma-mapping: add support for IOMMU mapper
In-Reply-To: <201202241431.02170.arnd@arndb.de>
References: <1328900324-20946-1-git-send-email-m.szyprowski@samsung.com>
 <201202241249.44731.arnd@arndb.de>
 <013301ccf2f6$bc4ad840$34e088c0$%szyprowski@samsung.com>
 <201202241431.02170.arnd@arndb.de>
Message-ID: <017701ccf309$357d6f90$a0784eb0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, February 24, 2012 3:31 PM Arnd Bergmann wrote:

> On Friday 24 February 2012, Marek Szyprowski wrote:
> > I want to use some kind of chained arrays, each of at most of PAGE_SIZE. This code
> > doesn't really need to keep these page pointers in contiguous virtual memory area, so
> > it will not be a problem here.
> >
> Sounds like sg_alloc_table(), could you reuse that instead of rolling your own?

I only need to store 'struct page *' there. sg_alloc_table() operates on 'struct statterlist'
entries, which are 4 to 6 times larger than a simple 'struct page *' entry. I don't want to waste
so much memory just for reusing a two function. Implementing the same idea with pure 
'struct page *' pointers will be just a matter of a few lines.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
