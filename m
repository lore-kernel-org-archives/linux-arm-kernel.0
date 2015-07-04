From: vichy.kuo@gmail.com (vichy)
Date: Sat, 4 Jul 2015 23:06:17 +0800
Subject: some question about __dma_alloc in arch/arm/mm/dma-mapping.c
Message-ID: <CAOVJa8F6v1wA=Z1FKH01hrtb4N29v-hzYysOC6=JWkHFYMQQQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
in __dma_alloc of arch/arm/mm/dma-mapping.c, if the size of allocation
is PAGE_SIZE

if (is_coherent || nommu())
                addr = __alloc_simple_buffer(dev, size, gfp, &page);
        else if (!(gfp & __GFP_WAIT))
                addr = __alloc_from_pool(size, &page);
        else if (size == PAGE_SIZE || !CMA_DEFAULT_REGION)
                addr = __alloc_remap_buffer(dev, size, gfp, prot,
&page, caller);
        else
                addr = __alloc_from_contiguous(dev, size, prot, &page, caller);
