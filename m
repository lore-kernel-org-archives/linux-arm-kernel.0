From: vichy.kuo@gmail.com (vichy)
Date: Fri, 10 Jul 2015 17:49:26 +0800
Subject: some question about __dma_alloc in arch/arm/mm/dma-mapping.c
In-Reply-To: <20150706101128.GB27723@e104818-lin.cambridge.arm.com>
References: <CAOVJa8F6v1wA=Z1FKH01hrtb4N29v-hzYysOC6=JWkHFYMQQQA@mail.gmail.com>
 <CAOVJa8F4fZZxWLyEYDSSVT5QTEmRx_psJGZdoHhWi6Zg6hjp8A@mail.gmail.com>
 <20150706101128.GB27723@e104818-lin.cambridge.arm.com>
Message-ID: <CAOVJa8FTtCjBV5q5PQCa-NMS5oAfmgoZK+jDwtF_yrEuAkk5KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Catalin:

2015-07-06 18:11 GMT+08:00 Catalin Marinas <catalin.marinas@arm.com>:
> On Sat, Jul 04, 2015 at 11:08:52PM +0800, vichy wrote:
>> in __dma_alloc of arch/arm/mm/dma-mapping.c, if the size of allocation
>> is PAGE_SIZE, we will use __alloc_remap_buffer instead of
>> __alloc_from_contiguous like below excerpted from __dma_alloc.
>>
>> Is any special reason for PAGE_SIZE allocation NOT getting from continuous pool?
>> Appreciate your kind help in advance,
>>
>>          ..............
>>          if (is_coherent || nommu())
>>                  addr = __alloc_simple_buffer(dev, size, gfp, &page);
>>          else if (!(gfp & __GFP_WAIT))
>>                  addr = __alloc_from_pool(size, &page);
>>          else if (size == PAGE_SIZE || !CMA_DEFAULT_REGION)
>>                  addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller);
>>          else
>>                  addr = __alloc_from_contiguous(dev, size, prot, &page, caller);
>
> You should probably ask whoever gave you this kernel as I can't find the
> code above in mainline.
It is my mistake for not cross-checking the src code on my hand
between the mainline.
You are right, this part of code is not the mainline.

Sorry for making you confused,
