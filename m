From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 25 Jun 2015 12:33:18 -0400 (EDT)
Subject: [PATCH] ARM: use phys_addr_t in pfn_to_kaddr()
In-Reply-To: <558B0388.1040006@oracle.com>
References: <1435072386-13527-1-git-send-email-vitalya@ti.com>
 <558B0388.1040006@oracle.com>
Message-ID: <alpine.LFD.2.11.1506251232050.2617@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Jun 2015, santosh shilimkar wrote:

> On 6/23/2015 8:13 AM, Vitaly Andrianov wrote:
> > This patch fixes pfn_to_kaddr() to use phys_addr_t.  Without this,
> > this macro is broken on LPAE systems. For physical addresses above
> > first 4GB result of shifting pfn with PAGE_SHIFT may be truncated.
> >
> > Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> > ---
> Looks a valid fix.
> 
> RMK, Nico, what you say ?

Looks fine to me.

Acked-by: Nicolas Pitre <nico@linaro.org>


> 
> >   arch/arm/include/asm/memory.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> > index 184def0..063ef31 100644
> > --- a/arch/arm/include/asm/memory.h
> > +++ b/arch/arm/include/asm/memory.h
> > @@ -291,7 +291,7 @@ static inline void *phys_to_virt(phys_addr_t x)
> >   */
> >   #define __pa(x)			__virt_to_phys((unsigned long)(x))
> >   #define __va(x)			((void
> >   *)__phys_to_virt((phys_addr_t)(x)))
> > -#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
> > +#define pfn_to_kaddr(pfn)	__va((phys_addr_t)(pfn) << PAGE_SHIFT)
> >
> >   extern phys_addr_t (*arch_virt_to_idmap)(unsigned long x);
> >
> >
> 
> 
