From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Apr 2015 23:11:13 -0700
Subject: [GIT PULL 6/9] ARM: SoC multiplatform code changes for v4.1
In-Reply-To: <1429683076-19881-1-git-send-email-olof@lixom.net>
References: <1429683076-19881-1-git-send-email-olof@lixom.net>
Message-ID: <1429683076-19881-7-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The changes here belong to two main platforms:

- Atmel At91 is flipping the bit and going multiplatform. This includes some
cleanups and removal of code, and the final flip of config dependencies

- Shmobile has several platforms that are going multiplatform, but this
branch also contains a bunch of cleanups that they weren't able to keep
separate in a good way. THere's also a removal of one of their SoCs and the
corresponding boards (sh7372 and mackerel).


Conflicts:
arch/arm/mach-shmobile/pm-sh7372.c:
Had a fix in 4.0, removed here. Remove the file.

----------------------------------------------------------------

The following changes since commit 736e98059cd3d0069042edfe594834ce48273072:

  Merge tag 'armsoc-drivers' into testmerge

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-multiplatform

for you to fetch changes up to 89522f0f8bd5056dec21bb7de073cbd5886e435c:

  Merge tag 'at91-cleanup4_bis' of git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91 into next/multiplatform

----------------------------------------------------------------

Alexandre Belloni (10):
      ARM: at91: switch to multiplatform
      ARM: at91: switch at91_dt_defconfig to multiplatform
      ARM: at91: remove unused headers
      ARM: at91: remove useless mach/cpu.h
      ARM: at91: remove SoC headers
      ARM: at91: remove hardware.h
      ARM: at91: drop AT91_TIMER_HZ
      ARM: at91: fix pm_suspend.S compilation when ARMv6 is selected
      ARM: at91/pm: move the standby functions to pm.c
      ARM: at91/pm: move AT91_MEMCTRL_* to pm.h

Arnd Bergmann (4):
      Merge tag 'renesas-soc-cleanup-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/multiplatform
      Merge tag 'renesas-sh7372-soc-removal-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/multiplatform
      Merge tag 'renesas-r8a7778-ccf-and-multiplatform-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/multiplatform
      Merge tag 'at91-cleanup4_bis' of git://git.kernel.org/.../nferre/linux-at91 into next/multiplatform

Geert Uytterhoeven (12):
      ARM: shmobile: r8a73a4 dtsi: Add Bus State Controller node
      ARM: shmobile: ape6evm dts: Move Ethernet node to BSC
      ARM: shmobile: r8a73a4: Move pfc node to work around probe ordering bug
      ARM: shmobile: ape6evm dts: Drop console= bootargs parameter
      PM / Domains: R-Mobile SYSC: Document R-Mobile APE6 (r8a73a4) binding
      ARM: shmobile: sh73a0 dtsi: Add Bus State Controller node
      ARM: shmobile: kzm9g dts: Move Ethernet node to BSC
      ARM: shmobile: sh73a0 dtsi: Add Cortex-A9 TWD node
      ARM: shmobile: sh73a0: Remove unused sh73a0_add_standard_devices_dt()
      ARM: shmobile: sh73a0 dtsi: Add PM domain support
      ARM: shmobile: sh73a0: Remove restart callback
      ARM: shmobile: r8a73a4 dtsi: Add PM domain support

Laurent Pinchart (1):
      ARM: shmobile: r8a73a4: Remove legacy code

Magnus Damm (19):
      ARM: shmobile: mackerel: Remove ZBOOT code
      ARM: shmobile: mackerel: Remove Legacy C board code
      ARM: shmobile: mackerel dts: Remove Legacy DTS file
      ARM: shmobile: mackerel: Remove DT binding documentation
      ARM: shmobile: mackerel: Remove mach-type entry
      ARM: shmobile: mackerel: Remove defconfig
      ARM: shmobile: mackerel: Remove from MAINTAINERS
      ARM: shmobile: sh7372: Remove ZBOOT MMC/SDHI support
      ARM: shmobile: sh7372: Remove Legacy C SoC code
      ARM: shmobile: sh7372: Remove DT binding documentation
      ARM: shmobile: sh7372 dtsi: Remove Legacy DTSI file
      Documentation: Remove ZBOOT MMC/SDHI utility and docs
      ARM: shmobile: Remove mach/system.h
      ARM: shmobile: Remove mach/clkdev.h
      ARM: shmobile: Remove mach/uncompress.h
      ARM: shmobile: sh73a0: Introduce generic setup callback
      ARM: shmobile: sh73a0: Add Multiplatform support
      ARM: shmobile: kzm9g dts: Sync with kzm9g-reference dts
      ARM: shmobile: kzm9g: Build DTS for Multiplatform

Nicolas Ferre (7):
      Merge tag 'at91-fixes' into at91-4.1-multiplatform
      Merge tag 'at91-fixes2' into at91-4.1-multiplatform
      Merge tag 'at91-fixes3' into at91-4.1-multiplatform
      Merge tag 'at91-cleanup' into at91-4.1-multiplatform
      Merge tag 'at91-cleanup2' into at91-4.1-multiplatform
      Merge tag 'at91-cleanup3' into at91-4.1-multiplatform
      ARM: at91: add a Kconfig dependency on multi-platform

Olof Johansson (3):
      Merge tag 'renesas-r8a73a4-ccf-and-multiplatform-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/multiplatform
      Merge tag 'renesas-sh73a0-multiplatform-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/multiplatform
      Merge tag 'at91-multiplatform' of git://git.kernel.org/.../nferre/linux-at91 into next/multiplatform

Simon Horman (3):
      ARM: shmobile: r8a73a4: ape6evm: Remove legacy platform
      Merge branch 'heads/dt-for-v4.1' into sh73a0-multiplatform-for-v4.1.base
      ARM: shmobile: kzm9g-reference: Remove board C code and DT file

Stephen Boyd (1):
      ARM: shmobile: r8a7779: Remove redundant cpu_disable implementation

Ulrich Hecht (21):
      ARM: shmobile: r8a73a4: Add CPG register bits header
      ARM: shmobile: r8a73a4: Common clock framework DT description
      ARM: shmobile: ape6evm: Disable legacy clock initialization
      ARM: shmobile: r8a73a4: Add MSTP clock assignments to DT
      ARM: shmobile: ape6evm-reference: Remove board C code and DT file
      ARM: shmobile: r8a7778: synchronize dts with reference platform
      ARM: shmobile: r8a7778: add CPG register bits header
      ARM: shmobile: r8a7778: Common clock framework DT description
      ARM: shmobile: r8a7778: implement SoC and board CCF support
      ARM: shmobile: r8a7778: add MSTP clock assignments to DT
      ARM: shmobile: r8a7778: add internal ethernet controller to DT
      ARM: shmobile: bockw: add USB, VIN pin descriptions to DT
      ARM: shmobile: r8a7778 dtsi: Add Bus State Controller node
      ARM: shmobile: bockw dts: Move Ethernet node to BSC
      ARM: shmobile: bockw dts: set extal clock frequency
      ARM: shmobile: r8a7778: common clock framework CPG driver
      DT: i2c: add trivial binding for OKI ML86V7667 video decoder
      ARM: shmobile: bockw: add devices hooked up to i2c0 to DT
      ARM: shmobile: r8a7778: add sound to DT
      ARM: shmobile: bockw: add sound to DT
      ARM: shmobile: r8a7778: enable multiplatform target


 Documentation/Makefile                          |    2 +-
 Documentation/arm/Makefile                      |    1 -
 Documentation/arm/SH-Mobile/Makefile            |    7 -
 Documentation/arm/SH-Mobile/vrl4.c              |  170 --
 Documentation/arm/SH-Mobile/zboot-rom-mmcif.txt |   29 -
 Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt  |   42 -
 .../devicetree/bindings/arm/shmobile.txt        |    8 -
 .../clock/renesas,r8a7778-cpg-clocks.txt        |   25 +
 .../devicetree/bindings/i2c/trivial-devices.txt |    1 +
 .../bindings/power/renesas,sysc-rmobile.txt     |    1 +
 MAINTAINERS                                     |    2 -
 arch/arm/Kconfig                                |   45 +-
 arch/arm/Kconfig.debug                          |   10 +-
 arch/arm/boot/compressed/Makefile               |   15 -
 arch/arm/boot/compressed/head-shmobile.S        |   30 -
 arch/arm/boot/compressed/mmcif-sh7372.c         |   88 -
 arch/arm/boot/compressed/sdhi-sh7372.c          |   95 --
 arch/arm/boot/compressed/sdhi-shmobile.c        |  449 ------
 arch/arm/boot/compressed/sdhi-shmobile.h        |   11 -
 arch/arm/boot/dts/Makefile                      |   10 +-
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |  156 --
 arch/arm/boot/dts/r8a73a4-ape6evm.dts           |   37 +-
 arch/arm/boot/dts/r8a73a4.dtsi                  |  557 ++++++-
 arch/arm/boot/dts/r8a7778-bockw.dts             |  174 ++
 arch/arm/boot/dts/r8a7778.dtsi                  |  293 ++++
 arch/arm/boot/dts/sh7372-mackerel.dts           |   26 -
 arch/arm/boot/dts/sh7372.dtsi                   |   35 -
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts    |  398 -----
 arch/arm/boot/dts/sh73a0-kzm9g.dts              |  376 ++++-
 arch/arm/boot/dts/sh73a0.dtsi                   |  163 +-
 arch/arm/configs/ape6evm_defconfig              |  109 --
 arch/arm/configs/at91_dt_defconfig              |    5 +-
 arch/arm/configs/mackerel_defconfig             |  157 --
 arch/arm/mach-at91/Kconfig                      |  118 +-
 arch/arm/mach-at91/Makefile                     |    5 +
 arch/arm/mach-at91/include/mach/at91_dbgu.h     |   63 -
 arch/arm/mach-at91/include/mach/at91_ramc.h     |    4 -
 arch/arm/mach-at91/include/mach/at91rm9200.h    |  103 --
 arch/arm/mach-at91/include/mach/at91sam9260.h   |  129 --
 arch/arm/mach-at91/include/mach/at91sam9261.h   |   99 --
 arch/arm/mach-at91/include/mach/at91sam9263.h   |  117 --
 arch/arm/mach-at91/include/mach/at91sam9_smc.h  |    2 -
 arch/arm/mach-at91/include/mach/at91sam9g45.h   |  143 --
 arch/arm/mach-at91/include/mach/at91sam9n12.h   |   65 -
 arch/arm/mach-at91/include/mach/at91sam9rl.h    |  105 --
 arch/arm/mach-at91/include/mach/at91sam9x5.h    |   71 -
 arch/arm/mach-at91/include/mach/cpu.h           |  216 ---
 arch/arm/mach-at91/include/mach/hardware.h      |  134 --
 arch/arm/mach-at91/include/mach/sama5d3.h       |   86 -
 arch/arm/mach-at91/include/mach/sama5d4.h       |   33 -
 arch/arm/mach-at91/include/mach/uncompress.h    |  218 ---
 arch/arm/mach-at91/pm.c                         |  101 +-
 arch/arm/mach-at91/pm.h                         |   96 +-
 arch/arm/mach-at91/pm_suspend.S                 |    1 -
 arch/arm/mach-at91/sama5.c                      |    2 -
 arch/arm/mach-shmobile/Kconfig                  |   64 +-
 arch/arm/mach-shmobile/Makefile                 |   14 +-
 arch/arm/mach-shmobile/Makefile.boot            |    4 -
 .../arm/mach-shmobile/board-ape6evm-reference.c |   60 -
 arch/arm/mach-shmobile/board-ape6evm.c          |  306 ----
 arch/arm/mach-shmobile/board-bockw-reference.c  |    2 +
 arch/arm/mach-shmobile/board-kzm9g-reference.c  |   62 -
 arch/arm/mach-shmobile/board-mackerel.c         | 1522 ------------------
 arch/arm/mach-shmobile/clock-r8a73a4.c          |  659 --------
 arch/arm/mach-shmobile/clock-sh7372.c           |  620 -------
 arch/arm/mach-shmobile/clock.c                  |   11 -
 arch/arm/mach-shmobile/common.h                 |    1 -
 arch/arm/mach-shmobile/entry-intc.S             |   54 -
 arch/arm/mach-shmobile/include/mach/clkdev.h    |    7 -
 .../include/mach/head-mackerel.txt              |   93 --
 .../mach-shmobile/include/mach/mmc-mackerel.h   |   38 -
 arch/arm/mach-shmobile/include/mach/mmc.h       |   16 -
 .../mach-shmobile/include/mach/sdhi-sh7372.h    |   21 -
 arch/arm/mach-shmobile/include/mach/sdhi.h      |   16 -
 arch/arm/mach-shmobile/include/mach/system.h    |   11 -
 .../arm/mach-shmobile/include/mach/uncompress.h |   19 -
 arch/arm/mach-shmobile/include/mach/zboot.h     |    5 +-
 arch/arm/mach-shmobile/intc-sh7372.c            |  672 --------
 arch/arm/mach-shmobile/pm-sh7372.c              |  549 -------
 arch/arm/mach-shmobile/r8a73a4.h                |   17 -
 arch/arm/mach-shmobile/setup-r8a73a4.c          |  273 +---
 arch/arm/mach-shmobile/setup-r8a7778.c          |   19 +
 arch/arm/mach-shmobile/setup-sh7372.c           | 1016 ------------
 arch/arm/mach-shmobile/setup-sh73a0.c           |   19 +-
 arch/arm/mach-shmobile/sh7372.h                 |   84 -
 arch/arm/mach-shmobile/sh73a0.h                 |    1 -
 arch/arm/mach-shmobile/sleep-sh7372.S           |   98 --
 arch/arm/mach-shmobile/smp-r8a7779.c            |    7 -
 arch/arm/mach-shmobile/smp-sh73a0.c             |    2 +-
 arch/arm/tools/mach-types                       |    1 -
 drivers/clk/shmobile/Makefile                   |    1 +
 drivers/clk/shmobile/clk-r8a7778.c              |  143 ++
 include/dt-bindings/clock/r8a73a4-clock.h       |   62 +
 include/dt-bindings/clock/r8a7778-clock.h       |   71 +
 include/linux/clk/shmobile.h                    |    1 +
 95 files changed, 2064 insertions(+), 10015 deletions(-)
 delete mode 100644 Documentation/arm/Makefile
 delete mode 100644 Documentation/arm/SH-Mobile/Makefile
 delete mode 100644 Documentation/arm/SH-Mobile/vrl4.c
 delete mode 100644 Documentation/arm/SH-Mobile/zboot-rom-mmcif.txt
 delete mode 100644 Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
 delete mode 100644 arch/arm/boot/compressed/mmcif-sh7372.c
 delete mode 100644 arch/arm/boot/compressed/sdhi-sh7372.c
 delete mode 100644 arch/arm/boot/compressed/sdhi-shmobile.c
 delete mode 100644 arch/arm/boot/compressed/sdhi-shmobile.h
 delete mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
 delete mode 100644 arch/arm/boot/dts/sh7372-mackerel.dts
 delete mode 100644 arch/arm/boot/dts/sh7372.dtsi
 delete mode 100644 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
 delete mode 100644 arch/arm/configs/ape6evm_defconfig
 delete mode 100644 arch/arm/configs/mackerel_defconfig
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_dbgu.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91rm9200.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9260.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9261.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9263.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9g45.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9n12.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9rl.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9x5.h
 delete mode 100644 arch/arm/mach-at91/include/mach/cpu.h
 delete mode 100644 arch/arm/mach-at91/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-at91/include/mach/sama5d3.h
 delete mode 100644 arch/arm/mach-at91/include/mach/sama5d4.h
 delete mode 100644 arch/arm/mach-at91/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm.c
 delete mode 100644 arch/arm/mach-shmobile/board-kzm9g-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-mackerel.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a73a4.c
 delete mode 100644 arch/arm/mach-shmobile/clock-sh7372.c
 delete mode 100644 arch/arm/mach-shmobile/entry-intc.S
 delete mode 100644 arch/arm/mach-shmobile/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/head-mackerel.txt
 delete mode 100644 arch/arm/mach-shmobile/include/mach/mmc-mackerel.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/mmc.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/sdhi.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/system.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-shmobile/intc-sh7372.c
 delete mode 100644 arch/arm/mach-shmobile/pm-sh7372.c
 delete mode 100644 arch/arm/mach-shmobile/r8a73a4.h
 delete mode 100644 arch/arm/mach-shmobile/setup-sh7372.c
 delete mode 100644 arch/arm/mach-shmobile/sh7372.h
 delete mode 100644 arch/arm/mach-shmobile/sleep-sh7372.S
 create mode 100644 drivers/clk/shmobile/clk-r8a7778.c
 create mode 100644 include/dt-bindings/clock/r8a73a4-clock.h
 create mode 100644 include/dt-bindings/clock/r8a7778-clock.h
