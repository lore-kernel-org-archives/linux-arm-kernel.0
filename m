From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  2 Nov 2011 17:30:47 +0000
Subject: [PATCH 0/2] PPI fixes for 3.2
Message-ID: <1320255049-12447-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the merge of the percpu interrupt patches, a couple of platforms
need to be updated:
- Samsung MCT timers have gained a PPI implementation using the old
  API,
- imx6q needs to be updated not to care about local timer interrupts
  anymore.

The patches are also available at the following location:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git ppi-fixes-for-3.2

Thanks,

	M.

Marc Zyngier (2):
  ARM: EXYNOS4: convert MCT to percpu interrupt API
  ARM: mcx: fix local timer interrupt handling

 arch/arm/mach-exynos4/mct.c |   40 +++++++++++++++++++++++++++-------------
 arch/arm/plat-mxc/gic.c     |   11 ++---------
 2 files changed, 29 insertions(+), 22 deletions(-)
