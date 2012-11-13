From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 Nov 2012 12:10:08 +0900
Subject: [GIT PULL] Renesas ARM-based SoC for v3.8 #4
Message-ID: <1352776212-3211-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following SoC fixes for 3.8.
Its a little embarrassing, but they all fix problems introduced
in previous pull-requests for 3.8 that have been merged.

* The three Revert patches back-out secondary CPU initialisation
  changes from Bastian Hecht which he as advised me are incorrect
  and break secondary CPU initialisation.

* The clkfwk patch from Morimoto-san resolves a build warning.

This pull-request is based on the renesas/soc3 branch in the arm-soc tree.

----------------------------------------------------------------
The following changes since commit d5b689089d7db3851c4d5d6b3727d22ef44d2023:

  ARM: shmobile: sh7372: sh7372_fsiXck_clk become non-global (2012-11-08 17:52:35 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc4

for you to fetch changes up to 94091c6b9498116abe3035137d8c3e707528efd0:

  sh: clkfwk: fixup unsed variable warning (2012-11-13 11:45:40 +0900)

----------------------------------------------------------------
Kuninori Morimoto (1):
      sh: clkfwk: fixup unsed variable warning

Simon Horman (3):
      Revert "ARM: shmobile: emev2: Replace modify_scu_cpu_psr with scu_power_mode"
      Revert "ARM: shmobile: sh73a0: Replace modify_scu_cpu_psr with scu_power_mode"
      Revert "ARM: shmobile: r8a7779: Replace modify_scu_cpu_psr with scu_power_mode"

 arch/arm/mach-shmobile/smp-emev2.c   |   22 ++++++++++++++++++++--
 arch/arm/mach-shmobile/smp-r8a7779.c |   25 ++++++++++++++++++++++---
 arch/arm/mach-shmobile/smp-sh73a0.c  |   23 +++++++++++++++++++++--
 drivers/sh/clk/cpg.c                 |    1 -
 4 files changed, 63 insertions(+), 8 deletions(-)
