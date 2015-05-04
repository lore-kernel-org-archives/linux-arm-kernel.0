From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 4 May 2015 16:15:24 +0800
Subject: [PATCH RFC v1 1/5] clk: change clk_core name of
 __clk_set_parent_after
In-Reply-To: <55427D25.3040904@codeaurora.org>
References: <1429107999-24413-1-git-send-email-aisheng.dong@freescale.com>
 <1429107999-24413-2-git-send-email-aisheng.dong@freescale.com>
 <55427D25.3040904@codeaurora.org>
Message-ID: <20150504081518.GA4082@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 12:06:13PM -0700, Stephen Boyd wrote:
> On 04/15/15 07:26, Dong Aisheng wrote:
> > To align with __clk_set_parent_before and some others functions,
> > change the host clk name to 'clk' instead of 'core'.
> >
> > Cc: Mike Turquette <mturquette@linaro.org>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
> > ---
> 
> No thanks. We should go and rename all clk_core pointers in this file
> from clk to core now that we're done splitting the two. I'll go do that now.
> 

Understand.
Thanks for this information.

Regards
Dong Aisheng

> >  drivers/clk/clk.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 459ce9d..cc56ba2 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1487,7 +1487,7 @@ static struct clk_core *__clk_set_parent_before(struct clk_core *clk,
> >  	return old_parent;
> >  }
> >  
> > -static void __clk_set_parent_after(struct clk_core *core,
> > +static void __clk_set_parent_after(struct clk_core *clk,
> >  				   struct clk_core *parent,
> >  				   struct clk_core *old_parent)
> >  {
> > @@ -1495,8 +1495,8 @@ static void __clk_set_parent_after(struct clk_core *core,
> >  	 * Finish the migration of prepare state and undo the changes done
> >  	 * for preventing a race with clk_enable().
> >  	 */
> > -	if (core->prepare_count) {
> > -		clk_core_disable(core);
> > +	if (clk->prepare_count) {
> > +		clk_core_disable(clk);
> >  		clk_core_disable(old_parent);
> >  		clk_core_unprepare(old_parent);
> >  	}
> 
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
