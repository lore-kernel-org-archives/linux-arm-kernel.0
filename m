From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 27 Mar 2014 15:11:30 +0000
Subject: [PATCH V2] mm: hugetlb: Introduce huge_pte_{page,present,young}
In-Reply-To: <1395321473-1257-1-git-send-email-steve.capper@linaro.org>
References: <1395321473-1257-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140327151129.GA5117@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 01:17:53PM +0000, Steve Capper wrote:
> Introduce huge pte versions of pte_page, pte_present and pte_young.
> 
> This allows ARM (without LPAE) to use alternative pte processing logic
> for huge ptes.
> 
> Generic implementations that call the standard pte versions are also
> added to asm-generic/hugetlb.h.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
> Changed in V2 - moved from #ifndef,#define macros to entries in
> asm-generic/hugetlb.h as it makes more sense to have these with the
> other huge_pte_. definitions.
> 
> The only other architecture I can see that does not use
> asm-generic/hugetlb.h is s390. This patch includes trivial definitions
> for huge_pte_{page,present,young} for s390.
> 
> I've compile-tested this for s390, but don't have one under my desk so
> have not been able to test it.
> ---
>  arch/s390/include/asm/hugetlb.h | 15 +++++++++++++++
>  include/asm-generic/hugetlb.h   | 15 +++++++++++++++
>  mm/hugetlb.c                    | 22 +++++++++++-----------
>  3 files changed, 41 insertions(+), 11 deletions(-)
> 

Hello,
I was just wondering if this patch looked reasonable to people?

Cheers,
-- 
Steve
