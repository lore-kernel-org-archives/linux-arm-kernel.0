From: olof@lixom.net (Olof Johansson)
Date: Sat, 29 Oct 2016 11:54:49 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20161029185449.GA7906@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to b70e8beb09d313202afd9d3953f501f02ee4e44b:

  Merge tag 'v4.9-rockchip-dts64-fixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into fixes (2016-10-29 11:09:37 -0700)

----------------------------------------------------------------
ARM: SoC fixes

We haven't seen a whole lot of fixes for the first two weeks since the merge
window, but here is the batch that we have at the moment.

Nothing sticks out as particularly bad or scary, it's mostly a handful of
smaller fixes to several platforms. The Uniphier reset controller changes
could probably have been delayed to 4.10, but they're not scary and just
plumbing up driver changes that went in during the merge window.

We're also adding another maintainer to Marvell Berlin platforms, to help
out when Sebastian is too busy. Yay teamwork!

----------------------------------------------------------------
Fabio Estevam (3):
      ARM: imx: gpc: Initialize all power domains
      ARM: imx: gpc: Fix the imx_gpc_genpd_init() error path
      ARM: imx: mach-imx6q: Fix the PHY ID mask for AR8031

Gregory CLEMENT (1):
      ARM: mvebu: Select corediv clk for all mvebu v7 SoC

Jisheng Zhang (1):
      MAINTAINERS: add myself as Marvell berlin SoC maintainer

Linus Walleij (2):
      ARM: dts: fix the SD card on the Snowball
      bus: qcom-ebi2: depend on ARCH_QCOM or COMPILE_TEST

Marcin Wojtas (1):
      arm64: dts: marvell: fix clocksource for CP110 master SPI0

Masahiro Yamada (5):
      ARM: uniphier: select ARCH_HAS_RESET_CONTROLLER
      arm64: uniphier: select ARCH_HAS_RESET_CONTROLLER
      reset: uniphier: rename MIO reset to SD reset for Pro5, PXs2, LD20 SoCs
      ARM: dts: uniphier: change MIO node to SD control node
      arm64: dts: uniphier: change MIO node to SD control node

Olof Johansson (5):
      Merge tag 'mvebu-fixes-4.8-3' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'uniphier-fixes-v4.9' of git://git.kernel.org/.../masahiroy/linux-uniphier into fixes
      Merge tag 'imx-fixes-4.9' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'arm-soc/for-4.9/devicetree-arm64-fixes' of http://github.com/Broadcom/stblinux into fixes
      Merge tag 'v4.9-rockchip-dts64-fixes1' of git://git.kernel.org/.../mmind/linux-rockchip into fixes

Ray Jui (1):
      arm64: dts: Updated NAND DT properties for NS2 SVK

Scott Branden (1):
      ARM: multi_v7_defconfig: Enable Intel e1000e driver

Scott Wood (1):
      arm64: dts: Add timer erratum property for LS2080A and LS1043A

Shawn Lin (2):
      arm64: dts: rockchip: remove always-on and boot-on from vcc_sd
      arm64: dts: rockchip: remove the abuse of keep-power-in-suspend

Stefan Agner (1):
      ARM: dts: vf610: fix IRQ flag of global timer

 .../devicetree/bindings/reset/uniphier-reset.txt   | 62 +++++++++++-----------
 MAINTAINERS                                        |  1 +
 arch/arm/boot/dts/ste-snowball.dts                 | 15 +++++-
 arch/arm/boot/dts/uniphier-pro5.dtsi               |  4 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |  4 +-
 arch/arm/boot/dts/vf500.dtsi                       |  2 +-
 arch/arm/configs/multi_v7_defconfig                |  1 +
 arch/arm/mach-imx/gpc.c                            | 15 ++++--
 arch/arm/mach-imx/mach-imx6q.c                     |  2 +-
 arch/arm/mach-mvebu/Kconfig                        |  4 +-
 arch/arm/mach-uniphier/Kconfig                     |  1 +
 arch/arm64/Kconfig.platforms                       |  1 +
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |  2 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  1 +
 .../boot/dts/marvell/armada-cp110-master.dtsi      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts    |  3 --
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    |  4 --
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 12 ++---
 drivers/bus/Kconfig                                |  1 +
 drivers/reset/reset-uniphier.c                     | 16 +++---
 21 files changed, 87 insertions(+), 67 deletions(-)
