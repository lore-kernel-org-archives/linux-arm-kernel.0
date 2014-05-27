From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 27 May 2014 15:23:16 +0100
Subject: [PATCH v3 01/14] ARM: KVM: switch hypervisor into BE mode in
 case of BE host
In-Reply-To: <1399997646-4716-2-git-send-email-victor.kamensky@linaro.org>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
 <1399997646-4716-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <53849FD4.6060604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/05/14 17:13, Victor Kamensky wrote:
> Switch hypervisor to run in BE mode if image is compiled
> with CONFIG_CPU_BIG_ENDIAN.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm/kvm/init.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
> index 1b9844d..74f0718 100644
> --- a/arch/arm/kvm/init.S
> +++ b/arch/arm/kvm/init.S
> @@ -22,6 +22,7 @@
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_mmu.h>
> +#include <asm/assembler.h>
>  
>  /********************************************************************
>   * Hypervisor initialization
> @@ -70,6 +71,8 @@ __do_hyp_init:
>  	cmp	r0, #0			@ We have a SP?
>  	bne	phase2			@ Yes, second stage init
>  
> +ARM_BE8(setend	be) @ Switch to Big Endian mode if needed
> +
>  	@ Set the HTTBR to point to the hypervisor PGD pointer passed
>  	mcrr	p15, 4, r2, r3, c2
>  
> 

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
