From: toshi.kani@hpe.com (Kani, Toshi)
Date: Tue, 20 Mar 2018 22:58:18 +0000
Subject: [PATCH v4 1/3] ioremap: Update pgtable free interfaces with addr
In-Reply-To: <1521546314-31753-2-git-send-email-cpandya@codeaurora.org>
References: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
 <1521546314-31753-2-git-send-email-cpandya@codeaurora.org>
Message-ID: <1521586688.2693.231.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-03-20 at 17:15 +0530, Chintan Pandya wrote:
> This patch ("mm/vmalloc: Add interfaces to free unmapped
> page table") adds following 2 interfaces to free the page
> table in case we implement huge mapping.
> 
> pud_free_pmd_page() and pmd_free_pte_page()
> 
> Some architectures (like arm64) needs to do proper TLB
> maintanance after updating pagetable entry even in map.
> Why ? Read this,
> https://patchwork.kernel.org/patch/10134581/
> 
> Pass 'addr' in these interfaces so that proper TLB ops
> can be performed.
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>

Thanks for the update.  The change looks good.

Reviewed-by: Toshi Kani <toshi.kani@hpe.com>

-Toshi
