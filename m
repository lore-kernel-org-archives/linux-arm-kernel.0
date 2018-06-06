From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Jun 2018 16:44:42 +0100
Subject: [PATCH v13 2/3] arm64: tlbflush: Introduce
 __flush_tlb_kernel_pgtable
In-Reply-To: <1528268481-19299-3-git-send-email-cpandya@codeaurora.org>
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
 <1528268481-19299-3-git-send-email-cpandya@codeaurora.org>
Message-ID: <20180606154442.GF6631@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2018 at 12:31:20PM +0530, Chintan Pandya wrote:
> Add an interface to invalidate intermediate page tables
> from TLB for kernel.
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/include/asm/tlbflush.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index dfc61d7..a4a1901 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -218,6 +218,13 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
>  	dsb(ish);
>  }
>  
> +static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
> +{
> +	unsigned long addr = __TLBI_VADDR(kaddr, 0);
> +
> +	__tlbi(vaae1is, addr);
> +	dsb(ish);
> +}
>  #endif

Acked-by: Will Deacon <will.deacon@arm.com>

Will
