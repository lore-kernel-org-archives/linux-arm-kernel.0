From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 7 Mar 2013 16:11:38 +0100
Subject: [GIT PULL] preparation patches for Cortex-M3
Message-ID: <20130307151138.GI15375@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

the following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git for-next

for you to fetch changes up to 6ebd4d038dbb626a43d87db3007e71f92f49d7b3:

  ARM: stub out read_cpuid and read_cpuid_ext for CPU_CP15=n (2013-01-31 21:44:48 +0100)

These are in next since next-20130213 without any problem reports.

I currently base my Cortex-M3 stuff on top of these. The complete series
still has some problems though that I have to debug first. I'd be glad
if you'd pull at least this series for 3.10.

Thanks
Uwe

----------------------------------------------------------------
Uwe Kleine-K?nig (5):
      ARM: make cr_alignment read-only #ifndef CONFIG_CPU_CP15
      ARM: let CPUs not being able to run in ARM mode enter in THUMB mode
      ARM: sync comments about available data abort models with the code
      ARM: use read_cpuid_id() instead of read_cpuid(CPUID_ID)
      ARM: stub out read_cpuid and read_cpuid_ext for CPU_CP15=n

 arch/arm/Kconfig               |  3 ++-
 arch/arm/include/asm/cp15.h    | 16 +++++++++++++++-
 arch/arm/include/asm/cputype.h | 31 +++++++++++++++++++++++++++----
 arch/arm/include/asm/glue-df.h | 20 ++++++++++----------
 arch/arm/kernel/head-common.S  |  9 +++++++--
 arch/arm/kernel/head-nommu.S   |  8 +++++++-
 arch/arm/kernel/setup.c        |  2 +-
 arch/arm/kernel/smp_scu.c      |  2 +-
 arch/arm/mach-omap2/id.c       |  4 ++--
 arch/arm/mach-omap2/omap-smp.c |  2 +-
 arch/arm/mm/Kconfig            |  9 ++++++++-
 arch/arm/mm/alignment.c        |  2 ++
 arch/arm/mm/mmu.c              | 17 +++++++++++++++++
 13 files changed, 100 insertions(+), 25 deletions(-)

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
