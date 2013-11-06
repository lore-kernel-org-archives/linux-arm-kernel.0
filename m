From: horms@verge.net.au (Simon Horman)
Date: Wed, 6 Nov 2013 17:35:58 +0900
Subject: [PATCH] ARM: shmobile: r8a7790: Correct typo in clocks
In-Reply-To: <87zjpiysh4.wl%kuninori.morimoto.gx@renesas.com>
References: <1383714098-28770-1-git-send-email-horms+renesas@verge.net.au>
 <87zjpiysh4.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20131106083556.GC14694@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 10:06:20PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > This is the r8a7790 SoC not the r8a77a4 SoC and
> > clocks are updated in r8a7790_clock_init.  not r8a73a4_clock_init.

Ironically there is a typo in the line above.
I'll fix that up before applying the patch.

> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/mach-shmobile/clock-r8a7790.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> > index 9fa39d1..6107571 100644
> > --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> > +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> > @@ -77,7 +77,7 @@ static struct sh_clk_ops followparent_clk_ops = {
> >  };
> >  
> >  static struct clk main_clk = {
> > -	/* .parent will be set r8a73a4_clock_init */
> > +	/* .parent will be set r8a7790_clock_init */
> >  	.ops	= &followparent_clk_ops,
> >  };
> 
> Hahaha, Nice catch :)
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Best regards
> ---
> Kuninori Morimoto
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
