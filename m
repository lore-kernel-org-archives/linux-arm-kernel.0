From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 16 Nov 2011 12:20:25 -0500 (EST)
Subject: [PATCH] ARM: Use PMD_SHIFT instead of PGDIR_SHIFT in
 dma-consistent.c
In-Reply-To: <1321461495-2860-1-git-send-email-catalin.marinas@arm.com>
References: <1321461495-2860-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <alpine.LFD.2.02.1111161219520.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Nov 2011, Catalin Marinas wrote:

> Commit 99d1717d introduces dynamic allocation of the consistent_pte
> array. The number of PTEs should be calculated based on the number of
> PMD entries rather than PGD, hence the PMD_SHIFT.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jon Medhurst <tixy@yxit.co.uk>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/mm/dma-mapping.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index e4e7f6c..ab58456 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -168,7 +168,7 @@ static int __init consistent_init(void)
>  	pte_t *pte;
>  	int i = 0;
>  	unsigned long base = consistent_base;
> -	unsigned long num_ptes = (CONSISTENT_END - base) >> PGDIR_SHIFT;
> +	unsigned long num_ptes = (CONSISTENT_END - base) >> PMD_SHIFT;
>  
>  	consistent_pte = kmalloc(num_ptes * sizeof(pte_t), GFP_KERNEL);
>  	if (!consistent_pte) {
> 
