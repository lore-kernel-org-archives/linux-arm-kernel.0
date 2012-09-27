From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Sep 2012 23:27:11 +0100
Subject: [GIT PULL] ARM: cache flushing LoUIS API
In-Reply-To: <20120927161552.GA5001@e102568-lin.cambridge.arm.com>
References: <20120925125758.GA16842@e102568-lin.cambridge.arm.com>
 <20120927114805.GC14358@n2100.arm.linux.org.uk>
 <20120927161552.GA5001@e102568-lin.cambridge.arm.com>
Message-ID: <20120927222711.GA7916@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 05:15:52PM +0100, Lorenzo Pieralisi wrote:
> Russell,
> 
> Do you think it is sufficient/proper or you see other issues ?
> 
> If it is ok I can fold it into the series and prepare a new pull request.

Looks fine to me.

> 
> Thanks a lot for your help and sorry again.
> Lorenzo
> 
> -- >8 --
> Subject: [PATCH] ARM: mm: fix cache LoUIS API for xscale and feroceon
> 
> Some architectures like xscale and feroceon have cache API variants that
> map cache flushing functions as aliases to the base architecture.
> This patch adds the required aliases to complete the implementation of
> cache flushing LoUIS API.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm/mm/proc-feroceon.S | 1 +
>  arch/arm/mm/proc-xscale.S   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
> index 85e5e3b..4106b09 100644
> --- a/arch/arm/mm/proc-feroceon.S
> +++ b/arch/arm/mm/proc-feroceon.S
> @@ -434,6 +434,7 @@ ENDPROC(feroceon_dma_unmap_area)
>  	range_alias flush_icache_all
>  	range_alias flush_user_cache_all
>  	range_alias flush_kern_cache_all
> +	range_alias flush_kern_cache_louis
>  	range_alias flush_user_cache_range
>  	range_alias coherent_kern_range
>  	range_alias coherent_user_range
> diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
> index b5ea31d..2551036 100644
> --- a/arch/arm/mm/proc-xscale.S
> +++ b/arch/arm/mm/proc-xscale.S
> @@ -442,6 +442,7 @@ ENDPROC(xscale_dma_unmap_area)
>  	a0_alias flush_icache_all
>  	a0_alias flush_user_cache_all
>  	a0_alias flush_kern_cache_all
> +	a0_alias flush_kern_cache_louis
>  	a0_alias flush_user_cache_range
>  	a0_alias coherent_kern_range
>  	a0_alias coherent_user_range
> -- 
> 1.7.12
> 
> 
