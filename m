From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 16 Jun 2017 18:19:51 +0200
Subject: [GIT PULL] ARM: at91: SoC for 4.13
Message-ID: <20170616161951.c4gwpk3wgpic7kpp@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Arnd, Olof,

Our now unusually large update for AT91 SoCs, introducing surpport for
three new families of SoCs, cortex M7 based and a new deep suspend mode
for sama5d2.

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.13-soc

for you to fetch changes up to 8a3d809373c6790b3958f74fa5640aedd4e804dd:

  ARM: at91: remove atmel_nand_data (2017-06-13 15:41:28 +0200)

----------------------------------------------------------------
SoC for 4.13:

 - New suspend/resume mode for sama5d2
 - Initial support for armv7m based SoCs

----------------------------------------------------------------
Alexandre Belloni (7):
      ARM: at91: pm: Add sama5d2 backup mode
      ARM: at91: pm: allow selecting standby and suspend modes
      ARM: at91: pm: fallback to slowclock when backup mode fails
      ARM: at91: Documentation: add armv7m families
      ARM: at91: Document armv7m compatibles
      ARM: at91: handle CONFIG_PM for armv7m configurations
      ARM: at91: remove atmel_nand_data

Arnd Bergmann (1):
      ARM: at91: fix at91_suspend_entering_slow_clock link error

Szemz? Andr?s (3):
      ARM: at91: Add armv7m support
      ARM: at91: add armv7m SoC detection
      ARM: at91: debug: add samv7x support

 Documentation/arm/Atmel/README                     |  38 +++-
 .../devicetree/bindings/arm/atmel-at91.txt         |  30 +++
 arch/arm/Kconfig.debug                             |  10 +
 arch/arm/mach-at91/Kconfig                         |  16 +-
 arch/arm/mach-at91/Makefile                        |   4 +-
 arch/arm/mach-at91/Makefile.boot                   |   3 +
 arch/arm/mach-at91/generic.h                       |   2 +
 arch/arm/mach-at91/pm.c                            | 206 ++++++++++++++++++---
 arch/arm/mach-at91/pm.h                            |   5 +
 arch/arm/mach-at91/pm_data-offsets.c               |   3 +
 arch/arm/mach-at91/pm_suspend.S                    |  73 ++++++--
 arch/arm/mach-at91/sama5.c                         |  19 +-
 arch/arm/mach-at91/samv7.c                         |  25 +++
 drivers/soc/atmel/soc.c                            |  24 +++
 drivers/soc/atmel/soc.h                            |  26 +++
 include/linux/platform_data/atmel.h                |  28 +--
 16 files changed, 439 insertions(+), 73 deletions(-)
 create mode 100644 arch/arm/mach-at91/Makefile.boot
 create mode 100644 arch/arm/mach-at91/samv7.c

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
