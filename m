From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 2 May 2014 16:30:21 +0100
Subject: [PATCH 0/2] arm64: TLB flush issues
In-Reply-To: <1399044035-11274-1-git-send-email-msalter@redhat.com>
References: <1399044035-11274-1-git-send-email-msalter@redhat.com>
Message-ID: <20140502153019.GA9179@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 11:20:33AM -0400, Mark Salter wrote:
> As explained in more detail in the second patch, I have observed a soft
> lockup under some loads. These lockups were in flush_tlb_kernel_range()
> which was looping through a very large address range. While looking into
> this, I also noticed the flush routines in tlb.S were not properly
> handling pages larger than 4k. This is corrected in the first patch.
> The second patch limits the loop size for the flush_tlb_[kernel_]range
> functions. It uses an arbitrary constant to limit the loop, but it
> would be better if it were based on actual tlb size or some other
> heuristic.
> 
> Mark Salter (2):
>   arm64: fix unnecessary tlb flushes
>   arm64: fix soft lockup due to large tlb flush range
> 
>  arch/arm64/include/asm/tlbflush.h | 28 +++++++++++++++++++++++++---
>  arch/arm64/mm/tlb.S               |  4 ++--
>  2 files changed, 27 insertions(+), 5 deletions(-)
> 

Hi Mark,
As a heads-up, I posted this earlier today:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/252837.html

Cheers,
-- 
Steve
