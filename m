From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 12 Feb 2014 09:43:39 +0000
Subject: [PATCH 0/3] arm64: Use pte manipulation functions for THP
In-Reply-To: <1391696171-8922-1-git-send-email-steve.capper@linaro.org>
References: <1391696171-8922-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140212094338.GA11325@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 02:16:08PM +0000, Steve Capper wrote:
> This series replaces the Transparent HugePage pmd manipulation
> functions with calls to the standard pte functions. This allows the THP
> code to take advantage of the new PTE_WRITE logic, and provides better
> parity with the HugeTLB code (which already uses the pte functions).
> 
> Testing was done on the Fast Model with LTP THP tests, and the 3.14-rc1
> kernel was used.

Hi,
Does this series look reasonable?

Thanks,
-- 
Steve

> 
> Steve Capper (3):
>   arm64: mm: Remove PMD_BIT_FUNC macro
>   arm64: mm: Route pmd thp functions through pte equivalents
>   arm64: mm: Correct definition of pmd_mknotpresent
> 
>  arch/arm64/include/asm/pgtable.h | 91 +++++++++++++++++++++++++++-------------
>  1 file changed, 62 insertions(+), 29 deletions(-)
> 
> -- 
> 1.8.1.4
> 
