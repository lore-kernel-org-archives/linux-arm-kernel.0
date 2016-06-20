From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 20 Jun 2016 15:57:23 +0200
Subject: [PATCH 3/3] clk: samsung: exynos5433: add CPU clocks configuration
 data and instantiate CPU clocks
In-Reply-To: <CA+Ln22GZu9GEyCzkywkeQz8v-dq5cpVkeGRxk15spUo=JqvgTA@mail.gmail.com>
References: <1464095957-25851-1-git-send-email-b.zolnierkie@samsung.com>
 <1464095957-25851-4-git-send-email-b.zolnierkie@samsung.com>
 <CA+Ln22GZu9GEyCzkywkeQz8v-dq5cpVkeGRxk15spUo=JqvgTA@mail.gmail.com>
Message-ID: <5185433.qVhfPjJi8E@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, June 18, 2016 11:57:30 PM Tomasz Figa wrote:
> Hi Bart,

Hi Tomek,

> 2016-05-24 22:19 GMT+09:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> > Add the CPU clocks configuration data and instantiate the CPU clocks
> > type for Exynos5433.
> >
> > Cc: Kukjin Kim <kgene@kernel.org>
> > CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/clk/samsung/clk-exynos5433.c | 72 ++++++++++++++++++++++++++++++++----
> >  1 file changed, 64 insertions(+), 8 deletions(-)
> 
> Please see my comments inline.
> 
> > diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> > index 6dd81ed..9ff6160 100644
> > --- a/drivers/clk/samsung/clk-exynos5433.c
> > +++ b/drivers/clk/samsung/clk-exynos5433.c
> [snip]
> >  static void __init exynos5433_cmu_apollo_init(struct device_node *np)
> > @@ -3620,6 +3640,12 @@ static void __init exynos5433_cmu_apollo_init(struct device_node *np)
> >                                  ARRAY_SIZE(apollo_div_clks));
> >         samsung_clk_register_gate(ctx, apollo_gate_clks,
> >                                   ARRAY_SIZE(apollo_gate_clks));
> > +
> > +       exynos_register_cpu_clock(ctx, CLK_SCLK_APOLLO, "apolloclk",
> > +               mout_apollo_p[0], mout_apollo_p[1], 0x200,
> > +               exynos5433_apolloclk_d, ARRAY_SIZE(exynos5433_apolloclk_d),
> > +               CLK_CPU_HAS_E5433_REGS_LAYOUT);
> 
> Hmm, I guess the reason for patch 1/3 was that
> exynos_register_cpu_clock() has to be called with the ctx pointer.
> However samsung_cmu_register_one() returns the ctx pointer, so I guess
> you could use that to avoid open-coding?

It is more than need to use ctx pointer.  Please see me reply to your
review of patch 1/3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
