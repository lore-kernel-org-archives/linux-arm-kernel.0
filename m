From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 11 Jul 2016 17:25:09 +0200
Subject: [GIT PULL 1/4] ARM: tegra: Core SoC changes for v4.8-rc1
Message-ID: <20160711152512.11731-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.8-arm-soc

for you to fetch changes up to da35cbcafad3d46daa96a6f01022f11842e8e7b6:

  ARM: tegra: Remove board_init_funcs array (2016-07-11 16:47:53 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Core SoC changes for v4.8-rc1

Some cleanups to eliminate sparse warnings and a section mismatch.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: tegra: Remove board_init_funcs array

Thierry Reding (4):
      ARM: tegra: hotplug: Include missing common.h
      ARM: tegra: cpuidle: Add missing cpuidle.h include
      ARM: tegra: irq: Add missing irq.h include
      ARM: tegra: pm: Add tegra_cpu_do_idle() prototype

 arch/arm/mach-tegra/common.h           | 22 ++++++++++++++++++++++
 arch/arm/mach-tegra/cpuidle-tegra114.c |  1 +
 arch/arm/mach-tegra/cpuidle-tegra20.c  |  1 +
 arch/arm/mach-tegra/cpuidle-tegra30.c  |  1 +
 arch/arm/mach-tegra/cpuidle.h          |  2 ++
 arch/arm/mach-tegra/hotplug.c          |  1 +
 arch/arm/mach-tegra/irq.c              |  1 +
 arch/arm/mach-tegra/pm.h               |  2 +-
 arch/arm/mach-tegra/tegra.c            | 24 +++---------------------
 9 files changed, 33 insertions(+), 22 deletions(-)
