From: horms@verge.net.au (Simon Horman)
Date: Wed, 15 May 2013 10:46:22 +0900
Subject: [PATCH 06/20] ARM: shmobile: kzm9g: Remove init_irq declaration
 in machine description
In-Reply-To: <20130515005917.GE12246@verge.net.au>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368545933-7430-7-git-send-email-maxime.ripard@free-electrons.com>
 <20130515005917.GE12246@verge.net.au>
Message-ID: <20130515014622.GL12246@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 09:59:17AM +0900, Simon Horman wrote:
> On Tue, May 14, 2013 at 05:38:39PM +0200, Maxime Ripard wrote:
> > Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> > specified") removed the need to explictly setup the init_irq field in
> > the machine description when using only irqchip_init. Remove that
> > declaration for shmobile as well.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/mach-shmobile/board-kzm9g-reference.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> > index aefa50d..b7ee96e 100644
> > --- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> > +++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> > @@ -24,7 +24,6 @@
> >  #include <linux/gpio.h>
> >  #include <linux/io.h>
> >  #include <linux/irq.h>
> > -#include <linux/irqchip.h>
> >  #include <linux/input.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/pinctrl/machine.h>
> > @@ -100,7 +99,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
> >  	.map_io		= sh73a0_map_io,
> >  	.init_early	= sh73a0_init_delay,
> >  	.nr_irqs	= NR_IRQS_LEGACY,
> > -	.init_irq	= irqchip_init,
> >  	.init_machine	= kzm_init,
> >  	.init_time	= shmobile_timer_init,
> >  	.dt_compat	= kzm9g_boards_compat_dt,
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Sorry, what I should have said is:

Queued up for v3.11 in the boards-kzm9g branch of my renesas tree
on kernel.org. It is included in the renesas-next-20130515 tag of
that tree and should appear in linux-next in the not to distant future.
