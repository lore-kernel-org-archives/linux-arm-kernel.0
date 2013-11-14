From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 14 Nov 2013 17:36:11 -0500
Subject: [PATCH 6/6] ARM: kvm: TMP: Commit the hyp page tables to main
 memory
In-Reply-To: <1384457866-16135-7-git-send-email-santosh.shilimkar@ti.com>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-7-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <5285505B.9080108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 November 2013 02:37 PM, Santosh Shilimkar wrote:
> This is a temporary hack which I have to use to avoid a weired crash while
> starting the guest OS on Keystsone. They are random crashesh while the
> guest os userspace starts. Additional data point is, it seen only with first
> guest OS lanch. Subsequest guest OS starts normal.
>     
> I still don't know why this is needed but it helps to get around the issue
> and hence including the patch in the series for the discussion
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---

Ignore this patch. I thought it helps but in more testing I found
that issue still comes up even with the below change. 

>  arch/arm/kvm/mmu.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 657f15e..5f6f460 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -826,6 +826,7 @@ int kvm_mmu_init(void)
>  		goto out;
>  	}
>  
> +	flush_cache_all();
>  	return 0;
>  out:
>  	free_hyp_pgds();
> 
