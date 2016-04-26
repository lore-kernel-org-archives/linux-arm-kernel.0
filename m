From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Apr 2016 11:28:38 +1000
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC R-Car SYSC Updates
 for v4.7
Message-ID: <cover.1461632180.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC R-Car SYSC
updates for v4.7.

This pull request is based on a merge of:

* Thee previous round of such requests, tagged as renesas-rcar-sysc-for-v4.7,
  which you have previously pulled.
* The clk-renesas-for-v4.7-tag2 tag of Geert Uytterhoeven's renesas-drivers
  tree which has been accepted into clk-next by Stephen Boyd.

There are follow-up DT changes that depend on this driver which I plan to
send in a pull-request for in the near future.


The following changes since commit a93fed0956bef9e4df420aa181198d86d347895d:

  Merge tag 'clk-renesas-for-v4.7-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into rcar-sysc-for-v4.7 (2016-04-22 17:22:21 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-rcar-sysc2-for-v4.7

for you to fetch changes up to 23f1e2ecdecee9f2ec45de0a468b82bb1f7f3ca2:

  soc: renesas: rcar-sysc: Add support for R-Car H3 power areas (2016-04-26 09:56:38 +1000)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC R-Car SYSC Updates for v4.7

Introduce a DT-based driver for the R-Car System Controller, as found on
Renesas R-Car H1, R-Car Gen2, and R-Car Gen3 SoCs.

----------------------------------------------------------------
Geert Uytterhoeven (11):
      soc: renesas: Move pm-rcar to drivers/soc/renesas/rcar-sysc
      soc: renesas: rcar-sysc: Improve rcar_sysc_power() debug info
      soc: renesas: rcar-sysc: Add DT support for SYSC PM domains
      soc: renesas: rcar-sysc: Make rcar_sysc_power_is_off() static
      soc: renesas: rcar-sysc: Enable Clock Domain for I/O devices
      soc: renesas: rcar-sysc: Add support for R-Car H1 power areas
      soc: renesas: rcar-sysc: Add support for R-Car H2 power areas
      soc: renesas: rcar-sysc: Add support for R-Car M2-W power areas
      soc: renesas: rcar-sysc: Add support for R-Car M2-N power areas
      soc: renesas: rcar-sysc: Add support for R-Car E2 power areas
      soc: renesas: rcar-sysc: Add support for R-Car H3 power areas

 MAINTAINERS                                        |   4 +
 arch/arm/mach-shmobile/Kconfig                     |  11 +-
 arch/arm/mach-shmobile/Makefile                    |   1 -
 arch/arm/mach-shmobile/pm-r8a7779.c                |   3 +-
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |   2 +-
 arch/arm/mach-shmobile/pm-rcar.c                   | 164 ---------
 arch/arm/mach-shmobile/smp-r8a7779.c               |   2 +-
 arch/arm/mach-shmobile/smp-r8a7790.c               |   2 +-
 drivers/soc/Makefile                               |   3 +-
 drivers/soc/renesas/Makefile                       |   7 +
 drivers/soc/renesas/r8a7779-sysc.c                 |  34 ++
 drivers/soc/renesas/r8a7790-sysc.c                 |  48 +++
 drivers/soc/renesas/r8a7791-sysc.c                 |  33 ++
 drivers/soc/renesas/r8a7794-sysc.c                 |  33 ++
 drivers/soc/renesas/r8a7795-sysc.c                 |  56 +++
 drivers/soc/renesas/rcar-sysc.c                    | 401 +++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.h                    |  58 +++
 .../linux/soc/renesas/rcar-sysc.h                  |   9 +-
 18 files changed, 690 insertions(+), 181 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/pm-rcar.c
 create mode 100644 drivers/soc/renesas/Makefile
 create mode 100644 drivers/soc/renesas/r8a7779-sysc.c
 create mode 100644 drivers/soc/renesas/r8a7790-sysc.c
 create mode 100644 drivers/soc/renesas/r8a7791-sysc.c
 create mode 100644 drivers/soc/renesas/r8a7794-sysc.c
 create mode 100644 drivers/soc/renesas/r8a7795-sysc.c
 create mode 100644 drivers/soc/renesas/rcar-sysc.c
 create mode 100644 drivers/soc/renesas/rcar-sysc.h
 rename arch/arm/mach-shmobile/pm-rcar.h => include/linux/soc/renesas/rcar-sysc.h (60%)
