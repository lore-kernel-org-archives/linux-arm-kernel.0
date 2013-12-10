From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Mon, 09 Dec 2013 19:40:20 -0500
Subject: [PATCH 3/3] swiotlb: Add support for CMA allocations
In-Reply-To: <52A66211.6010707@codeaurora.org>
References: <1386634334-31139-1-git-send-email-lauraa@codeaurora.org>
 <1386634334-31139-4-git-send-email-lauraa@codeaurora.org>
 <1da8f502-0e34-4b54-929e-bcbe40b20b7f@email.android.com>
 <52A66211.6010707@codeaurora.org>
Message-ID: <83dd58eb-9a44-4b76-aa68-4669b26acab8@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Laura Abbott <lauraa@codeaurora.org> wrote:
>On 12/9/2013 4:29 PM, Konrad Rzeszutek Wilk wrote:
>> Laura Abbott <lauraa@codeaurora.org> wrote:
>>> Some architectures may implement the CMA APIs to allow allocation
>>> of larger contiguous blocks of memory. Add support in the swiotlb
>>> alloc/free functions to allocate from the CMA APIs instead of the
>>> basic page allocator.
>>>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>...
>>>
>>
>> Can this be done in the platform dma_ops functions instead?
>>
>
>I suppose it could but that seems like it would result in lots of 
>duplicated code if every architecture that uses swiotlb wants to use
>CMA.
>
>Thanks,
>Laura

Then let's do that it that way. Thank you.
