From: yalin.wang2010@gmail.com (yalin wang)
Date: Tue, 1 Sep 2015 10:00:04 +0800
Subject: [PATCH] arm64: add kc_offset_to_vaddr and kc_vaddr_to_offset macro
In-Reply-To: <1440915599-18485-1-git-send-email-yalin.wang2010@gmail.com>
References: <1440915599-18485-1-git-send-email-yalin.wang2010@gmail.com>
Message-ID: <385BEB9B-288F-4898-8728-CC4948DF0907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping ?
> On Aug 30, 2015, at 14:19, yalin wang <yalin.wang2010@gmail.com> wrote:
> 
> This patch add kc_offset_to_vaddr() and kc_vaddr_to_offset(),
> the default version doesn't work on arm64, because arm64 kernel address
> is below the PAGE_OFFSET, like module address and vmemmap address are
> all below PAGE_OFFSET address.
> 
> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> ---
> arch/arm64/include/asm/pgtable.h | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index d374191..ef1ed5c 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -660,6 +660,8 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
> 
> #define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
> 
> +#define	kc_vaddr_to_offset(v) ((v) & ((1UL << VA_BITS) - 1))
> +#define	kc_offset_to_vaddr(o) ((o) | ~((1UL << VA_BITS) - 1))
> #endif /* !__ASSEMBLY__ */
> 
> #endif /* __ASM_PGTABLE_H */
> -- 
> 1.9.1
> 
