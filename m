From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 May 2013 11:59:58 +0100
Subject: [PATCH v2 1/4] ARM: mm: correct pte_same behaviour for LPAE.
In-Reply-To: <1369323080-9673-2-git-send-email-steve.capper@linaro.org>
References: <1369323080-9673-1-git-send-email-steve.capper@linaro.org>
 <1369323080-9673-2-git-send-email-steve.capper@linaro.org>
Message-ID: <20130524105958.GA18272@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 04:31:17PM +0100, Steve Capper wrote:
> For 3 levels of paging the PTE_EXT_NG bit will be set for user
> address ptes that are written to a page table but not for ptes
> created with mk_pte.
> 
> This can cause some comparison tests made by pte_same to fail
> spuriously and lead to other problems.
> 
> To correct this behaviour, we mask off PTE_EXT_NG for any pte that
> is present before running the comparison.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> Reviewed-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
