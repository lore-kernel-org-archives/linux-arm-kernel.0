From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 18 Feb 2014 15:45:51 +0000
Subject: [PATCH V2] arm: mm: Remove hugetlb warning from Coherent DMA
 allocator
In-Reply-To: <1389866863-24460-1-git-send-email-steve.capper@linaro.org>
References: <1389866863-24460-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140218154549.GA28193@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 10:07:43AM +0000, Steve Capper wrote:
> The Coherant DMA allocator allocates pages of high order then splits
> them up into smaller pages.
> 
> This splitting logic would run into problems if the allocator was
> given compound pages. Thus the Coherant DMA allocator was originally
> incompatible with compound pages existing and, by extension, huge
> pages. A compile #error was put in place whenever huge pages were
> enabled.
> 
> Compatibility with compound pages has since been introduced by the
> following commit (which merely excludes GFP_COMP pages from being
> requested by the coherant DMA allocator):
>   ea2e705 ARM: 7172/1: dma: Drop GFP_COMP for DMA memory allocations
> 
> When huge page support was introduced to ARM, the compile #error in
> dma-mapping.c was replaced by a #warning when it should have been
> removed instead.
> 
> This patch removes the compile #warning in dma-mapping.c when huge
> pages are enabled.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
> Changed in V2: commit message completely re-written to give a better
> justification.
> ---
>  arch/arm/mm/dma-mapping.c | 3 ---
>  1 file changed, 3 deletions(-)

Would anyone object to this going into Russell's patch system?

Cheers,
-- 
Steve
