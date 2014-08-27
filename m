From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Aug 2014 11:46:53 +0100
Subject: [PATH V2 2/6] arm: mm: Introduce special ptes for LPAE
In-Reply-To: <1408635812-31584-3-git-send-email-steve.capper@linaro.org>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-3-git-send-email-steve.capper@linaro.org>
Message-ID: <20140827104653.GG6968@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 04:43:28PM +0100, Steve Capper wrote:
> We need a mechanism to tag ptes as being special, this indicates that
> no attempt should be made to access the underlying struct page *
> associated with the pte. This is used by the fast_gup when operating on
> ptes as it has no means to access VMAs (that also contain this
> information) locklessly.
> 
> The L_PTE_SPECIAL bit is already allocated for LPAE, this patch modifies
> pte_special and pte_mkspecial to make use of it, and defines
> __HAVE_ARCH_PTE_SPECIAL.
> 
> This patch also excludes special ptes from the icache/dcache sync logic.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
