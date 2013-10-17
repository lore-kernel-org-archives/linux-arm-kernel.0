From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 17 Oct 2013 16:16:29 +0200
Subject: [PATCH 3/9] clk: samsung: exynos4: Move suspend/resume handling to
 SoC driver
In-Reply-To: <CAKew6eV7Hd1x1+YLR9rjzNgYu0t=9Q8BG23VUvhPJTf77bsRXQ@mail.gmail.com>
References: <1381921698-5060-1-git-send-email-t.figa@samsung.com>
 <1381921698-5060-4-git-send-email-t.figa@samsung.com>
 <CAKew6eV7Hd1x1+YLR9rjzNgYu0t=9Q8BG23VUvhPJTf77bsRXQ@mail.gmail.com>
Message-ID: <1821539.dxQ3vs372W@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 of October 2013 19:12:08 Yadwinder Singh Brar wrote:
> Hi Tomasz,
> 
> [ ... ]
> >  /*
> >   * list of controller registers to be saved and restored during a
> >   * suspend/resume cycle.
> > @@ -288,6 +299,70 @@ static unsigned long exynos4_clk_regs[] __initdata = {
> >         GATE_IP_CPU,
> >  };
> >
> > +static int exynos4_clk_suspend(void)
> > +{
> > +       samsung_clk_save(reg_base, exynos4_save_common,
> > +                               ARRAY_SIZE(exynos4_clk_regs));
> 
> a doubt here, Is sizeof(exynos4_clk_regs) works with
> exynos4_clk_regs[] as __initdata ?

Hmm, this is a compile time constant, so I don't see why it couldn't work.

> > +
> > +       if (exynos4_soc == EXYNOS4210)
> > +               samsung_clk_save(reg_base, exynos4_save_soc,
> > +                                       ARRAY_SIZE(exynos4210_clk_save));
> 
> [ ... ]
> > +static void exynos4_clk_sleep_init(void)
> 
> I think, this fuction can be placed in __init section.

That's right. Thanks for pointing this out.

Best regards,
Tomasz
