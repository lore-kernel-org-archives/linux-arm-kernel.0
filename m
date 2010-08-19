From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 19 Aug 2010 18:56:53 +0200
Subject: ARM: 2.6.3[45] PCI regression (IXP4xx and PXA?)
In-Reply-To: <20100819175024W.fujita.tomonori@lab.ntt.co.jp> (FUJITA
	Tomonori's message of "Thu, 19 Aug 2010 17:51:51 +0900")
References: <20100813215413.GA21607@n2100.arm.linux.org.uk>
	<20100814181306U.fujita.tomonori@lab.ntt.co.jp>
	<m3vd7agmqa.fsf@intrepid.localdomain>
	<20100819175024W.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <m34oeqsfqi.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> writes:

>> > +++ b/arch/arm/mm/dma-mapping.c
>> > @@ -77,6 +77,11 @@ static struct page *__dma_alloc_buffer(struct device *dev, size_t size, gfp_t gf
>> >  	if (mask < 0xffffffffULL)
>> >  		gfp |= GFP_DMA;
>> >  
>> > +#ifdef CONFIG_DMABOUNCE
>> > +	if (dev->archdata.dmabounce)
>> > +		gfp |= GFP_DMA;
>> > +#endif
>> > +
>> >  	page = alloc_pages(gfp, order);
>> >  	if (!page)
>> >  		return NULL;

> I'll re-send the patch in the proper format. Can you send it to
> mainline for 2.6.36?

Guess that's a question for Russell.
-- 
Krzysztof Halasa
