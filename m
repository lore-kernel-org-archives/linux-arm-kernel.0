From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 15 Nov 2013 00:09:17 +0000
Subject: [PATCH 5/6] ARM: kvm: Use phys_addr_t instead of unsigned long
 in mm code
In-Reply-To: <1384457866-16135-6-git-send-email-santosh.shilimkar@ti.com>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-6-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131115000917.GB20516@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 02:37:45PM -0500, Santosh Shilimkar wrote:
> The unsigned long datatype is not sufficient for mapping physical addresses
> greater than 4GB.
> 
> So fix the KVM mm code accordingly. Special thanks to Christopher for debug
> help to figure out the bug.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/kvm/mmu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 3bd652f..657f15e 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -318,7 +318,7 @@ out:
>   */
>  int create_hyp_mappings(void *from, void *to)
>  {
> -	unsigned long phys_addr = virt_to_phys(from);
> +	phys_addr_t phys_addr = virt_to_phys(from);
>  	unsigned long start = KERN_TO_HYP((unsigned long)from);
>  	unsigned long end = KERN_TO_HYP((unsigned long)to);
>  
> -- 
> 1.7.9.5
> 

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

I can just apply this to kvm-arm-next immediately, or we can wait and
pull it in with your series if you prefer.  Let me know.

-Christoffer
