From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Fri, 16 Nov 2018 23:44:07 +0100
Subject: [PATCH v2] arm64: sysreg: fix sparse warnings
In-Reply-To: <20181116182130.4327-1-geomatsi@gmail.com>
References: <20181116182130.4327-1-geomatsi@gmail.com>
Message-ID: <20181116224406.3i6qmzknda7rml2l@ltop.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 09:21:30PM +0300, Sergey Matyukevich wrote:
> Specify correct type for the constants to avoid
> the following sparse complaints:
> 
> ./arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> ./arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> 
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
> 
> Changes v1 -> v2
>   - use proper type: UL rather than ULL
> 
>  arch/arm64/include/asm/sysreg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 0c909c4a932f..842fb9572661 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -468,7 +468,7 @@
>  			 SCTLR_ELx_SA     | SCTLR_ELx_I    | SCTLR_ELx_WXN | \
>  			 SCTLR_ELx_DSSBS | ENDIAN_CLEAR_EL2 | SCTLR_EL2_RES0)
>  
> -#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffffffffffff
> +#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffffffffffffUL
>  #error "Inconsistent SCTLR_EL2 set/clear bits"
>  #endif
>  
> @@ -509,7 +509,7 @@
>  			 SCTLR_EL1_UMA | SCTLR_ELx_WXN     | ENDIAN_CLEAR_EL1 |\
>  			 SCTLR_ELx_DSSBS | SCTLR_EL1_NTWI  | SCTLR_EL1_RES0)
>  
> -#if (SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != 0xffffffffffffffff
> +#if (SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != 0xffffffffffffffffUL
>  #error "Inconsistent SCTLR_EL1 set/clear bits"
>  #endif

Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

I would also be fine with '!= ~0UL' which is, to me, slightly more
readeable (must not count the fs to know if it's all bits or not).


Regards,
-- Luc
