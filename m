From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Jul 2014 17:47:22 +0100
Subject: [PATCH v7 07/11] arm64: mm: Implement 4 levels of translation
 tables
In-Reply-To: <4A09B481-365B-4BEE-BCC2-FCA24B22CF96@gmail.com>
References: <2211E520-32A4-435C-9F63-A7EFEE8B677A@gmail.com>
 <4A09B481-365B-4BEE-BCC2-FCA24B22CF96@gmail.com>
Message-ID: <20140717164722.GK18203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 04:04:07PM +0100, Jungseok Lee wrote:
> On Wed, 16 Jul 2014 20:09:48 +0100, Catalin Marinas wrote:
> 
> [ ... ]
> 
> > diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
> > index 69000efa015e..fa324bd5a5c4 100644
> > --- a/arch/arm64/mm/ioremap.c
> > +++ b/arch/arm64/mm/ioremap.c
> > @@ -104,9 +104,12 @@ void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
> > EXPORT_SYMBOL(ioremap_cache);
> > 
> > static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
> > -#ifndef CONFIG_ARM64_64K_PAGES
> > +#if CONFIG_ARM64_PGTABLE_LEVELS > 2
> 
> In this patch frame, it causes a compile error since [08/11] patch introduces
> CONFIG_ARM64_PGTABLE_LEVELS. Please ignore my comment if it does not matter.

It matters, thanks.

-- 
Catalin
