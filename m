From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 12 Oct 2012 08:05:06 -0700
Subject: [PATCH] clk: SPEAr: Vco-pll: Fix compilation warning
In-Reply-To: <CAOh2x=npo5A0gvk75Cc5MMzp_qfA4GUeETdCwN-wvA4LCsSVYw@mail.gmail.com>
References: <670019c51d5205a7ae85ada48986303e691faa9c.1349343959.git.viresh.kumar@linaro.org>
 <CAOh2x=npo5A0gvk75Cc5MMzp_qfA4GUeETdCwN-wvA4LCsSVYw@mail.gmail.com>
Message-ID: <20121012150506.2941.11751@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting viresh kumar (2012-10-11 22:51:05)
> Hi Mike,
> 
> Because you are back now, can you please push this patch?
> 

Done.

Regards,
Mike

> On Thu, Oct 4, 2012 at 3:19 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Currently we are getting following warning for SPEAr clk-vco-pll.
> >
> > "warning: i is used uninitialized in this function."
> >
> > This is because we are getting value of i by passing its pointer to another
> > routine.
> >
> > The variables here are really not used uninitialized.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >
> > Andrew,
> >
> > I know this must have gone through Mike Turquette. But he is not around for a
> > week. As, this is a pretty small change, can you take it upstream?
> >
> > drivers/clk/spear/clk-vco-pll.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/spear/clk-vco-pll.c b/drivers/clk/spear/clk-vco-pll.c
> > index 5f1b6ba..1b9b65b 100644
> > --- a/drivers/clk/spear/clk-vco-pll.c
> > +++ b/drivers/clk/spear/clk-vco-pll.c
> > @@ -147,7 +147,7 @@ static int clk_pll_set_rate(struct clk_hw *hw, unsigned long drate,
> >         struct clk_pll *pll = to_clk_pll(hw);
> >         struct pll_rate_tbl *rtbl = pll->vco->rtbl;
> >         unsigned long flags = 0, val;
> > -       int i;
> > +       int uninitialized_var(i);
> >
> >         clk_pll_round_rate_index(hw, drate, NULL, &i);
> >
> > --
> > 1.7.12.rc2.18.g61b472e
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
