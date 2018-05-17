From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 17 May 2018 08:58:47 -0700
Subject: AArch64 memory
Message-ID: <CAJ+vNU0RrmQMZ0P0LDWfLbryNSt02eDimKr4i6eWT7-ULMOUyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

I'm trying to understand some details of the AArch64 memory
configuration in the kernel.

I've looked at Documentation/arm64/memory.txt which describes the
virtual memory layout used in terms of translation levels. This
relates to CONFIG_ARM64_{4K,16K,64K}_PAGES and CONFIG_ARM64_VA_BITS*.

My first question has to do with virtual memory layout: What are the
advantages and disadvantages for a system with a fixed 2GB of DRAM
when using using 4KB pages + 3 levels (CONFIG_ARM64_4K_PAGES=y
CONFIG_ARM64_VA_BITS=39) resulting in 512GB user / 512GB kernel vs
using 64KB pages + 3 levels (CONFIG_ARM64_64K_PAGES=y
CONFIG_ARM64_VA_BITS=48)? The physical memory is far less than what
any of the combinations would offer but I'm not clear if the number of
levels affects any sort of performance or how fragmentation could play
into performance.

My second question has to do with CMA and coherent_pool. I have
understood CMA as being a chunk of physical memory carved out by the
kernel for allocations from dma_alloc_coherent by drivers that need
chunks of contiguous memory for DMA buffers. I believe that before CMA
was introduced we had to do this by defining memory holes. I'm not
understanding the difference between CMA and the coherent pool. I've
noticed that if CONFIG_DMA_CMA=y then the coherent pool allocates from
CMA. Is there some disadvantage of CONFIG_DMA_CMA=y other than if
defined you need to make sure your CMA is larger than coherent_pool?
What drivers/calls use coherent_pool vs cma?

Best Regards,

Tim
