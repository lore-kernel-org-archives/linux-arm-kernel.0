From: olof@lixom.net (Olof Johansson)
Date: Sat, 27 Feb 2016 16:16:03 -0800
Subject: [GIT PULL] ARM: SoC fixes for 4.5-rc
Message-ID: <20160228001603.GA15479@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 81f70ba233d5f660e1ea5fe23260ee323af5d53a:

  Linux 4.5-rc5 (2016-02-20 13:39:35 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to d877a214d54619762ae86114fbd04932002ffecd:

  Merge tag 'renesas-soc-fixes-for-v4.5' of git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into fixes (2016-02-24 08:48:22 -0800)

----------------------------------------------------------------
ARM: SoC fixes

We didn't have a batch last week, so this one is slightly larger.

None of them are scary though, a handful of fixes for small DT pieces,
replacing properties with newer conventions.

Highlights:

 - N900 fix for setting system revision
 - onenand init fix to avoid filesystem corruption
 - Clock fix for audio on Beaglebone-x15
 - Fixes on shmobile to deal with CONFIG_DEBUG_RODATA (default y in 4.6)

 + misc smaller stuff.

----------------------------------------------------------------
Antoine Tenart (1):
      MAINTAINERS: alpine: add a new maintainer and update the entry

Carlo Caione (1):
      MAINTAINERS: Extend info, add wiki and ml for meson arch

Geert Uytterhoeven (4):
      ARM: shmobile: Move shmobile_scu_base from .text to .bss
      ARM: shmobile: r8a7779: Remove remainings of removed SCU boot setup code
      ARM: shmobile: Move shmobile_smp_{mpidr, fn, arg}[] from .text to .bss
      ARM: shmobile: Remove shmobile_boot_arg

Heinrich Schuchardt (1):
      ARM: dts: kirkwood: use unique machine name for ds112

Ivaylo Dimitrov (2):
      ARM: OMAP2+: Set system_rev from ATAGS for n900
      ARM: OMAP2+: Fix onenand initialization to avoid filesystem corruption

Lucas Stach (1):
      ARM: dts: imx6: remove bogus interrupt-parent from CAAM node

Ludovic Desroches (1):
      ARM: at91/dt: fix typo in sama5d2 pinmux descriptions

Olof Johansson (5):
      Merge tag 'mvebu-fixes-4.5-2' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'omap-for-v4.5/fixes-rc3-v2' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'imx-fixes-4.5' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'omap-for-v4.5/fixes-rc5' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'renesas-soc-fixes-for-v4.5' of git://git.kernel.org/.../horms/renesas into fixes

Peter Ujfalusi (2):
      ARM: DTS: am57xx-beagle-x15: Select SYS_CLK2 for audio clocks
      Revert "regulator: tps65217: remove tps65217.dtsi file"

Roger Shimizu (1):
      ARM: dts: orion5x: fix the missing mtd flash on linkstation lswtgl

Sudeep Holla (1):
      ARM: dts: am335x/am57xx: replace gpio-key,wakeup with wakeup-source property

Tony Lindgren (2):
      ARM: OMAP2+: Improve omap_device error for driver writers
      ARM: OMAP2+: Fix omap_device for module reload on PM runtime forbid

 .../devicetree/bindings/regulator/tps65217.txt     | 10 ----
 MAINTAINERS                                        | 13 +++--
 arch/arm/boot/dts/am335x-bone-common.dtsi          | 14 ++----
 arch/arm/boot/dts/am335x-chilisom.dtsi             | 14 +-----
 arch/arm/boot/dts/am335x-nano.dts                  | 14 +-----
 arch/arm/boot/dts/am335x-pepper.dts                | 14 +-----
 arch/arm/boot/dts/am335x-shc.dts                   |  4 +-
 arch/arm/boot/dts/am335x-sl50.dts                  | 13 +----
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |  4 ++
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |  2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  1 -
 arch/arm/boot/dts/kirkwood-ds112.dts               |  2 +-
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts   | 31 ++++++++++++
 arch/arm/boot/dts/sama5d2-pinfunc.h                |  2 +-
 arch/arm/boot/dts/tps65217.dtsi                    | 56 ++++++++++++++++++++++
 arch/arm/mach-omap2/board-generic.c                | 22 ++++++++-
 arch/arm/mach-omap2/gpmc-onenand.c                 |  6 +--
 arch/arm/mach-omap2/omap_device.c                  | 14 +++++-
 arch/arm/mach-shmobile/common.h                    |  1 -
 arch/arm/mach-shmobile/headsmp-scu.S               |  6 ---
 arch/arm/mach-shmobile/headsmp.S                   | 28 ++++++-----
 arch/arm/mach-shmobile/platsmp-apmu.c              |  1 -
 arch/arm/mach-shmobile/platsmp-scu.c               |  4 +-
 arch/arm/mach-shmobile/smp-r8a7779.c               |  2 -
 24 files changed, 173 insertions(+), 105 deletions(-)
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi
