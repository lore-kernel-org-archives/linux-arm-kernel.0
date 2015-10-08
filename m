From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 8 Oct 2015 17:17:46 +0200
Subject: [PATCH 10/15] arm64: kvm: Fix {V}TCR_EL2_TG0 mask
In-Reply-To: <1442331684-28818-11-git-send-email-suzuki.poulose@arm.com>
References: <1442331684-28818-1-git-send-email-suzuki.poulose@arm.com>
 <1442331684-28818-11-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151008151746.GE20936@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 04:41:19PM +0100, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> {V}TCR_EL2_TG0 is a 2bit wide field, where:
> 
>  00 - 4K
>  01 - 64K
>  10 - 16K
> 
> But we use only 1 bit, which has worked well so far since
> we never cared about 16K. Fix it for 16K support.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: kvmarm at lists.cs.columbia.edu
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 7605e09..bdf139e 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -98,7 +98,7 @@
>  #define TCR_EL2_TBI	(1 << 20)
>  #define TCR_EL2_PS	(7 << 16)
>  #define TCR_EL2_PS_40B	(2 << 16)
> -#define TCR_EL2_TG0	(1 << 14)
> +#define TCR_EL2_TG0	(3 << 14)
>  #define TCR_EL2_SH0	(3 << 12)
>  #define TCR_EL2_ORGN0	(3 << 10)
>  #define TCR_EL2_IRGN0	(3 << 8)
> @@ -110,7 +110,7 @@
>  
>  /* VTCR_EL2 Registers bits */
>  #define VTCR_EL2_PS_MASK	(7 << 16)
> -#define VTCR_EL2_TG0_MASK	(1 << 14)
> +#define VTCR_EL2_TG0_MASK	(3 << 14)
>  #define VTCR_EL2_TG0_4K		(0 << 14)
>  #define VTCR_EL2_TG0_64K	(1 << 14)
>  #define VTCR_EL2_SH0_MASK	(3 << 12)
> -- 
> 1.7.9.5
> 

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
