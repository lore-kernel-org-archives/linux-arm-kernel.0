From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 23 Jul 2012 10:36:33 +0800
Subject: [alsa-devel] [PATCH 4/4] ARM: mx28evk: add missed clkmux
 select for saif
In-Reply-To: <20120721074002.GC923@S2101-09.ap.freescale.net>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-5-git-send-email-b29396@freescale.com>
 <20120721074002.GC923@S2101-09.ap.freescale.net>
Message-ID: <20120723023632.GA9427@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2012 at 03:40:04PM +0800, Shawn Guo wrote:
> On Fri, Jul 20, 2012 at 05:20:27PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > Added missed clkmux setting for mx28evk.
> > 
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: Liam Girdwood <lrg@ti.com>
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> > ---
> >  arch/arm/mach-mxs/mach-mxs.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> > index 8cac94b..82f27a4 100644
> > --- a/arch/arm/mach-mxs/mach-mxs.c
> > +++ b/arch/arm/mach-mxs/mach-mxs.c
> > @@ -21,6 +21,7 @@
> >  #include <asm/mach/arch.h>
> >  #include <asm/mach/time.h>
> >  #include <mach/common.h>
> > +#include <mach/digctl.h>
> >  
> >  static int __init mxs_icoll_add_irq_domain(struct device_node *np,
> >  				struct device_node *interrupt_parent)
> > @@ -79,6 +80,8 @@ static void __init imx28_evk_init(void)
> >  	clk = clk_get_sys("enet_out", NULL);
> >  	if (!IS_ERR(clk))
> >  		clk_prepare_enable(clk);
> > +
> > +	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
> 
> Is this a board specific setup?  Or every single imx28 based board that
> wants recording function is going to need this setup?
> 
Yes, this is a board specific setup, just as non-dt does currently.
Different boards may have different setting.

> BTW, the patch needs to get rebased on v3.6-rc1, where mach-mxs.c will
> have some context update.
> 
I can do it.
This patch series was made based on Mark's sound-2.6 tree.
Do you want this one go through mxs tree and other three go through Mark's tree?
I'm thinking maybe it would be better go through one tree(Mark's or Yours) since
without this one the saif record still can not work.
Maybe go through yours may save some conflicts.

Mark,
What's your suggestion?

Regards
Dong Aisheng
