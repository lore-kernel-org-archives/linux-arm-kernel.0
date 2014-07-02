From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 02 Jul 2014 09:38:42 -0700
Subject: [PATCH 03/33] clk: at91: main: warn when the main crystal
 frequency is not set
In-Reply-To: <20140702101811.2f2a507e@bbrezillon>
References: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1404223962-30471-4-git-send-email-alexandre.belloni@free-electrons.com>
 <20140702101811.2f2a507e@bbrezillon>
Message-ID: <20140702163842.7440.73162@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris BREZILLON (2014-07-02 01:18:11)
> On Tue,  1 Jul 2014 16:12:12 +0200
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
> > When the main crystal frequency is not set, the main clock is
> > approximated using the MAINF value in the CKGR_MCFR register. Warn
> > the user in that case.
> > 
> > Signed-off-by: Alexandre Belloni
> > <alexandre.belloni@free-electrons.com> ---
> 
> Acked-by: Boris BREZILLON <boris.brezillon@overkiz.com>
> 
> Mike, do you want me to take this patch and send you a pull request, or
> should I let you take this one directly ?

I've picked it up since it is just the one patch.

Regards,
Mike

> 
> Best Regards,
> 
> Boris
> 
> >  drivers/clk/at91/clk-main.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
> > index 733306131b99..59fa3cc96c9e 100644
> > --- a/drivers/clk/at91/clk-main.c
> > +++ b/drivers/clk/at91/clk-main.c
> > @@ -388,6 +388,7 @@ static unsigned long clk_main_recalc_rate(struct
> > at91_pmc *pmc, if (parent_rate)
> >               return parent_rate;
> >  
> > +     pr_warn("Main crystal frequency not set, using approximate
> > value\n"); tmp = pmc_read(pmc, AT91_CKGR_MCFR);
> >       if (!(tmp & AT91_PMC_MAINRDY))
> >               return 0;
> 
> 
> 
> -- 
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
