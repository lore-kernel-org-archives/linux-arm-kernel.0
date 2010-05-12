From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 12 May 2010 18:14:57 +0200
Subject: [PATCH 03/16] ARM: Samsung: plat-s5p - enable access to clk_27m
	clock
In-Reply-To: <001301caf18f$4fd6e060$ef84a120$%kim@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-4-git-send-email-m.szyprowski@samsung.com>
	<001301caf18f$4fd6e060$ef84a120$%kim@samsung.com>
Message-ID: <002901caf1ee$45f7f930$d1e7eb90$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, May 12, 2010 6:55 AM Kukjin Kim wrote:

> Marek Szyprowski wrote:
> >
> > Clock clk_27m can be a source for other clocks in S5PC100 clocks.
> > This patch removes static attribute of it.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/plat-s5p/clock.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
> > index aa96e33..519cdb4 100644
> > --- a/arch/arm/plat-s5p/clock.c
> > +++ b/arch/arm/plat-s5p/clock.c
> > @@ -33,7 +33,7 @@ struct clk clk_ext_xtal_mux = {
> >  	.id		= -1,
> >  };
> >
> > -static struct clk s5p_clk_27m = {
> > +struct clk clk_27m = {
> >  	.name		= "clk_27m",
> >  	.id		= -1,
> >  	.rate		= 27000000,
> > @@ -129,7 +129,7 @@ int s5p_gatectrl(void __iomem *reg, struct clk *clk,
> int
> > enable)
> >  static struct clk *s5p_clks[] __initdata = {
> >  	&clk_ext_xtal_mux,
> >  	&clk_48m,
> > -	&s5p_clk_27m,
> > +	&clk_27m,
> >  	&clk_fout_apll,
> >  	&clk_fout_mpll,
> >  	&clk_fout_epll,
> > --
> 
> Since clk_27m is now not static, it would be good to rename it as
> s5p_clk_27m.
> Do you have any reason for renaming?

Yes, I wanted to make it compatible with mach-s3c64xx. A clock of the same name
is defined in mach-s3c64xx/clock.c.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
