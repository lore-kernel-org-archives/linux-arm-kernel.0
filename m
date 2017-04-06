From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  7 Apr 2017 01:10:19 +0200
Subject: [GIT PULL 3/4] soc/tegra: Core SoC changes for v4.12-rc1
In-Reply-To: <20170406231020.32048-1-thierry.reding@gmail.com>
References: <20170406231020.32048-1-thierry.reding@gmail.com>
Message-ID: <20170406231020.32048-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.12-soc

for you to fetch changes up to 1fd09e5d884a5ff4060948e0cf8f5d7eed16e936:

  soc/tegra: Add initial flowctrl support for Tegra132/210 (2017-04-04 15:52:31 +0200)

Thanks,
Thierry

----------------------------------------------------------------
soc/tegra: Core SoC changes for v4.12-rc1

This contains PMC support for Tegra186 as well as a proper driver for
the flow controller found on SoCs up to Tegra210. This also turns the
fuse driver into an explicitly non-modular driver.

----------------------------------------------------------------
Arnd Bergmann (1):
      soc/tegra: Fix link errors with PMC disabled

Jon Hunter (4):
      ARM: tegra: Remove unnecessary inclusion of flowctrl header
      soc/tegra: Move Tegra flowctrl driver
      soc/tegra: flowctrl: Add basic platform driver
      soc/tegra: Add initial flowctrl support for Tegra132/210

Paul Gortmaker (1):
      soc: tegra: make fuse-tegra explicitly non-modular

Thierry Reding (1):
      soc/tegra: Implement Tegra186 PMC support

 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  34 +++++
 arch/arm/mach-tegra/Makefile                       |   1 -
 arch/arm/mach-tegra/cpuidle-tegra20.c              |   3 +-
 arch/arm/mach-tegra/platsmp.c                      |   2 +-
 arch/arm/mach-tegra/pm.c                           |   2 +-
 arch/arm/mach-tegra/reset-handler.S                |   2 +-
 arch/arm/mach-tegra/sleep-tegra20.S                |   3 +-
 arch/arm/mach-tegra/sleep-tegra30.S                |   2 +-
 arch/arm/mach-tegra/sleep.S                        |   2 -
 arch/arm/mach-tegra/tegra.c                        |   2 -
 drivers/soc/tegra/Kconfig                          |  22 +++
 drivers/soc/tegra/Makefile                         |   4 +-
 .../mach-tegra => drivers/soc/tegra}/flowctrl.c    |  87 ++++++++---
 drivers/soc/tegra/fuse/fuse-tegra.c                |   4 +-
 drivers/soc/tegra/pmc-tegra186.c                   | 169 +++++++++++++++++++++
 .../mach-tegra => include/soc/tegra}/flowctrl.h    |  32 +++-
 include/soc/tegra/pmc.h                            |  29 +++-
 17 files changed, 353 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
 rename {arch/arm/mach-tegra => drivers/soc/tegra}/flowctrl.c (67%)
 create mode 100644 drivers/soc/tegra/pmc-tegra186.c
 rename {arch/arm/mach-tegra => include/soc/tegra}/flowctrl.h (77%)
