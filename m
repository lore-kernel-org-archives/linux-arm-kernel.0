From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 12 May 2010 07:33:22 +0200
Subject: [PATCH 01/16] ARM: S5PC1xx rename registers to match plat-s5p
	style
In-Reply-To: <001201caf18f$4f72a050$ee57e0f0$%kim@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-2-git-send-email-m.szyprowski@samsung.com>
	<001201caf18f$4f72a050$ee57e0f0$%kim@samsung.com>
Message-ID: <002a01caf194$a57989a0$f06c9ce0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, May 12, 2010 6:55 AM Kukjin Kim wrote:

> Marek Szyprowski wrote:
> >
> > Prepare for moving support for S5PC100 SoC to plat-s5p framework (part 1).
> > Rename all clock registers to match plat-s5p style.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/mach-s5pc100/include/mach/system.h     |    2 +-
> >  arch/arm/plat-s5pc1xx/clock.c                   |  190 ++++++------
> >  arch/arm/plat-s5pc1xx/include/plat/regs-clock.h |  366
> +++++++++++-----------
> >  arch/arm/plat-s5pc1xx/s5pc100-clock.c           |  180 ++++++------
> >  4 files changed, 369 insertions(+), 369 deletions(-)
> >
> > diff --git a/arch/arm/mach-s5pc100/include/mach/system.h b/arch/arm/mach-
> > s5pc100/include/mach/system.h
> > index f0d31a2..09aea4d 100644
> > --- a/arch/arm/mach-s5pc100/include/mach/system.h
> > +++ b/arch/arm/mach-s5pc100/include/mach/system.h
> > @@ -25,7 +25,7 @@ static void arch_idle(void)
> >
> >  static void arch_reset(char mode, const char *cmd)
> >  {
> > -	__raw_writel(S5PC100_SWRESET_RESETVAL, S5PC100_SWRESET);
> > +	__raw_writel(S5P_SWRESET_RESETVAL, S5P_SWRESET);
> >  	return;
> >  }
> >  #endif /* __ASM_ARCH_IRQ_H */
> 
> Why __ASM_ARCH_IRQ_H?
> It may be right __ASM_ARCH_SYSTEM_H.
> 
> > diff --git a/arch/arm/plat-s5pc1xx/clock.c b/arch/arm/plat-
> s5pc1xx/clock.c
> > index 387f231..1a07dd5 100644
> > --- a/arch/arm/plat-s5pc1xx/clock.c
> > +++ b/arch/arm/plat-s5pc1xx/clock.c
> > @@ -39,13 +39,13 @@ static int clk_48m_ctrl(struct clk *clk, int enable)
> >  	/* can't rely on clock lock, this register has other usages */
> >  	local_irq_save(flags);
> >
> > -	val = __raw_readl(S5PC100_CLKSRC1);
> > +	val = __raw_readl(S5P_CLK_SRC1);
> >  	if (enable)
> > -		val |= S5PC100_CLKSRC1_CLK48M_MASK;
> > +		val |= S5P_CLK_SRC1_CLK48M_MASK;
> >  	else
> > -		val &= ~S5PC100_CLKSRC1_CLK48M_MASK;
> > +		val &= ~S5P_CLK_SRC1_CLK48M_MASK;
> >
> > -	__raw_writel(val, S5PC100_CLKSRC1);
> > +	__raw_writel(val, S5P_CLK_SRC1);
> >  	local_irq_restore(flags);
> >
> >  	return 0;
> > @@ -99,62 +99,62 @@ static int s5pc1xx_clk_gate(void __iomem *reg, struct
> clk
> > *clk, int enable)
> >
> >  static int s5pc100_clk_d00_ctrl(struct clk *clk, int enable)
> >  {
> > -	return s5pc1xx_clk_gate(S5PC100_CLKGATE_D00, clk, enable);
> > +	return s5pc1xx_clk_gate(S5P_CLKGATE_D00, clk, enable);
> 
> Please use s5p_gatectrl(plat-s5p/clock.c) instead of s5pc1xx_clk_gate.

> ...

This patch is a simple global register rename. I moved all real changes
to the separate patch to make it easy to follow what has been changed.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
