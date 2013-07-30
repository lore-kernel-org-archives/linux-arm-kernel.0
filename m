From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 29 Jul 2013 20:49:45 -0700
Subject: [PATCH] ARM64: include: asm: use 'int' instead of 'u32' for
 variable 'target' in kvm_host.h.
In-Reply-To: <51ECA9B6.3010808@asianux.com>
References: <51ECA9B6.3010808@asianux.com>
Message-ID: <20130730034945.GD5471@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 11:40:38AM +0800, Chen Gang wrote:
> 'target' will be set to '-1' in kvm_arch_vcpu_init(), and it need check
> 'target' whether less than zero or not in kvm_vcpu_initialized().
> 
> So need define target as 'int' instead of 'u32', just like ARM has done.
> 
> 
> The related warning:
> 
>   arch/arm64/kvm/../../../arch/arm/kvm/arm.c:497:2: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 644d739..0859a4d 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -129,7 +129,7 @@ struct kvm_vcpu_arch {
>  	struct kvm_mmu_memory_cache mmu_page_cache;
>  
>  	/* Target CPU and feature flags */
> -	u32 target;
> +	int target;
>  	DECLARE_BITMAP(features, KVM_VCPU_MAX_FEATURES);
>  
>  	/* Detect first run of a vcpu */
> -- 
> 1.7.7.6

This looks ok to me, Marc, was there any reason to declare target a u32
on arm64?

-Christoffer
