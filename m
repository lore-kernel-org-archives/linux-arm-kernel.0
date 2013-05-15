From: horms@verge.net.au (Simon Horman)
Date: Wed, 15 May 2013 10:47:24 +0900
Subject: [PATCH 08/20] ARM: shmobile: emev2: Remove init_irq declaration
 in machine description
In-Reply-To: <20130515005938.GG12246@verge.net.au>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368545933-7430-9-git-send-email-maxime.ripard@free-electrons.com>
 <20130515005938.GG12246@verge.net.au>
Message-ID: <20130515014724.GN12246@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 09:59:38AM +0900, Simon Horman wrote:
> On Tue, May 14, 2013 at 05:38:41PM +0200, Maxime Ripard wrote:
> > Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> > specified") removed the need to explictly setup the init_irq field in
> > the machine description when using only irqchip_init. Remove that
> > declaration for shmobile as well.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/mach-shmobile/setup-emev2.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
> > index 899a86c..66694e0 100644
> > --- a/arch/arm/mach-shmobile/setup-emev2.c
> > +++ b/arch/arm/mach-shmobile/setup-emev2.c
> > @@ -20,7 +20,6 @@
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> > -#include <linux/irqchip.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/platform_data/gpio-em.h>
> >  #include <linux/of_platform.h>
> > @@ -454,7 +453,6 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
> >  	.smp		= smp_ops(emev2_smp_ops),
> >  	.init_early	= emev2_init_delay,
> >  	.nr_irqs	= NR_IRQS_LEGACY,
> > -	.init_irq	= irqchip_init,
> >  	.init_machine	= emev2_add_standard_devices_dt,
> >  	.dt_compat	= emev2_boards_compat_dt,
> >  MACHINE_END
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Sorry, what I should have said is:

Queued up for v3.11 in the soc-emev2 branch of my renesas tree
on kernel.org. It is included in the renesas-next-20130515 tag of
that tree and should appear in linux-next in the not to distant future.
