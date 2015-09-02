From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 2 Sep 2015 16:33:53 +0530
Subject: [PATCH] clk: spear600: Fix adc clock device name
In-Reply-To: <20150902110213.GD26744@linux>
References: <1441190517-20235-1-git-send-email-sr@denx.de>
 <20150902110213.GD26744@linux>
Message-ID: <20150902110353.GE26744@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02-09-15, 16:32, Viresh Kumar wrote:
> On 02-09-15, 12:41, Stefan Roese wrote:
> > The device name for the adc clock is incorrect. This results in the
> > IIO ADC driver to fail while probing for the clock. This patch
> > fixes the name and the ADC driver is now started correctly.
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Mike Turquette <mturquette@linaro.org>
> > ---
> >  drivers/clk/spear/spear6xx_clock.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
> > index 4f649c9..3e43244 100644
> > --- a/drivers/clk/spear/spear6xx_clock.c
> > +++ b/drivers/clk/spear/spear6xx_clock.c
> > @@ -316,7 +316,7 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
> >  	/* clock derived from apb clk */
> >  	clk = clk_register_gate(NULL, "adc_clk", "apb_clk", 0, PERIP1_CLK_ENB,
> >  			ADC_CLK_ENB, 0, &_lock);
> > -	clk_register_clkdev(clk, NULL, "adc");
> > +	clk_register_clkdev(clk, NULL, "d8200000.adc");
> >  
> >  	clk = clk_register_fixed_factor(NULL, "gpio0_clk", "apb_clk", 0, 1, 1);
> >  	clk_register_clkdev(clk, NULL, "f0100000.gpio");
> 
> Sigh. Its fixed for all other boards, but this.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Sending to Mike's updated email id.

-- 
viresh
