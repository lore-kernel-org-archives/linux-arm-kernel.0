From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Apr 2016 16:52:38 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20160412235238.GA23006@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 0b24f7a8d6e0d17bcf24433ce5827841a05b5b46:

  Merge tag 'mvebu-fixes-4.6-1' of git://git.infradead.org/linux-mvebu into fixes (2016-04-12 12:35:07 -0700)

----------------------------------------------------------------
ARM: SoC fixes

A batch of fixes for -rc4, for various platforms. Nothing really
substantial and worth pointing out in particular; small fixes for various
bugs, see shortlog for details.

----------------------------------------------------------------
Arnd Bergmann (1):
      bus: mvebu-mbus: use %pa to print phys_addr_t

Carlo Caione (2):
      ARM: dts: amlogic: Split pinctrl device for Meson8 / Meson8b
      documentation: Fix pinctrl documentation for Meson8 / Meson8b

Jayachandran C (1):
      arm64: dts: vulcan: Update PCI ranges

Jon Hunter (1):
      ARM: OMAP: Correct interrupt type for ARM TWD

Kevin Hilman (1):
      Merge tag 'meson8-dt-fix' of https://github.com/carlocaione/linux-meson into fixes

Kunihiko Hayashi (1):
      bus: uniphier-system-bus: fix condition of overlap check

Linus Walleij (2):
      ARM: u8500_defconfig: turn on the Synaptics RMI4 driver
      ARM: sa1100: remove references to the defunct handhelds.org

Lokesh Vutla (2):
      ARM: OMAP2+: hwmod: Fix updating of sysconfig register
      ARM: dts: AM43x-epos: Fix clk parent for synctimer

Masahiro Yamada (1):
      ARM: uniphier: drop weird sizeof()

Nishanth Menon (1):
      ARM: OMAP2: Fix up interconnect barrier initialization for DRA7

Olof Johansson (3):
      Merge tag 'omap-for-v4.6/fixes-rc1' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'pxa-fixes-v4.6' of https://github.com/rjarzmik/linux into fixes
      Merge tag 'mvebu-fixes-4.6-1' of git://git.infradead.org/linux-mvebu into fixes

Patrick Uiterwijk (1):
      ARM: mvebu: Correct unit address for linksys

Robert Jarzmik (1):
      ARM: pxa: fix the number of DMA requestor lines

Tero Kristo (1):
      ARM: dts: am43xx: fix edma memcpy channel allocation

Tony Lindgren (2):
      ARM: OMAP2+: Use srst_udelay for USB on dm814x
      Merge tag 'for-v4.6-rc/omap-fixes-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.6/fixes

Vishal Mahaveer (1):
      ARM: DRA722: Add ID detect for Silicon Rev 2.0

Yegor Yefremov (1):
      ARM: dts: am335x-baltos-ir5221: fix cpsw_emac0 link type

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  | 38 +++------------
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         |  5 +-
 arch/arm/boot/dts/am4372.dtsi                      |  2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |  5 ++
 arch/arm/boot/dts/armada-385-linksys.dtsi          |  2 +-
 arch/arm/boot/dts/meson8.dtsi                      | 57 ++++++++++++----------
 arch/arm/boot/dts/meson8b.dtsi                     | 12 ++++-
 arch/arm/boot/dts/omap4.dtsi                       |  2 +-
 arch/arm/configs/u8500_defconfig                   |  3 ++
 arch/arm/mach-omap2/id.c                           |  4 +-
 arch/arm/mach-omap2/io.c                           |  1 +
 arch/arm/mach-omap2/omap_hwmod.c                   |  8 +--
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |  2 +
 arch/arm/mach-omap2/soc.h                          |  1 +
 arch/arm/mach-pxa/devices.c                        |  1 +
 arch/arm/mach-sa1100/Kconfig                       | 10 +---
 arch/arm/mach-uniphier/platsmp.c                   |  2 +-
 arch/arm64/boot/dts/broadcom/vulcan.dtsi           | 15 +++---
 drivers/bus/mvebu-mbus.c                           |  2 +-
 drivers/bus/uniphier-system-bus.c                  |  2 +-
 20 files changed, 89 insertions(+), 85 deletions(-)
