From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Oct 2015 15:23:27 +0100
Subject: [RFC] arm64: ioremap: add ioremap_cache macro
In-Reply-To: <20151013141055.GC11573@e104818-lin.cambridge.arm.com>
References: <1444616898-5057-1-git-send-email-yalin.wang2010@gmail.com>
 <20151013141055.GC11573@e104818-lin.cambridge.arm.com>
Message-ID: <20151013142326.GM21550@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 03:10:55PM +0100, Catalin Marinas wrote:
> On Mon, Oct 12, 2015 at 10:28:18AM +0800, yalin wang wrote:
> > Add ioremap_cache macro, because some code will test if this macro
> > is defined or not, and will generate a generric version if not defined,
> > for example, memremap.c do like this.
> > 
> > Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> > ---
> >  arch/arm64/include/asm/io.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> > index 44be1e0..d6b620c 100644
> > --- a/arch/arm64/include/asm/io.h
> > +++ b/arch/arm64/include/asm/io.h
> > @@ -172,6 +172,7 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
> >  #define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
> >  #define ioremap_wt(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
> >  #define iounmap				__iounmap
> > +#define ioremap_cache                  ioremap_cache
> 
> Applied. Thanks.

I'm not sure we want this. See:

  https://lkml.org/lkml/2015/10/9/699

Will
