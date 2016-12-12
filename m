From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 12 Dec 2016 11:02:15 +0000
Subject: [PATCH 1/1] Fixed checkpatch error to mmu.c
In-Reply-To: <962731481539605@web19g.yandex.ru>
References: <962731481539605@web19g.yandex.ru>
Message-ID: <2f7d41cd-bf48-129d-aa91-d464fd6ce671@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ozgur,

On 12/12/16 10:46, Ozgur Karatas wrote:
> Hello all,
> 
> I tested to mmu.c and I have fixed to some errors.
> 
> mmu.c:510: ERROR: "(foo*)" should be "(foo *)"
> 
> Signed-off-by: Ozgur Karatas <okaratas@member.fsf.org>
> ---
> arch/arm/kvm/mmu.c                       |  2 +-
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index a5265ed..a83cf47 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -507,7 +507,7 @@ void free_hyp_pgds(void)
>  		unmap_hyp_range(hyp_pgd, hyp_idmap_start, PAGE_SIZE);
>  		for (addr = PAGE_OFFSET; virt_addr_valid(addr); addr += PGDIR_SIZE)
>  			unmap_hyp_range(hyp_pgd, kern_hyp_va(addr), PGDIR_SIZE);
> -		for (addr = VMALLOC_START; is_vmalloc_addr((void*)addr); addr += PGDIR_SIZE)
> +		for (addr = VMALLOC_START; is_vmalloc_addr((void *)addr); addr += PGDIR_SIZE)
>  			unmap_hyp_range(hyp_pgd, kern_hyp_va(addr), PGDIR_SIZE);
> 

I'm not overly sympathetic to pure checkpatch patches. If you find
something that is a functional bug in that file, I'll consider it as
part of a series. But on its own, this is just noise.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
