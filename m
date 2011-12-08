From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 8 Dec 2011 14:43:43 +0200
Subject: [PATCH v6 00/10] Add support for tegra30 and cardhu
Message-ID: <1323348254-29072-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the tegra30 SoC and the cardhu development
board.

Patchset is on top of linux-next and
http://www.spinics.net/lists/linux-tegra/msg03016.html.

Most important changes in v6:

* Align with latest version of the ARM restart implementation
* Address comments on tegra_sdmmc_tap_delay()
* Fix git bisection breakage for 'arm/tegra: implement support for tegra30'

Most important changes in v5:

* use devicetree binding for GIC
* define a seperate machine for tegra30
* add documentation for tegra devicetree compatible definitions

Most important changes in v4:

* cleanup clock code to work on multiple tegra variants
* added dependencies to avoid building tegra20 only code for tegra30

Most important changes in v3:

* align with ARM restart rework. might need a bit of rework to merge with the
  latest version of this.
* minor cleanups and reformats

Most important changes in v2:

* account for arch_reset cleanup
* seperate patch for renaming pinmux-t2.h and pinmux-t2-tables.c                                                                                               
* fixed bug in common cache initialization
* fixed compatibility with non DT boards (boottested on harmony)
* improved commit messages

Peter De Schrijver (10):
  arm/tegra: initial device tree for tegra30
  arm/tegra: cleanup tegra20 support
  arm/tegra: prepare clock code for multiple tegra variants
  arm/tegra: prepare early init for multiple tegra variants
  arm/tegra: rename tegra20 pinmux files
  arm/tegra: prepare pinmux code for multiple tegra variants
  arm/tegra: add new fields to struct tegra_pingroup_desc
  arm/tegra: pinmux tables and definitions for tegra30
  arm/tegra: implement support for tegra30
  arm/tegra: add support for tegra30 based board cardhu

 Documentation/devicetree/bindings/arm/tegra.txt   |   14 +
 arch/arm/boot/dts/tegra-cardhu.dts                |   36 ++
 arch/arm/boot/dts/tegra30.dtsi                    |  127 +++++++
 arch/arm/mach-tegra/Kconfig                       |   33 ++-
 arch/arm/mach-tegra/Makefile                      |    6 +-
 arch/arm/mach-tegra/Makefile.boot                 |    1 +
 arch/arm/mach-tegra/board-dt.c                    |   28 ++-
 arch/arm/mach-tegra/board-harmony-pcie.c          |    1 +
 arch/arm/mach-tegra/board-harmony-pinmux.c        |    1 +
 arch/arm/mach-tegra/board-harmony.c               |    2 +-
 arch/arm/mach-tegra/board-paz00-pinmux.c          |    1 +
 arch/arm/mach-tegra/board-paz00.c                 |    2 +-
 arch/arm/mach-tegra/board-seaboard-pinmux.c       |    2 +-
 arch/arm/mach-tegra/board-seaboard.c              |    6 +-
 arch/arm/mach-tegra/board-trimslice-pinmux.c      |    1 +
 arch/arm/mach-tegra/board-trimslice.c             |    2 +-
 arch/arm/mach-tegra/board.h                       |    3 +-
 arch/arm/mach-tegra/clock.c                       |   17 +-
 arch/arm/mach-tegra/clock.h                       |    8 +-
 arch/arm/mach-tegra/common.c                      |   40 ++-
 arch/arm/mach-tegra/include/mach/irqs.h           |    2 -
 arch/arm/mach-tegra/include/mach/pinmux-t2.h      |  184 ----------
 arch/arm/mach-tegra/include/mach/pinmux-tegra20.h |  184 ++++++++++
 arch/arm/mach-tegra/include/mach/pinmux-tegra30.h |  320 ++++++++++++++++++
 arch/arm/mach-tegra/include/mach/pinmux.h         |   88 ++++-
 arch/arm/mach-tegra/pinmux-t2-tables.c            |  228 -------------
 arch/arm/mach-tegra/pinmux-tegra20-tables.c       |  244 +++++++++++++
 arch/arm/mach-tegra/pinmux-tegra30-tables.c       |  376 +++++++++++++++++++++
 arch/arm/mach-tegra/pinmux.c                      |  153 ++++++---
 arch/arm/mach-tegra/tegra2_clocks.c               |   14 +-
 arch/arm/mach-tegra/timer.c                       |   12 +-
 31 files changed, 1597 insertions(+), 539 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra.txt
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
