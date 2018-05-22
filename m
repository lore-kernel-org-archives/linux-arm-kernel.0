From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 May 2018 18:17:44 +0100
Subject: [PATCH 2/2] arm64: Unify kernel fault reporting
In-Reply-To: <20180521131451.41040-3-mark.rutland@arm.com>
References: <20180521131451.41040-1-mark.rutland@arm.com>
 <20180521131451.41040-3-mark.rutland@arm.com>
Message-ID: <20180522171743.GI26955@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 02:14:51PM +0100, Mark Rutland wrote:
> In do_page_fault(), we handle some kernel faults early, and simply
> die() with a message. For faults handled later, we dump the faulting
> address, decode the ESR, walk the page tables, and perform a number of
> steps to ensure that this data is reported.
> 
> Let's unify the handling of fatal kernel faults with a new
> die_kernel_fault() helper, handling all of these details. This is
> largely the same as the existing logic in __do_kernel_fault(), except
> that addresses are consistently padded to 16 hex characters, as would be
> expected for a 64-bit address.
> 
> The messages currently logged in do_page_fault are adjusted to fit into
> the die_kernel_fault() message template.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/mm/fault.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
