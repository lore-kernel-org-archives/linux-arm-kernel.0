From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Apr 2017 18:56:42 +0200
Subject: [GIT PULL] ARM: at91: soc for 4.12
Message-ID: <20170410165642.jt4bucl2zwk26orm@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is a huge cleanup of the PM code in order to prepare support for a
new suspend mode on sama5d2.

Note that as discussed with Arnd, the first two patches are fixes that
are already upstream since v4.11-rc4. The rest of the pull request
depends on them.

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.12-soc

for you to fetch changes up to b32de9dd38fcf9063e993dcdd64cc64ad344d3ac:

  ARM: at91: move SoC detection to its own driver (2017-03-31 20:36:10 +0200)

----------------------------------------------------------------
SoC for 4.12:

 - huge PM cleanup
 - Move SoC detection to its own driver

----------------------------------------------------------------
Alexandre Belloni (14):
      MAINTAINERS: Update AT91 entry
      MAINTAINERS: Add memory drivers to AT91 entry
      ARM: at91: pm: Cleanup headers
      ARM: at91: pm: Move at91_ramc_read/write to pm.c
      ARM: at91: pm: Move global variables into at91_pm_data
      ARM: at91: pm: Use struct at91_pm_data in pm_suspend.S
      ARM: at91: pm: Simplify at91rm9200_standby
      ARM: at91: pm: Workaround DDRSDRC self-refresh bug with LPDDR1 memories.
      ARM: at91: pm: Tie the memory controller type to the ramc id
      ARM: at91: pm: Tie the USB clock mask to the pmc
      ARM: at91: pm: Merge all at91sam9*_pm_init
      ARM: at91: pm: Remove at91_pm_set_standby
      ARM: at91: pm: correct typo
      ARM: at91: move SoC detection to its own driver

Nicolas Ferre (1):
      ARM: at91: pm: cpu_idle: switch DDR to power-down mode

Romain Izard (1):
      Revert "ARM: at91/dt: sama5d2: Use new compatible for ohci node"

 MAINTAINERS                                     |   2 +-
 arch/arm/boot/dts/sama5d2.dtsi                  |   2 +-
 arch/arm/mach-at91/Makefile                     |  34 +++-
 arch/arm/mach-at91/at91rm9200.c                 |  15 +-
 arch/arm/mach-at91/at91sam9.c                   |  91 +---------
 arch/arm/mach-at91/generic.h                    |   8 +-
 arch/arm/mach-at91/pm.c                         | 215 +++++++++++-----------
 arch/arm/mach-at91/pm.h                         |  24 +--
 arch/arm/mach-at91/pm_data-offsets.c            |  13 ++
 arch/arm/mach-at91/pm_suspend.S                 |  31 ++--
 arch/arm/mach-at91/sama5.c                      |  52 +-----
 arch/arm/mach-at91/soc.c                        | 142 ---------------
 drivers/soc/Kconfig                             |   1 +
 drivers/soc/Makefile                            |   1 +
 drivers/soc/atmel/Kconfig                       |   6 +
 drivers/soc/atmel/Makefile                      |   1 +
 drivers/soc/atmel/soc.c                         | 231 ++++++++++++++++++++++++
 {arch/arm/mach-at91 => drivers/soc/atmel}/soc.h |   0
 18 files changed, 433 insertions(+), 436 deletions(-)
 create mode 100644 arch/arm/mach-at91/pm_data-offsets.c
 delete mode 100644 arch/arm/mach-at91/soc.c
 create mode 100644 drivers/soc/atmel/Kconfig
 create mode 100644 drivers/soc/atmel/Makefile
 create mode 100644 drivers/soc/atmel/soc.c
 rename {arch/arm/mach-at91 => drivers/soc/atmel}/soc.h (100%)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
