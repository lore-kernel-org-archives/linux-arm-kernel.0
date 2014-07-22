From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Jul 2014 16:37:39 +0100
Subject: [PATCH 13/11] arm64: Add support for 48-bit VA space with 64KB
 page configuration
In-Reply-To: <2C360BFC-E4CF-448D-9110-4197DCAEAD4F@gmail.com>
References: <ADA477FA-165D-4679-A38F-C82C901BEE4D@gmail.com>
 <AABDB416-D194-4825-8113-4748C10BC339@gmail.com>
 <2C360BFC-E4CF-448D-9110-4197DCAEAD4F@gmail.com>
Message-ID: <20140722153738.GJ2219@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 04:13:27PM +0100, Jungseok Lee wrote:
> On Jul 22, 2014, at 00:09 +900 Catalin Marinas wrote:
> > This patch allows support for 3 levels of page tables with 64KB page 
> > configuration allowing 48-bit VA space. The pgd is no longer a full 
> > PAGE_SIZE (PTRS_PER_PGD is 64) and (swapper|idmap)_pg_dir are not fully 
> > populated (pgd_alloc falls back to kzalloc). 
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com> 
> > --- 
> 
> One more step :)

The last before the upcoming merging window. I also updated the
pgtable-4levels branch with the latest.

> Are you going to post the next version of this series including [12/11]
> and [13/11] or finalize the series?

I wasn't planning to post another series. It's good to get the clean-up
merged with the change that 48-bit VA now depends on BROKEN until KVM is
sorted (for 3.18).

> In addition, could you put my gmail address in CC in coming patch or
> the next version? It help me follow up the series easily.

Do you want me to add any reviewed etc. tags from you?

-- 
Catalin
