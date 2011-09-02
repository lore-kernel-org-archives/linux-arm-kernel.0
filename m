From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Sep 2011 14:26:55 +0100
Subject: [GIT PULL] CPU mapping platform updates for 3.2
In-Reply-To: <alpine.LFD.2.00.1109020908250.20358@xanadu.home>
References: <20110901211107.GB5209@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1109012331010.20358@xanadu.home>
	<20110902083817.GA11728@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1109020908250.20358@xanadu.home>
Message-ID: <20110902132655.GA19288@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2011 at 02:13:09PM +0100, Nicolas Pitre wrote:
> On Fri, 2 Sep 2011, Will Deacon wrote:
> > D'oh, I thought this might happen. The problem I have is that my core
> > patches depend on one from Vincent Guittot ("ARM: 7011/1: Add ARM cpu
> > topology definition"), so I ended up sending my changes via Russell's patch
> > system.
> > 
> > How about I cherry pick Vincent's patch and my core changes out of next and
> > use that as a base (on top of -rc4)?
> 
> I would instead suggest that you simply use commit c2b9ab71c6 as your 
> base.  It is more likely to remain stable, unlike the top commit in the 
> for-next branch.

Ok, that's easy enough, thanks for the help.

> Cherry-picking needed commits would work, but they would end up being 
> duplicated in two different branches in the final Git history.  Git can 
> cope with that of course, but this is usually something we try to avoid 
> as this could create some confusion for people.

Understood. Here's the new pull request...

Will


The following changes since commit c2b9ab71c6e6cf8c48c5f8fda47cd10879c5c7db:
  Will Deacon (1):
        ARM: 7061/1: gic: convert logical CPU numbers into physical numbers

are available in the git repository at:

  git://linux-arm.org/linux-2.6-wd.git for-arnd

Will Deacon (5):
      ARM: exynos4: convert logical CPU numbers to physical numbers
      ARM: msm: convert logical CPU numbers to physical numbers
      ARM: shmobile: convert logical CPU numbers to physical numbers
      ARM: ux500: convert logical CPU numbers to physical numbers
      ARM: versatile: convert logical CPU numbers to physical numbers

 arch/arm/mach-exynos4/hotplug.c     |    2 +-
 arch/arm/mach-exynos4/platsmp.c     |    2 +-
 arch/arm/mach-msm/hotplug.c         |    2 +-
 arch/arm/mach-msm/platsmp.c         |    2 +-
 arch/arm/mach-realview/hotplug.c    |    2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c |    6 +++++-
 arch/arm/mach-ux500/hotplug.c       |    2 +-
 arch/arm/mach-ux500/platsmp.c       |    2 +-
 arch/arm/mach-vexpress/hotplug.c    |    2 +-
 arch/arm/plat-versatile/platsmp.c   |    2 +-
 10 files changed, 14 insertions(+), 10 deletions(-)
