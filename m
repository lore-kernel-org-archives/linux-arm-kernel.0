From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Jun 2017 14:54:15 +0100
Subject: [PATCH] arm64: remove a redundancy in sysreg.h
In-Reply-To: <20170620133042.mlqgpx5vddgvoe6k@hello-penguin.com>
References: <20170620133042.mlqgpx5vddgvoe6k@hello-penguin.com>
Message-ID: <6d18962d-5557-1d57-95da-2ae1c437440b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/17 14:30, Stefan Traby wrote:
> This is really trivial; there is a dup
> (1 << 16) in the code
> 
> Signed-off-by: Stefan Traby <stefan@hello-penguin.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 2d3e155b185f..580965129fea 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -139,8 +139,8 @@
>  #define SCTLR_ELx_M	1
>  
>  #define SCTLR_EL2_RES1	((1 << 4)  | (1 << 5)  | (1 << 11) | (1 << 16) | \
> -			 (1 << 16) | (1 << 18) | (1 << 22) | (1 << 23) | \
> -			 (1 << 28) | (1 << 29))
> +			 (1 << 18) | (1 << 22) | (1 << 23) | (1 << 28) | \
> +			 (1 << 29))
>  
>  #define SCTLR_ELx_FLAGS	(SCTLR_ELx_M | SCTLR_ELx_A | SCTLR_ELx_C | \
>  			 SCTLR_ELx_SA | SCTLR_ELx_I)
> 

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Catalin, Will: do you want to get that through arm64? Alternatively, I
get stash it in the KVM tree.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
