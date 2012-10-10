From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Oct 2012 18:39:57 +0000
Subject: [RFC PATCH] arm: vt8500: Convert irq.c for multiplatform
 integration
In-Reply-To: <1349891673.22215.2.camel@gitbox>
References: <1349856509-20480-1-git-send-email-linux@prisktech.co.nz>
 <1349891673.22215.2.camel@gitbox>
Message-ID: <201210101839.58052.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 October 2012, Tony Prisk wrote:
> I did have one bit I wasn't sure about:
> 
> On Wed, 2012-10-10 at 21:08 +1300, Tony Prisk wrote:
> > This patch converts arch-vt8500/irq.c to MULTI_IRQ_HANDLER and
> > SPARSE_IRQ. IRQ domain is changed from legacy to linear.
> > 
> > Also, remove legacy code in include/mach/entry-macro.S and
> > include/mach/irq.h to prepare for multiplatform.
> > 
> > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> > ---
> >  ...
> >  
> > diff --git a/arch/arm/mach-vt8500/common.h b/arch/arm/mach-vt8500/common.h
> > index 2b24196..6f2b843 100644
> > --- a/arch/arm/mach-vt8500/common.h
> > +++ b/arch/arm/mach-vt8500/common.h
> > @@ -25,4 +25,7 @@ int __init vt8500_irq_init(struct device_node *node,
> >  /* defined in drivers/clk/clk-vt8500.c */
> >  void __init vtwm_clk_init(void __iomem *pmc_base);
> >  
> > +/* defined in irq.c */
> > +asmlinkage void vt8500_handle_irq(struct pt_regs *regs);
> 
> Should asmlinkage be used here in the header or is it unnecessary?

I think it's not technically needed because the function is not called
from C code anywhere, but IMHO it's better to have it here out of principle.

	Arnd
