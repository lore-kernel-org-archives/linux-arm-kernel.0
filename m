From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Aug 2014 15:27:07 +0100
Subject: [PATCHv4 1/2] arm64: Introduce {set,clear}_pte_bit
In-Reply-To: <1408477303-2640-2-git-send-email-lauraa@codeaurora.org>
References: <1408477303-2640-1-git-send-email-lauraa@codeaurora.org>
 <1408477303-2640-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140826142707.GF16482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 08:41:42PM +0100, Laura Abbott wrote:
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index ffe1ba0..ca41449 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -149,46 +149,51 @@ extern struct page *empty_zero_page;
>  #define pte_valid_not_user(pte) \
>  	((pte_val(pte) & (PTE_VALID | PTE_USER)) == PTE_VALID)
>  
> -static inline pte_t pte_wrprotect(pte_t pte)
> +static pte_t clear_pte_bit(pte_t pte, pgprot_t prot)
>  {
> -	pte_val(pte) &= ~PTE_WRITE;
> +	pte_val(pte) &= ~pgprot_val(prot);
>  	return pte;
>  }
>  
> -static inline pte_t pte_mkwrite(pte_t pte)
> +static pte_t set_pte_bit(pte_t pte, pgprot_t prot)
>  {
> -	pte_val(pte) |= PTE_WRITE;
> +	pte_val(pte) |= pgprot_val(prot);
>  	return pte;
>  }

Why these two functions don't have an "inline"?

-- 
Catalin
