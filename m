From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Fri, 14 Sep 2012 11:12:55 +0530
Subject: [PATCH V2] ARM: EXYNOS5: Add bus clock and set parent clock for
 FIMD
In-Reply-To: <001101cd9231$3927b9d0$ab772d70$%han@samsung.com>
References: <1347450536-21843-1-git-send-email-l.krishna@samsung.com>
 <001101cd9231$3927b9d0$ab772d70$%han@samsung.com>
Message-ID: <CAL1wa8fjKRisTrfKaPF22EPSoamJZJKd5oN7fKA397e77TNQvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 9:57 AM, Jingoo Han <jg1.han@samsung.com> wrote:
>
> On Wednesday, September 12, 2012 8:49 PM Leela Krishna Amudala wrote
> >
> > This patch adds the bus clock for FIMD and changes the device name for
> > lcd clock
> > also sets mout_mpll_user as parent clock to fimd
> >
> > Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> > ---
> >  arch/arm/mach-exynos/clock-exynos5.c       |   34
> > +++++++++++++++++++--------
> >  arch/arm/plat-samsung/include/plat/clock.h |    2 +
> >  2 files changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos/clock-exynos5.c
> > b/arch/arm/mach-exynos/clock-exynos5.c
> > index 774533c..205d19f 100644
> > --- a/arch/arm/mach-exynos/clock-exynos5.c
> > +++ b/arch/arm/mach-exynos/clock-exynos5.c
> > @@ -891,6 +891,13 @@ static struct clk exynos5_clk_mdma1 = {
>
> [.....]
>
> >
> > +struct clksrc_clk exynos5_clk_sclk_fimd = {
>
> Replace 'exynos5_clk_sclk_fimd' with 'exynos5_clk_sclk_fimd1'.
> This is because 'exynos5_clk_sclk_fimd0' can be added for other
> Exynos5 SoCs later.
>

Okay, will change it and post the next version.

> Best regards,
> Jingoo Han
>
> > +     .clk    = {
> > +             .name           = "sclk_fimd",
> > +             .devname        = "exynos5-fb.1",
> > +             .enable         = exynos5_clksrc_mask_disp1_0_ctrl,
> > +             .ctrlbit        = (1 << 0),
> > +     },
> > +     .sources = &exynos5_clkset_group,
> > +     .reg_src = { .reg = EXYNOS5_CLKSRC_DISP1_0, .shift = 0, .size = 4
> > },
> > +     .reg_div = { .reg = EXYNOS5_CLKDIV_DISP1_0, .shift = 0, .size = 4
> > },
> > +};
> > +
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
