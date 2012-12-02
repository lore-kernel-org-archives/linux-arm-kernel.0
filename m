From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 2 Dec 2012 13:13:37 +0000
Subject: [PATCH] ARM: ixp4xx: Add "ask" handler for timer interrupts
In-Reply-To: <1354428123.119115041@f313.mail.ru>
References: <1354347213-22237-1-git-send-email-shc_work@mail.ru>
 <201212020011.42105.arnd@arndb.de> <1354428123.119115041@f313.mail.ru>
Message-ID: <201212021313.37790.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 December 2012, Alexander Shiyan wrote:
> > diff --git a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
> > index eb68b61..2522ab0 100644
> > --- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
> > +++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
> > @@ -92,7 +92,7 @@
> >  /*
> >   * Expansion Bus Controller registers.
> >   */
> > -#define IXP4XX_EXP_REG(x) ((volatile u32 __iomem *)(IXP4XX_EXP_CFG_BASE_VIRT+(x)))
> > +#define IXP4XX_EXP_REG(x) (IXP4XX_EXP_CFG_BASE_VIRT+(x))
> Modify this to:
> #define IXP4XX_EXP_REG(x) IOMEM(IXP4XX_EXP_CFG_BASE_VIRT+(x))
> to avoid compiler warnings.
> 

Hmm, not sure what went wrong here. Actually the definition of 
IXP4XX_EXP_CFG_BASE_VIRT itself should use the IOMEM() macro, like
all the other IXP4XX_*_BASE_VIRT do.

	Arnd
