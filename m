From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 2 Nov 2011 16:08:59 +0200
Subject: [PATCH v2 0/8] Add support for tegra30 and cardhu
Message-ID: <1320242948-21061-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the tegra30 SoC and the cardhu development
board.

Most important changes in v2:

* account for arch_reset cleanup
* seperate patch for renaming pinmux-t2.h and pinmux-t2-tables.c
* fixed bug in common cache initialization
* fixed compatibility with non DT boards (boottested on harmony)
* improved commit messages

Peter De Schrijver (8):
  arm/tegra: initial device tree for tegra30
  arm/tegra: prepare early init for multiple tegra variants
  arm/tegra: rename tegra20 pinmux files
  arm/tegra: prepare pinmux code for multiple tegra variants
  arm/tegra: add new fields to struct tegra_pingroup_desc
  arm/tegra: pinmux tables and definitions for tegra30
  arm/tegra: implement support for tegra30
  arm/tegra: add support for tegra30 based board cardhu

 arch/arm/boot/dts/tegra-cardhu.dts                |   37 ++
 arch/arm/boot/dts/tegra30.dtsi                    |  127 +++++++
 arch/arm/mach-tegra/Kconfig                       |   25 ++-
 arch/arm/mach-tegra/Makefile                      |    3 +-
 arch/arm/mach-tegra/Makefile.boot                 |    1 +
 arch/arm/mach-tegra/board-dt.c                    |   21 ++
 arch/arm/mach-tegra/board-harmony-pcie.c          |    1 +
 arch/arm/mach-tegra/board-harmony-pinmux.c        |    1 +
 arch/arm/mach-tegra/board-harmony.c               |    2 +-
 arch/arm/mach-tegra/board-paz00-pinmux.c          |    1 +
 arch/arm/mach-tegra/board-paz00.c                 |    2 +-
 arch/arm/mach-tegra/board-seaboard-pinmux.c       |    2 +-
 arch/arm/mach-tegra/board-seaboard.c              |    6 +-
 arch/arm/mach-tegra/board-trimslice-pinmux.c      |    1 +
 arch/arm/mach-tegra/board-trimslice.c             |    2 +-
 arch/arm/mach-tegra/board.h                       |    5 +-
 arch/arm/mach-tegra/common.c                      |   37 ++-
 arch/arm/mach-tegra/include/mach/pinmux-t2.h      |  184 ----------
 arch/arm/mach-tegra/include/mach/pinmux-tegra20.h |  184 ++++++++++
 arch/arm/mach-tegra/include/mach/pinmux-tegra30.h |  320 ++++++++++++++++++
 arch/arm/mach-tegra/include/mach/pinmux.h         |   93 +++++-
 arch/arm/mach-tegra/pinmux-t2-tables.c            |  228 -------------
 arch/arm/mach-tegra/pinmux-tegra20-tables.c       |  244 +++++++++++++
 arch/arm/mach-tegra/pinmux-tegra30-tables.c       |  376 +++++++++++++++++++++
 arch/arm/mach-tegra/pinmux.c                      |  153 ++++++---
 25 files changed, 1557 insertions(+), 499 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra-cardhu.dts
 create mode 100644 arch/arm/boot/dts/tegra30.dtsi
 delete mode 100644 arch/arm/mach-tegra/include/mach/pinmux-t2.h
 create mode 100644 arch/arm/mach-tegra/include/mach/pinmux-tegra20.h
 create mode 100644 arch/arm/mach-tegra/include/mach/pinmux-tegra30.h
 delete mode 100644 arch/arm/mach-tegra/pinmux-t2-tables.c
 create mode 100644 arch/arm/mach-tegra/pinmux-tegra20-tables.c
 create mode 100644 arch/arm/mach-tegra/pinmux-tegra30-tables.c

-- 
1.7.7.rc0.72.g4b5ea.dirty
