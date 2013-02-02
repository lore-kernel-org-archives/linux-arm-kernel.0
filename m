From: robherring2@gmail.com (Rob Herring)
Date: Sat, 02 Feb 2013 09:05:58 -0600
Subject: [GIT PULL] More highbank fixes for 3.8
Message-ID: <510D2B56.1010709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please pull these fixes needed for highbank. Secondary core boot is
broken when using an updated DT with correct cpu cluster id.

Rob

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git tags/highbank-fixes-for-3.8

for you to fetch changes up to 63fc1370c19052fa5bec9593557431efc7ecc9fe:

  ARM: highbank: mask cluster id from cpu_logical_map (2013-01-31
13:54:30 -0600)

----------------------------------------------------------------
highbank fixes for 3.8

-Compile fix for !SMP
-More cpu cluster id related fixes

----------------------------------------------------------------
Rob Herring (3):
      ARM: scu: add empty scu_enable for !CONFIG_SMP
      ARM: scu: mask cluster id from cpu_logical_map
      ARM: highbank: mask cluster id from cpu_logical_map

 arch/arm/include/asm/smp_scu.h    |    8 +++++++-
 arch/arm/kernel/smp_scu.c         |    2 +-
 arch/arm/mach-highbank/highbank.c |    3 ++-
 arch/arm/mach-highbank/sysregs.h  |    4 ++--
 4 files changed, 12 insertions(+), 5 deletions(-)
