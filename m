From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 Aug 2013 11:10:43 +0100
Subject: [PATCH 19/33] clk: ux500: Add Device Tree support for the PRCMU
 clock
In-Reply-To: <CACRpkdar9oOWQ9xuQnKvvAOw-eQS1-FkDSDD8BwQT3WDE8YzBA@mail.gmail.com>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-20-git-send-email-lee.jones@linaro.org>
 <CACRpkdar9oOWQ9xuQnKvvAOw-eQS1-FkDSDD8BwQT3WDE8YzBA@mail.gmail.com>
Message-ID: <20130821101043.GI29850@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Aug 2013, Linus Walleij wrote:

> On Thu, Jun 6, 2013 at 2:17 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > This patch enables clocks to be specified from Device Tree via phandles
> > to the "prcmu-clock" node.
> (..)
> > @@ -52,14 +54,17 @@ void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
> >         clk = clk_reg_prcmu_gate("soc0_pll", NULL, PRCMU_PLLSOC0,
> >                                 CLK_IS_ROOT|CLK_IGNORE_UNUSED);
> >         clk_register_clkdev(clk, "soc0_pll", NULL);
> > +       prcmu_clk[PRCMU_PLLSOC0] = clk;
> 
> Same comment on all these.
> 
> No clk_register_clkdev() on the DT boot path please.

I'll fix this during my ATAG removal patch-set.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
