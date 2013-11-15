From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 15 Nov 2013 00:11:15 +0000
Subject: [PATCH 6/6] ARM: kvm: TMP: Commit the hyp page tables to main
 memory
In-Reply-To: <1384457866-16135-7-git-send-email-santosh.shilimkar@ti.com>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-7-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131115001115.GC20516@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 02:37:46PM -0500, Santosh Shilimkar wrote:
> This is a temporary hack which I have to use to avoid a weired crash while
> starting the guest OS on Keystsone. They are random crashesh while the
> guest os userspace starts. Additional data point is, it seen only with first
> guest OS lanch. Subsequest guest OS starts normal.
>     

what crashes?  The guest?  Where, how?


> I still don't know why this is needed but it helps to get around the issue
> and hence including the patch in the series for the discussion

It may not be needed but is just hiding the issue.  I'm afraid you're
going to have to dig a little more into this.

-Christoffer

> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
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
> -- 
> 1.7.9.5
> 
