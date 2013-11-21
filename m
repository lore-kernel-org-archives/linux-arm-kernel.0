From: horms@verge.net.au (Simon Horman)
Date: Thu, 21 Nov 2013 15:58:23 +0900
Subject: [PATCH v2] ARM: shmobile: Use ->init_late() on Lager
In-Reply-To: <20131121045536.GT31130@verge.net.au>
References: <20131120000231.27016.39549.sendpatchset@w520>
 <20131121045536.GT31130@verge.net.au>
Message-ID: <20131121065821.GA4753@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 01:55:37PM +0900, Simon Horman wrote:
> On Wed, Nov 20, 2013 at 09:02:31AM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Hook in shmobile_init_late() on Lager V2. This enables some PM
> > related things like CPUIdle and Suspend-to-RAM.
> > 
> > With this patch applied it is possible to use Suspend-to-RAM:
> > # echo enabled > /sys/class/tty/ttySC6/power/wakeup
> > # echo mem > /sys/power/state 
> > (wake by sending a character on the serial console)
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > ---
> > 
> >  Changes since V1:
> >  - added missing include <mach/common.h> to DT reference code
> > 
> >  Written on top of renesas.git renesas-devel-v3.12-20131119
> > 
> >  arch/arm/mach-shmobile/board-lager-reference.c |    2 ++
> >  arch/arm/mach-shmobile/board-lager.c           |    1 +
> >  2 files changed, 3 insertions(+)
> > 
> > --- 0001/arch/arm/mach-shmobile/board-lager-reference.c
> > +++ work/arch/arm/mach-shmobile/board-lager-reference.c	2013-11-20 08:14:45.000000000 +0900
> > @@ -20,6 +20,7 @@
> >  
> >  #include <linux/init.h>
> >  #include <linux/of_platform.h>
> > +#include <mach/common.h>
> >  #include <mach/rcar-gen2.h>
> >  #include <mach/r8a7790.h>
> >  #include <asm/mach/arch.h>
> > @@ -41,5 +42,6 @@ DT_MACHINE_START(LAGER_DT, "lager")
> >  	.init_early	= r8a7790_init_early,
> >  	.init_time	= rcar_gen2_timer_init,
> >  	.init_machine	= lager_add_standard_devices,
> > +	.init_late	= shmobile_init_late,
> >  	.dt_compat	= lager_boards_compat_dt,
> >  MACHINE_END
> > --- 0001/arch/arm/mach-shmobile/board-lager.c
> > +++ work/arch/arm/mach-shmobile/board-lager.c	2013-11-20 08:14:34.000000000 +0900
> > @@ -259,5 +259,6 @@ DT_MACHINE_START(LAGER_DT, "lager")
> >  	.init_early	= r8a7790_init_early,
> >  	.init_time	= rcar_gen2_timer_init,
> >  	.init_machine	= lager_init,
> > +	.init_late	= shmobile_init_late,
> >  	.dt_compat	= lager_boards_compat_dt,
> >  MACHINE_END
> 
> 
> Thanks. I have manually applied the following onto the soc3 branch.
> Please check that it is correct.
> 
> Assuming all goes will I plan to push this and other updates
> today or tomorrow.

Take II: I have applied your patch as is without any manual intervention.
