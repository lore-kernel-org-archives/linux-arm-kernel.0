From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Feb 2013 14:43:56 +0000
Subject: [PATCH] arm: Preserve L_PTE_VALID in pte_modify()
In-Reply-To: <20130218162150.GI20798@mudshark.cambridge.arm.com>
References: <1360693550-31609-1-git-send-email-catalin.marinas@arm.com>
 <20130218162150.GI20798@mudshark.cambridge.arm.com>
Message-ID: <20130225144355.GD25276@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Mon, Feb 18, 2013 at 04:21:50PM +0000, Will Deacon wrote:
> On Tue, Feb 12, 2013 at 06:25:50PM +0000, Catalin Marinas wrote:
> > Following commit 26ffd0d4 (ARM: mm: introduce present, faulting entries
> > for PAGE_NONE), if a page has been mapped as PROT_NONE, the L_PTE_VALID
> > bit is cleared by the set_pte_ext() code. With LPAE the software and
> > hardware pte share the same location and subsequent modifications of pte
> > range (change_protection()) will leave the L_PTE_VALID bit cleared.
> > 
> > This patch adds the L_PTE_VALID bit to the newprot mask in pte_modify().
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Reported-by: Subash Patel <subash.rp@samsung.com>
> > Tested-by: Subash Patel <subash.rp@samsung.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> 
> This matches what I did for arm64, so:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>

Can you put this into the patch system please?

Cheers,

Will
