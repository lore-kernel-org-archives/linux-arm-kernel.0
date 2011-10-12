From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Oct 2011 16:34:07 -0700
Subject: [GIT PULL] Please pull tegra cleanups for 3.2
Message-ID: <CAOesGMjVAJK2ArOdpYNmKa11vqCfppi8Ofc0qGn4WxuMxLvd_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the below branch of cleanups for the 3.2 merge window.
They have been included in linux-next for a couple of days already.

Thanks!


-Olof

The following changes since commit 976d167615b64e14bc1491ca51d424e2ba9a5e84:

  Linux 3.1-rc9 (2011-10-04 18:11:50 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.2/cleanup

Olof Johansson (14):
      ARM: tegra: annotate IO_*_VIRT pointers
      ARM: tegra: timer: don't cast __iomem pointers
      ARM: tegra: tegra2_clocks: don't cast __iomem pointers
      ARM: tegra: tegra2_clocks: 0 -> NULL changes
      ARM: tegra: pcie: don't cast __iomem pointers
      ARM: tegra: pcie: include board.h
      ARM: tegra: pcie: 0 -> NULL changes
      ARM: tegra: tegra_init_cache should be static
      ARM: tegra: tegra_rtc_read_ms should be static
      ARM: tegra: tegra_powergate_is_powered should be static
      ARM: tegra: tegra2_clocks: don't export some tables
      ARM: tegra: dma: staticify some tables and functions
      ARM: tegra: cpu-tegra: sparse type fix
      ARM: tegra: cpu-tegra: unexport two functions

 arch/arm/mach-tegra/common.c                 |    2 +-
 arch/arm/mach-tegra/cpu-tegra.c              |    6 ++--
 arch/arm/mach-tegra/dma.c                    |   14 +++++---
 arch/arm/mach-tegra/include/mach/io.h        |   18 ++++++---
 arch/arm/mach-tegra/include/mach/powergate.h |    1 -
 arch/arm/mach-tegra/io.c                     |    8 ++--
 arch/arm/mach-tegra/pcie.c                   |    8 +++--
 arch/arm/mach-tegra/powergate.c              |    5 +--
 arch/arm/mach-tegra/tegra2_clocks.c          |   50 +++++++++++++-------------
 arch/arm/mach-tegra/timer.c                  |    6 ++--
 10 files changed, 64 insertions(+), 54 deletions(-)
