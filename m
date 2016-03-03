From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Mar 2016 16:52:40 -0600
Subject: [PATCH] of: alloc anywhere from memblock if range not specified
In-Reply-To: <1456148744-7583-1-git-send-email-vinmenon@codeaurora.org>
References: <1456148744-7583-1-git-send-email-vinmenon@codeaurora.org>
Message-ID: <20160303225240.GA17541@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 07:15:44PM +0530, Vinayak Menon wrote:
> early_init_dt_alloc_reserved_memory_arch passes end as 0 to
> __memblock_alloc_base, when limits are not specified. But
> __memblock_alloc_base takes end value of 0 as MEMBLOCK_ALLOC_ACCESSIBLE
> and limits the end to memblock.current_limit. This results in regions
> never being placed in HIGHMEM area, for e.g. CMA.
> Let __memblock_alloc_base allocate from anywhere in memory if limits are
> not specified.
> 
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>

Applied and marked for stable.

Rob
