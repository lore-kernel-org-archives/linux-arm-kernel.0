From: avinashphilip@ti.com (Philip, Avinash)
Date: Wed, 20 Mar 2013 11:28:02 +0000
Subject: [PATCH v2 1/3] ARM: davinci: clk framework support for
 enable/disable functionality
In-Reply-To: <51499B5B.7020105@ti.com>
References: <1363761714-15034-1-git-send-email-avinashphilip@ti.com>
 <1363761714-15034-2-git-send-email-avinashphilip@ti.com>
 <51499B5B.7020105@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EA99DF5@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 16:49:55, Nori, Sekhar wrote:
> On 3/20/2013 12:11 PM, Philip Avinash wrote:
> > DAVINCI clock framework currently not supporting clock enable/disable
> > functionality on clock nodes. In DAVINCI platform EHRPWM module requires
> 
> Wrong. clock enable/disable is supported in the DaVinci clock
> implementation, but just for PSC clocks.
> 
> > support for clock enable/disable for TBCLK support. Hence this patch
> > adds support for enabling/disabling clocks depends on the availability
> > of the functionality.
> > 
> > Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> > ---
> > Changes since v1:
> > 	- Add support for clock enable/disable functionality.
> > 
> > :100644 100644 d458558... aa89e5e... M	arch/arm/mach-davinci/clock.c
> > :100644 100644 8694b39... 1e4e836... M	arch/arm/mach-davinci/clock.h
> >  arch/arm/mach-davinci/clock.c |    4 ++++
> >  arch/arm/mach-davinci/clock.h |    2 ++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
> > index d458558..aa89e5e 100644
> > --- a/arch/arm/mach-davinci/clock.c
> > +++ b/arch/arm/mach-davinci/clock.c
> > @@ -35,6 +35,8 @@ static void __clk_enable(struct clk *clk)
> >  {
> >  	if (clk->parent)
> >  		__clk_enable(clk->parent);
> > +	if (clk->clk_enable)
> > +		clk->clk_enable(clk);
> 
> Why ignore usecount in this case?

Will check usecount & do enable. 

> 
> >  	if (clk->usecount++ == 0 && (clk->flags & CLK_PSC))
> 
> if clk->enable is available, no need to check for 'clk->flags & CLK_PSC'

I will correct it.

Thanks
Avinash

> 
> Thanks,
> Sekhar
> 
