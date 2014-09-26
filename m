From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Sep 2014 12:18:46 +0100
Subject: [PATCH] arm/arm64: KVM: Fix VTTBR_BADDR_MASK and pgd alloc
In-Reply-To: <1411669939-24648-1-git-send-email-christoffer.dall@linaro.org>
References: <1411669939-24648-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20140926111845.GA15654@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 07:32:19PM +0100, Christoffer Dall wrote:
> From: Joel Schopp <joel.schopp@amd.com>
> 
> The current aarch64 calculation for VTTBR_BADDR_MASK masks only 39 bits
> and not all the bits in the PA range. This is clearly a bug that
> manifests itself on systems that allocate memory in the higher address
> space range.
> 
>  [ Modified from Joel's original patch to be based on PHYS_MASK_SHIFT
>    instead of a hard-coded value and to move the alignment check of the
>    allocation to mmu.c.  Also added a comment explaining why we hardcode
>    the IPA range and changed the stage-2 pgd allocation to be based on
>    the 40 bit IPA range instead of the maximum possible 48 bit PA range.
>    - Christoffer ]
> 
> Signed-off-by: Joel Schopp <joel.schopp@amd.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
