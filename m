From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 5 Jan 2015 15:32:47 +0100
Subject: [PATCH] arch: arm: mm: cache-feroceon-l2: Remove some unused
 functions
In-Reply-To: <1420134969-1892-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1420134969-1892-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <20150105143247.GD9142@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 01, 2015 at 06:56:09PM +0100, Rickard Strandqvist wrote:
> Removes some functions that are not used anywhere:
> l2_inv_pa() l2_clean_pa()
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>


Acked-by: Andrew Lunn <andrew@lunn.ch>

Please could you submit this to Russell Kings patch tracker.

Thanks
	Andrew

> ---
>  arch/arm/mm/cache-feroceon-l2.c |   10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
> index e028a7f..c2eac97 100644
> --- a/arch/arm/mm/cache-feroceon-l2.c
> +++ b/arch/arm/mm/cache-feroceon-l2.c
> @@ -65,11 +65,6 @@ static inline void l2_put_va(unsigned long vaddr)
>  #endif
>  }
>  
> -static inline void l2_clean_pa(unsigned long addr)
> -{
> -	__asm__("mcr p15, 1, %0, c15, c9, 3" : : "r" (addr));
> -}
> -
>  static inline void l2_clean_pa_range(unsigned long start, unsigned long end)
>  {
>  	unsigned long va_start, va_end, flags;
> @@ -96,11 +91,6 @@ static inline void l2_clean_inv_pa(unsigned long addr)
>  	__asm__("mcr p15, 1, %0, c15, c10, 3" : : "r" (addr));
>  }
>  
> -static inline void l2_inv_pa(unsigned long addr)
> -{
> -	__asm__("mcr p15, 1, %0, c15, c11, 3" : : "r" (addr));
> -}
> -
>  static inline void l2_inv_pa_range(unsigned long start, unsigned long end)
>  {
>  	unsigned long va_start, va_end, flags;
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
