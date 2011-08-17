From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 17 Aug 2011 17:46:28 +0900
Subject: [PATCH] ARM: SAMSUNG: Modify the devname for pl330 clock
In-Reply-To: <4E4B5CD9.7060703@mleia.com>
References: <1313540801-12054-1-git-send-email-boojin.kim@samsung.com>
	<4E4B5CD9.7060703@mleia.com>
Message-ID: <001601cc5cba$27b49400$771dbc00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vladimir Zapolskiy wrote:
> Hi,
>
> looks like it contains my series as a subset.

As I replied on your patches, yes, I know that. I sent it before see your
patch.
Do you add the missing about s5p64x0 in your patch?
If not, I will split up this patch to get missing about s5p64x0 in your
patch.

Thanks
Boojin Kim.

>
> --
> With best wishes,
> Vladimir
>
> On 17.08.2011 03:26, Boojin Kim wrote:
> > This patch modified the devname for pl330 clock from 's3c-pl330' to
> 'dma-pl330'
> > to support new pl330 driver on dmaengine.
> > NOTE: This patch sould be added after merging new pl330 driver on
> dmaengine.
> >
> > Signed-off-by: Boojin Kim<boojin.kim@samsung.com>
> > ---
> >   arch/arm/mach-exynos4/clock.c         |    4 ++--
> >   arch/arm/mach-s5p64x0/clock-s5p6440.c |    1 +
> >   arch/arm/mach-s5p64x0/clock-s5p6450.c |    1 +
> >   arch/arm/mach-s5pc100/clock.c         |    4 ++--
> >   arch/arm/mach-s5pv210/clock.c         |    4 ++--
> >   5 files changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-
> exynos4/clock.c
> > index fee2dd8..04c997a 100644
> > --- a/arch/arm/mach-exynos4/clock.c
> > +++ b/arch/arm/mach-exynos4/clock.c
> > @@ -460,12 +460,12 @@ static struct clk init_clocks_off[] = {
> >   		.ctrlbit	= (1<<  10),
> >   	}, {
> >   		.name		= "dma",
> > -		.devname	= "s3c-pl330.0",
> > +		.devname	= "dma-pl330.0",
> >   		.enable		= exynos4_clk_ip_fsys_ctrl,
> >   		.ctrlbit	= (1<<  0),
> >   	}, {
> >   		.name		= "dma",
> > -		.devname	= "s3c-pl330.1",
> > +		.devname	= "dma-pl330.1",
> >   		.enable		= exynos4_clk_ip_fsys_ctrl,
> >   		.ctrlbit	= (1<<  1),
> >   	}, {
> > diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-
> s5p64x0/clock-s5p6440.c
> > index c1f548f..c54c65d 100644
> > --- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
> > +++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
> > @@ -147,6 +147,7 @@ static struct clk init_clocks_off[] = {
> >   		.ctrlbit	= (1<<  8),
> >   	}, {
> >   		.name		= "dma",
> > +		.devname	= "dma-pl330",
> >   		.parent		=&clk_hclk_low.clk,
> >   		.enable		= s5p64x0_hclk0_ctrl,
> >   		.ctrlbit	= (1<<  12),
> > diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-
> s5p64x0/clock-s5p6450.c
> > index 3d9b609..2d04abf 100644
> > --- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
> > +++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
> > @@ -180,6 +180,7 @@ static struct clk init_clocks_off[] = {
> >   		.ctrlbit	= (1<<  3),
> >   	}, {
> >   		.name		= "dma",
> > +		.devname	= "dma-pl330",
> >   		.parent		=&clk_hclk_low.clk,
> >   		.enable		= s5p64x0_hclk0_ctrl,
> >   		.ctrlbit	= (1<<  12),
> > diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-
> s5pc100/clock.c
> > index 6527c05..8d47709 100644
> > --- a/arch/arm/mach-s5pc100/clock.c
> > +++ b/arch/arm/mach-s5pc100/clock.c
> > @@ -460,13 +460,13 @@ static struct clk init_clocks_off[] = {
> >   		.ctrlbit	= (1<<  2),
> >   	}, {
> >   		.name		= "dma",
> > -		.devname	= "s3c-pl330.1",
> > +		.devname	= "dma-pl330.1",
> >   		.parent		=&clk_div_d1_bus.clk,
> >   		.enable		= s5pc100_d1_0_ctrl,
> >   		.ctrlbit	= (1<<  1),
> >   	}, {
> >   		.name		= "dma",
> > -		.devname	= "s3c-pl330.0",
> > +		.devname	= "dma-pl330.0",
> >   		.parent		=&clk_div_d1_bus.clk,
> >   		.enable		= s5pc100_d1_0_ctrl,
> >   		.ctrlbit	= (1<<  0),
> > diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-
> s5pv210/clock.c
> > index d35726a..239aaad 100644
> > --- a/arch/arm/mach-s5pv210/clock.c
> > +++ b/arch/arm/mach-s5pv210/clock.c
> > @@ -295,13 +295,13 @@ static struct clk_ops clk_fout_apll_ops = {
> >   static struct clk init_clocks_off[] = {
> >   	{
> >   		.name		= "dma",
> > -		.devname	= "s3c-pl330.0",
> > +		.devname	= "dma-pl330.0",
> >   		.parent		=&clk_hclk_psys.clk,
> >   		.enable		= s5pv210_clk_ip0_ctrl,
> >   		.ctrlbit	= (1<<  3),
> >   	}, {
> >   		.name		= "dma",
> > -		.devname	= "s3c-pl330.1",
> > +		.devname	= "dma-pl330.1",
> >   		.parent		=&clk_hclk_psys.clk,
> >   		.enable		= s5pv210_clk_ip0_ctrl,
> >   		.ctrlbit	= (1<<  4),
