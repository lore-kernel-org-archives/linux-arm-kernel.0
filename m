From: horms@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 17:46:38 +0900
Subject: [PATCH] ARM: shmobile: marzen: Switch to DT_MACHINE_START
In-Reply-To: <20130724073952.GD17045@verge.net.au>
References: <20130724073042.28351.33041.sendpatchset@w520>
 <20130724073952.GD17045@verge.net.au>
Message-ID: <20130724084637.GA5774@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 04:39:53PM +0900, Simon Horman wrote:
> On Wed, Jul 24, 2013 at 04:30:42PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Convert the marzen board to use DT_MACHINE_START. With this in
> > place all mach-shmobile boards use DT_MACHINE_START. Also, this
> > makes it possible for the r8a7779 SMP code to use DT for CPUs.
> > 
> > So appended DTB is the way forward on this board.
> 
> Please supply a patch to update the defconfig accordingly.

In the course of testing this patch I created
a patch to update the defconfig. I will post it with
a patch to use DT for SMP but I have some questions about this patch.

It seems to me that the following is also needed:

* Select USE_OF in Kconfig
* Provide dt_compat in DT_MACHINE_START
* Provide r8a7779-marzen dts

I have a revised version of this patch which does the above.
But I wanted to check with you that I am on the right track
before posting it.


Also, I think that once sh73a0 and r8a7779 uses DT for SMP we can remove
shmobile_smp_init_cpus(). As you have posted a patch for sh73a0 I have
prepated a patch for r8a7779 I have also prepared a patch to remove
shmobile_smp_init_cpus().

My plan is to post all relevant patches as a series once
my questions above are resolved.

> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > ---
> > 
> >  Written on top of renesas-devel-20130724
> > 
> >  arch/arm/mach-shmobile/board-marzen.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- 0001/arch/arm/mach-shmobile/board-marzen.c
> > +++ work/arch/arm/mach-shmobile/board-marzen.c	2013-07-24 15:45:39.000000000 +0900
> > @@ -238,7 +238,7 @@ static void __init marzen_init(void)
> >  	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
> >  }
> >  
> > -MACHINE_START(MARZEN, "marzen")
> > +DT_MACHINE_START(MARZEN, "marzen")
> >  	.smp		= smp_ops(r8a7779_smp_ops),
> >  	.map_io		= r8a7779_map_io,
> >  	.init_early	= r8a7779_add_early_devices,
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
