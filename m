From: kwangwoo.lee@sk.com (kwangwoo.lee at sk.com)
Date: Wed, 10 Aug 2016 02:14:30 +0000
Subject: [PATCH v3] arm64: mm: convert __dma_* routines to use start, size
In-Reply-To: <80a4602f-8105-fe2e-0f52-ee23f2c0b2e4@arm.com>
References: <1470099050-25407-1-git-send-email-kwangwoo.lee@sk.com>
 <80a4602f-8105-fe2e-0f52-ee23f2c0b2e4@arm.com>
Message-ID: <86c4d03a1bf84da6a460fa2cc1455032@nmail01.hynixad.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Tuesday, August 09, 2016 8:51 PM
> To: ???(LEE KWANGWOO) MS SW; Russell King - ARM Linux; Catalin Marinas; Will Deacon; Mark Rutland;
> linux-arm-kernel at lists.infradead.org
> Cc: ???(CHUNG WOO SUK) MS SW; ???(KIM HYUNCHUL) MS SW; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v3] arm64: mm: convert __dma_* routines to use start, size
> 
> On 02/08/16 01:50, Kwangwoo Lee wrote:
> > __dma_* routines have been converted to use start and size instread of
> > start and end addresses. The patch was origianlly for adding
> > __clean_dcache_area_poc() which will be used in pmem driver to clean
> > dcache to the PoC(Point of Coherency) in arch_wb_cache_pmem().
> >
> > The functionality of __clean_dcache_area_poc()  was equivalent to
> > __dma_clean_range(). The difference was __dma_clean_range() uses the end
> > address, but __clean_dcache_area_poc() uses the size to clean.
> >
> > Thus, __clean_dcache_area_poc() has been revised with a fallthrough
> > function of __dma_clean_range() after the change that __dma_* routines
> > use start and size instead of using start and end.
> >
> > As a consequence of using start and size, the name of __dma_* routines
> > has also been altered following the terminology below:
> >     area: takes a start and size
> >     range: takes a start and end
> 
> This looks pretty nice and tidy now; I don't see anything obviously
> wrong, and comparing before-and-after disassemblies shows essentially
> nothing more than the movement of some add instructions as expected, so:
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thank you very much for your review!
I'm going to add Reviewed-by: and Cc: lines and send it again. Thanks!

Best Regards,
Kwangwoo Lee
