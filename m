From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 May 2018 10:21:34 +0100
Subject: [PATCH 1/3] arm64:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
In-Reply-To: <20180528033353.54725-1-nixiaoming@huawei.com>
References: <20180528033353.54725-1-nixiaoming@huawei.com>
Message-ID: <20180529092133.GA6533@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, May 28, 2018 at 11:33:53AM +0800, nixiaoming wrote:
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>

Please can you write a commit message explaining what this fixes and also
give me a pointer to patches 2 and 3 from this series?

Will

> ---
>  arch/arm64/mm/mmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 2dbb2c9..849f326 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -491,6 +491,7 @@ static void __init map_mem(pgd_t *pgdp)
>  #endif
>  }
>  
> +#ifdef CONFIG_STRICT_KERNEL_RWX
>  void mark_rodata_ro(void)
>  {
>  	unsigned long section_size;
> @@ -505,6 +506,7 @@ void mark_rodata_ro(void)
>  
>  	debug_checkwx();
>  }
> +#endif
>  
>  static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
>  				      pgprot_t prot, struct vm_struct *vma,
> -- 
> 2.10.1
> 
