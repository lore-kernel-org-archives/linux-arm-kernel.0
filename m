From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Jun 2013 17:25:59 +0100
Subject: [RFC 2/3] arm: mm: Define set_memory_* functions for ARM
In-Reply-To: <1371057810-3189-3-git-send-email-lauraa@codeaurora.org>
References: <1371057810-3189-1-git-send-email-lauraa@codeaurora.org>
 <1371057810-3189-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <20130613162559.GC9609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 06:23:29PM +0100, Laura Abbott wrote:
> +int set_memory_ro(unsigned long addr, int numpages)
> +{
> +	unsigned long start = addr;
> +	unsigned long size = PAGE_SIZE*numpages;
> +	unsigned end = start + size;
> +
> +	apply_to_page_range(&init_mm, start, size, pte_set_ro, NULL);
> +	dsb();
> +	flush_tlb_kernel_range(start, end);

I think flush_tlb_kernel_range() already has a DSB.

-- 
Catalin
