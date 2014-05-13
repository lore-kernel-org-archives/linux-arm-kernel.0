From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 May 2014 09:59:36 +0900
Subject: [PATCH 00/03] ARM: shmobile: Use shmobile_init_delay() on r8a7791
In-Reply-To: <1509906.x9u0HJ6AbJ@avalon>
References: <20140511232508.20177.11556.sendpatchset@w520>
 <1509906.x9u0HJ6AbJ@avalon>
Message-ID: <20140513005936.GB30252@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 10:00:08PM +0200, Laurent Pinchart wrote:
> Hi Magnus,
> 
> On Monday 12 May 2014 08:25:08 Magnus Damm wrote:
> > ARM: shmobile: Use shmobile_init_delay() on r8a7791
> > 
> > [PATCH 01/03] ARM: shmobile: Use r8a7791 DT CPU Frequency in common case
> > [PATCH 02/03] ARM: shmobile: Use r8a7791 DT CPU Frequency for Koelsch
> > [PATCH 03/03] ARM: shmobile: Remove unused r8a7791_init_early()
> > 
> > Convert r8a7791 to rely on shmobile_init_delay() instead of using a per-SoC
> > delay setup function.
> 
> I'm afraid this patch set causes a boot time and CPU load regression on 
> Koelsch. With Simon's latest devel branch which has the patches applied, the 
> kernel boot time (using koelsch_defconfig) up to the point where the kernel 
> tries to connect to the DHCP server is 17.898437s. The CPU load (as reported 
> by top) on an idle system is then around 33%, spent in [kworker/0:1]. If I 
> revert the patches the same time goes down to 1.921875s and the CPU load on an 
> idle system is close to 0.

Thanks for checking this Laurent.
I have this and the (related to my eyes) r8a7740 changes in their own
branch. For now I will leave it in next but refrain from sending a
pull-request. I will drop it from next if the problem hasn't been resolved
in time for rc6 (which seems likely).

> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> > ---
> > 
> >  Written against renesas-devel-v3.15-rc5-20140511
> > 
> >  arch/arm/mach-shmobile/board-koelsch-reference.c |    2 +-
> >  arch/arm/mach-shmobile/board-koelsch.c           |    2 +-
> >  arch/arm/mach-shmobile/include/mach/r8a7791.h    |    1 -
> >  arch/arm/mach-shmobile/setup-r8a7791.c           |    9 +--------
> >  4 files changed, 3 insertions(+), 11 deletions(-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
