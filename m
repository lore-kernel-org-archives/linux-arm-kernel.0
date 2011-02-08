From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 8 Feb 2011 08:55:52 +0530
Subject: [PATCH v2 4/9] omap: clocks: Add checks to see if enable/disable
	ops are supported
In-Reply-To: <alpine.DEB.2.00.1102071846570.21991@utopia.booyaka.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
	<1296813544-25170-5-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1102071846570.21991@utopia.booyaka.com>
Message-ID: <85772086dbd5bbd435fe7779ded71b3b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Tuesday, February 08, 2011 7:18 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; khilman at ti.com; b-cousson at ti.com;
rnayak at ti.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2 4/9] omap: clocks: Add checks to see if
enable/disable ops are supported
>
> On Fri, 4 Feb 2011, Santosh Shilimkar wrote:
>
> > From: Rajendra Nayak <rnayak@ti.com>
> >
> > Check if enable/disable operations are supported for a given
> > clock node before attempting to call them.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock.c |   14 +++++++++-----
> >  1 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> > index 2a2f152..5c08c18 100644
> > --- a/arch/arm/mach-omap2/clock.c
> > +++ b/arch/arm/mach-omap2/clock.c
> > @@ -261,7 +261,8 @@ void omap2_clk_disable(struct clk *clk)
> >
> >  	pr_debug("clock: %s: disabling in hardware\n", clk->name);
> >
> > -	clk->ops->disable(clk);
> > +	if (clk->ops && clk->ops->enable)
> > +		clk->ops->disable(clk);
>
> Shouldn't that read:
>
>     if (clk->ops && clk->ops->disable)
>
> ?

Oops.. I guess it should. Will fix that and repost.

>
>
> - Paul
