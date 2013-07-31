From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 30 Jul 2013 21:00:56 -0700
Subject: [PATCH Resend 1/1] clk: exynos4: Add clock entries for TMU
In-Reply-To: <0eb201ce8866$212e3080$638a9180$@org>
References: <1374660555-17429-1-git-send-email-sachin.kamat@linaro.org>
 <0eb201ce8866$212e3080$638a9180$@org>
Message-ID: <20130731040056.24490.65774@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kukjin Kim (2013-07-24 05:05:46)
> Sachin Kamat wrote:
> > 
> > Added clock entries for thermal management unit (TMU) for
> > Exynos4 SoCs.
> > 
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Mike, I remember you're ok this for v3.12 so if you do not apply this in
> clk-next yet, please go ahead :)

You remember correctly. I've pulled this into clk-next.

Regards,
Mike

> 
> Thanks,
> Kukjin
> 
> > ---
> > Resending this (after rebasing) based on the below discussion:
> > http://comments.gmane.org/gmane.linux.kernel.samsung-soc/19933
> > 
> > Previous version:
> > http://comments.gmane.org/gmane.linux.kernel.samsung-soc/18081
> > ---
> >  .../devicetree/bindings/clock/exynos4-clock.txt    |    1 +
> >  drivers/clk/samsung/clk-exynos4.c                  |    4 +++-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/exynos4-clock.txt
> > b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
> > index 14d5c2a..c6bf8a6 100644
> > --- a/Documentation/devicetree/bindings/clock/exynos4-clock.txt
> > +++ b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
> > @@ -236,6 +236,7 @@ Exynos4 SoC and this is specified where applicable.
> >    spi0_isp_sclk       380     Exynos4x12
> >    spi1_isp_sclk       381     Exynos4x12
> >    uart_isp_sclk       382     Exynos4x12
> > +  tmu_apbif           383
> > 
> >               [Mux Clocks]
> > 
> > diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-
> > exynos4.c
> > index 75635eb..cee297d 100644
> > --- a/drivers/clk/samsung/clk-exynos4.c
> > +++ b/drivers/clk/samsung/clk-exynos4.c
> > @@ -169,7 +169,7 @@ enum exynos4_clks {
> >       gicisp, smmu_isp, smmu_drc, smmu_fd, smmu_lite0, smmu_lite1,
> > mcuctl_isp,
> >       mpwm_isp, i2c0_isp, i2c1_isp, mtcadc_isp, pwm_isp, wdt_isp,
> > uart_isp,
> >       asyncaxim, smmu_ispcx, spi0_isp, spi1_isp, pwm_isp_sclk,
> > spi0_isp_sclk,
> > -     spi1_isp_sclk, uart_isp_sclk,
> > +     spi1_isp_sclk, uart_isp_sclk, tmu_apbif,
> > 
> >       /* mux clocks */
> >       mout_fimc0 = 384, mout_fimc1, mout_fimc2, mout_fimc3, mout_cam0,
> > @@ -814,6 +814,7 @@ static struct samsung_gate_clock
> exynos4210_gate_clks[]
> > __initdata = {
> >       GATE_A(keyif, "keyif", "aclk100", E4210_GATE_IP_PERIR, 16, 0, 0,
> > "keypad"),
> >       GATE_DA(sclk_fimd1, "exynos4-fb.1", "sclk_fimd1", "div_fimd1",
> >                       E4210_SRC_MASK_LCD1, 0, CLK_SET_RATE_PARENT, 0,
> > "sclk_fimd"),
> > +     GATE(tmu_apbif, "tmu_apbif", "aclk100", E4210_GATE_IP_PERIR, 17, 0,
> > 0),
> >  };
> > 
> >  /* list of gate clocks supported in exynos4x12 soc */
> > @@ -915,6 +916,7 @@ static struct samsung_gate_clock
> exynos4x12_gate_clks[]
> > __initdata = {
> >       GATE(spi1_isp, "spi1_isp", "aclk200", E4X12_GATE_ISP1, 13,
> >                       CLK_IGNORE_UNUSED, 0),
> >       GATE(g2d, "g2d", "aclk200", GATE_IP_DMC, 23, 0, 0),
> > +     GATE(tmu_apbif, "tmu_apbif", "aclk100", E4X12_GATE_IP_PERIR, 17, 0,
> > 0),
> >  };
> > 
> >  /*
> > --
> > 1.7.9.5
