From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed, 3 Sep 2014 09:42:50 +0200
Subject: [PATCH] clk: at91: fix num_parents test in at91sam9260 slow clk
 implementation
In-Reply-To: <20140902214506.5251.1412@quantum>
References: <1409671671-13544-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140902214506.5251.1412@quantum>
Message-ID: <20140903094250.0a5b5154@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 02 Sep 2014 14:45:06 -0700
Mike Turquette <mturquette@linaro.org> wrote:

> Quoting Boris BREZILLON (2014-09-02 08:27:51)
> > The slow clk block provided by at91sam9260 and derived SoCs should always
> > have 2 parents.
> > 
> > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > ---
> > 
> > Hello Mike,
> > 
> > Could you take this fix for the next 3.17 rc ?
> > Without this fix you won't be able to use programmable clks (the slow
> > clk is one of the parents of prog clks), and these prog clks are used,
> > among other things, to provide clks to external audio chips.
> > 
> > No need to backport this fix to previous stable releases, as CCF support
> > for at91sam9260 (and derived) SoCs only appeared in 3.17.
> 
> Pulled into clk-fixes.

Thanks!

> 
> Regards,
> Mike
> 
> > 
> > Best Regards,
> > 
> > Boris
> > 
> >  drivers/clk/at91/clk-slow.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
> > index 0300c46..32f7c1b 100644
> > --- a/drivers/clk/at91/clk-slow.c
> > +++ b/drivers/clk/at91/clk-slow.c
> > @@ -447,7 +447,7 @@ void __init of_at91sam9260_clk_slow_setup(struct device_node *np,
> >         int i;
> >  
> >         num_parents = of_count_phandle_with_args(np, "clocks", "#clock-cells");
> > -       if (num_parents <= 0 || num_parents > 1)
> > +       if (num_parents != 2)
> >                 return;
> >  
> >         for (i = 0; i < num_parents; ++i) {
> > -- 
> > 1.9.1
> > 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
