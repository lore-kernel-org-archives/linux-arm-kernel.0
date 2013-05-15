From: horms@verge.net.au (Simon Horman)
Date: Wed, 15 May 2013 10:46:04 +0900
Subject: [PATCH 05/20] ARM: shmobile: ape6evm: Remove init_irq
 declaration in machine description
In-Reply-To: <20130515005907.GD12246@verge.net.au>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368545933-7430-6-git-send-email-maxime.ripard@free-electrons.com>
 <20130515005907.GD12246@verge.net.au>
Message-ID: <20130515014604.GK12246@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 09:59:07AM +0900, Simon Horman wrote:
> On Tue, May 14, 2013 at 05:38:38PM +0200, Maxime Ripard wrote:
> > Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> > specified") removed the need to explictly setup the init_irq field in
> > the machine description when using only irqchip_init. Remove that
> > declaration for shmobile as well.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/mach-shmobile/board-ape6evm.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
> > index 55b8c9f..8dfbdba 100644
> > --- a/arch/arm/mach-shmobile/board-ape6evm.c
> > +++ b/arch/arm/mach-shmobile/board-ape6evm.c
> > @@ -20,7 +20,6 @@
> >  
> >  #include <linux/gpio.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/irqchip.h>
> >  #include <linux/kernel.h>
> >  #include <linux/pinctrl/machine.h>
> >  #include <linux/platform_device.h>
> > @@ -87,7 +86,6 @@ static const char *ape6evm_boards_compat_dt[] __initdata = {
> >  };
> >  
> >  DT_MACHINE_START(APE6EVM_DT, "ape6evm")
> > -	.init_irq	= irqchip_init,
> >  	.init_time	= shmobile_timer_init,
> >  	.init_machine	= ape6evm_add_standard_devices,
> >  	.dt_compat	= ape6evm_boards_compat_dt,
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Sorry, what I should have said is:

Queued up for v3.11 in the boards-spe6evm branch of my renesas tree
on kernel.org. It is included in the renesas-next-20130515 tag of
that tree and should appear in linux-next in the not to distant future.
