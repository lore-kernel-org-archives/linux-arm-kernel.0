From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 27 Aug 2014 13:52:21 +0100
Subject: [PATH V2 2/6] arm: mm: Introduce special ptes for LPAE
In-Reply-To: <20140827104653.GG6968@arm.com>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-3-git-send-email-steve.capper@linaro.org>
 <20140827104653.GG6968@arm.com>
Message-ID: <20140827125220.GB7765@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 11:46:53AM +0100, Catalin Marinas wrote:
> On Thu, Aug 21, 2014 at 04:43:28PM +0100, Steve Capper wrote:
> > We need a mechanism to tag ptes as being special, this indicates that
> > no attempt should be made to access the underlying struct page *
> > associated with the pte. This is used by the fast_gup when operating on
> > ptes as it has no means to access VMAs (that also contain this
> > information) locklessly.
> > 
> > The L_PTE_SPECIAL bit is already allocated for LPAE, this patch modifies
> > pte_special and pte_mkspecial to make use of it, and defines
> > __HAVE_ARCH_PTE_SPECIAL.
> > 
> > This patch also excludes special ptes from the icache/dcache sync logic.
> > 
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks Catalin,
I've added this to the patch.
-- 
Steve

> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
