From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 14 Apr 2016 15:23:45 +0100
Subject: [PATCH v2 08/17] kvm-arm: arm: Introduce hyp page table empty
 checks
In-Reply-To: <1460640065-27658-9-git-send-email-suzuki.poulose@arm.com>
References: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
 <1460640065-27658-9-git-send-email-suzuki.poulose@arm.com>
Message-ID: <570FA7F1.7090403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/16 14:20, Suzuki K Poulose wrote:
> Introduce hyp_pxx_table_empty helpers for checking whether
> a given table entry is empty. This will be used explicitly
> once we switch to explicit routines for hyp page table walk.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm/include/asm/kvm_mmu.h |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 7d207b4..901c1ea 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -162,6 +162,10 @@ static inline bool kvm_page_empty(void *ptr)
>  #define kvm_pmd_table_empty(kvm, pmdp) kvm_page_empty(pmdp)
>  #define kvm_pud_table_empty(kvm, pudp) (0)
>  
> +#define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
> +#define hyp_pmd_table_empty(pmdp) kvm_page_empty(pmdp)
> +#define hyp_pud_table_empty(pudp) (0)
> +
>  static inline void *kvm_get_hwpgd(struct kvm *kvm)
>  {
>  	return kvm->arch.pgd;
> 

Same remarks as the previous patch, but nonetheless:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
