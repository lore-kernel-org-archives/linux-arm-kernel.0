From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 22 Jun 2018 11:46:44 +0100
Subject: [PATCH v2 2/4] arm64: Remove unnecessary ISBs from
 set_{pte,pmd,pud}
In-Reply-To: <1529656278-878-3-git-send-email-will.deacon@arm.com>
References: <1529656278-878-1-git-send-email-will.deacon@arm.com>
 <1529656278-878-3-git-send-email-will.deacon@arm.com>
Message-ID: <20180622104643.ohygdrln3ali3hqs@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Apologies for getting to this late]

Hi Will,

On Fri, Jun 22, 2018 at 09:31:16AM +0100, Will Deacon wrote:
> Commit 7f0b1bf04511 ("arm64: Fix barriers used for page table modifications")
> fixed a reported issue with fixmap page-table entries not being visible
> to the walker due to a missing DSB instruction. At the same time, it added
> ISB instructions to the arm64 set_{pte,pmd,pud} functions, which are not
> required by the architecture and make little sense in isolation.
> 
> Remove the redundant ISBs.
> 

I agree, we don't want to update any cached local execution context
information whilst setting page table entries and TLB maintenance is
handled elsewhere; so the ISBs are redundant.

FWIW: Acked-by: Steve Capper <steve.capper@linaro.org>

Cheers,
-- 
Steve
