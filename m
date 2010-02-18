From: amit.kucheria@verdurent.com (Amit Kucheria)
Date: Thu, 18 Feb 2010 10:20:54 +0200
Subject: [PATCH] mx51_babbage: Fix ckih2 parameter in mx51_clocks_init
	function
In-Reply-To: <20100218074241.GF17643@pengutronix.de>
References: <88241.12409.qm@web51008.mail.re2.yahoo.com>
	<20100218074241.GF17643@pengutronix.de>
Message-ID: <20100218082054.GC3850@matterhorn.verdurent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Feb 18, Sascha Hauer wrote:
> Amit,
> 
> As you made the initial port to the babbage board and were not on Cc,
> can I have an acked-by for this?
> 
> Sascha
> 
> On Wed, Feb 17, 2010 at 12:02:56PM -0800, Fabio Estevam wrote:
> > This patch is to be applied into Sascha's mxc-master branch.
> > 
> > Fix ckih2 parameter in mx51_clocks_init funtion. CKIH2 pin is left unconnected on Babbage.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> >  arch/arm/mach-mx5/board-mx51_babbage.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> > index d5ccb5f..ee67a71 100644
> > --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> > +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> > @@ -79,7 +79,7 @@ static void __init mxc_board_init(void)
> >  
> >  static void __init mx51_babbage_timer_init(void)
> >  {
> > -	mx51_clocks_init(32768, 24000000, 22579200, 24576000);
> > +	mx51_clocks_init(32768, 24000000, 22579200, 0);
> >  }
> >  
> >  static struct sys_timer mxc_timer = {
> > -- 
> > 1.6.0.4

Acked-by: Amit Kucheria <amit.kucheria@canonical.com>

-- 
-------------------------------------------------------------------------
Amit Kucheria,				 Kernel Engineer, Canonical
-------------------------------------------------------------------------
