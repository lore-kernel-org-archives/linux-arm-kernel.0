From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jan 2012 16:12:25 +0000
Subject: [PATCH 1/2] ARM: logical_cpu_map: decouple CPU mapping from SMP
In-Reply-To: <4F144BDB.1090908@arm.com>
References: <1326728755-10133-1-git-send-email-will.deacon@arm.com>
 <4F144BDB.1090908@arm.com>
Message-ID: <20120116161225.GK9068@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 04:10:03PM +0000, Marc Zyngier wrote:
> On 16/01/12 15:45, Will Deacon wrote:
> > It turns out that the logical CPU mapping is useful even when !CONFIG_SMP
> > for manipulation of devices like interrupt and power controllers when
> > running a UP kernel on a CPU other than 0. This can happen when kexecing
> > a UP image from an SMP kernel.
> > 
> > In the future, multi-cluster systems running AMP configurations will
> > require something similar for mapping cluster IDs, so it makes sense to
> > decouple this logic in preparation for this support.
> > 
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Yang Bai <hamo.by@gmail.com>
> > Reported-by: Joerg Roedel <joerg.roedel@amd.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/common/gic.c               |    7 ++-----
> >  arch/arm/include/asm/smp.h          |    6 ------
> >  arch/arm/include/asm/smp_plat.h     |    6 ++++++
> >  arch/arm/kernel/setup.c             |   14 ++++++++++++++
> >  arch/arm/kernel/smp.c               |   14 --------------
> >  arch/arm/mach-exynos/hotplug.c      |    1 +
> >  arch/arm/mach-exynos/platsmp.c      |    1 +
> >  arch/arm/mach-highbank/highbank.c   |    3 +--
> >  arch/arm/mach-imx/src.c             |    5 +----
> >  arch/arm/mach-msm/hotplug.c         |    1 +
> >  arch/arm/mach-msm/platsmp.c         |    1 +
> >  arch/arm/mach-realview/hotplug.c    |    1 +
> >  arch/arm/mach-shmobile/smp-sh73a0.c |    1 +
> >  arch/arm/mach-ux500/hotplug.c       |    1 +
> >  arch/arm/mach-ux500/platsmp.c       |    1 +
> >  arch/arm/mach-vexpress/hotplug.c    |    1 +
> >  arch/arm/plat-versatile/platsmp.c   |    1 +
> >  17 files changed, 34 insertions(+), 31 deletions(-)
> 
> You may want to also add a #include <asm/smp_plat.h> to
> arch/arm/mach-shmobile/smp-r8a7779.c (a newcomer in Linus' tree).

Cheers Marc, I didn't spot this guy. I'll add that for v2.

> Otherwise:
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

Will
