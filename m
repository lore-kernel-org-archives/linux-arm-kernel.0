From: olof@lixom.net (Olof Johansson)
Date: Sat, 25 Aug 2018 12:29:27 -0700
Subject: [GIT PULL] ARM: SoC late branch
Message-ID: <20180825192927.votock3x5zpwplzo@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 29ed45fff05899f6f39d05fe1c32b1bc51f8926b:

  Merge tag 'v4.18-next-soc' of https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into next/drivers (2018-07-26 13:08:01 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-late

for you to fetch changes up to 1aa55ca9b14af6cfd987ce4fdaf548f7067a5d07:

  iommu/rockchip: Move irq request past pm_runtime_enable (2018-08-24 08:50:32 -0700)

----------------------------------------------------------------
ARM: SoC: late updates

A couple of late-merged changes that would be useful to get in this
merge window:

 - Driver support for reset of audio complex on Meson platforms. The
   audio driver went in this merge window, and these changes have been
   in -next for a while (just not in our tree).

 - Power management fixes for IOMMU on Rockchip platforms, getting
   closer to kexec working on them, including Chromebooks.

 - Another pass updating "arm,psci" -> "psci" for some properties that
   have snuck in since last time it was done.

----------------------------------------------------------------
Amit Kucheria (1):
      arm64: dts: Fix various entry-method properties to reflect documentation

Jerome Brunet (2):
      reset: meson: add dt-bindings for meson-axg audio arb
      reset: meson: add meson audio arb driver

Leonard Crestez (1):
      reset: imx7: Fix always writing bits as 0

Marc Zyngier (4):
      ARM: rockchip: Force CONFIG_PM on Rockchip systems
      arm64: rockchip: Force CONFIG_PM on Rockchip systems
      iommu/rockchip: Handle errors returned from PM framework
      iommu/rockchip: Move irq request past pm_runtime_enable

Olof Johansson (2):
      Merge tag 'reset-for-4.19-2' of git://git.pengutronix.de/git/pza/linux into next/late
      Merge tag 'reset-fixes-for-4.18' of git://git.pengutronix.de/git/pza/linux into next/late

 .../devicetree/bindings/arm/cpu-capacity.txt       |   2 +-
 .../devicetree/bindings/arm/idle-states.txt        |   4 +-
 .../bindings/reset/amlogic,meson-axg-audio-arb.txt |  21 +++
 arch/arm/mach-rockchip/Kconfig                     |   1 +
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/arm/juno-r1.dts                |   2 +-
 arch/arm64/boot/dts/arm/juno-r2.dts                |   2 +-
 arch/arm64/boot/dts/arm/juno.dts                   |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |   2 +-
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   2 +-
 arch/arm64/boot/dts/sprd/sc9860.dtsi               |   2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   2 +-
 drivers/iommu/rockchip-iommu.c                     |  45 +++---
 drivers/reset/Kconfig                              |   7 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-imx7.c                         |   2 +-
 drivers/reset/reset-meson-audio-arb.c              | 168 +++++++++++++++++++++
 .../reset/amlogic,meson-axg-audio-arb.h            |  17 +++
 20 files changed, 257 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
 create mode 100644 drivers/reset/reset-meson-audio-arb.c
 create mode 100644 include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h
