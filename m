From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Jan 2017 14:45:08 +0100
Subject: [GIT PULL] arm-soc fixes for 4.10-rc
Message-ID: <4837573.JAN9JzcZNZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 1b9ec81258827001c869f003e0b8dd2ddc104717:

  Merge tag 'davinci-fixes-for-v4.10' of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci into fixes (2017-01-04 16:43:00 +0100)

----------------------------------------------------------------
This is a rather large set of bugfixes, as we just returned from the
Christmas break. Most of these are relatively unimportant fixes for
regressions introduced during the merge window, and about half of
the changes are for mach-omap2.

A couple of patches are just cleanups and dead code removal that I would
not normally have considered for merging after -rc2, but I decided to
take them along with the fixes this time.

Notable fixes include:

- removing the skeleton.dtsi include broke a number of machines, and we
  have to put empty /chosen nodes back to be able to pass kernel command
  lines as before

- enabling Samsung platforms no longer hardwires CONFIG_HZ to 200,
  as it had been for no good reason for a long time.

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: omap3: Add DTS for Logic PD SOM-LV 37xx Dev Kit

Alexandre Bailon (2):
      ARM: davinci: Make __clk_{enable,disable} functions public
      ARM: davinci: da8xx: Fix sleeping function called from invalid context

Andreas F?rber (1):
      ARM: dts: vf610-zii-dev-rev-b: Add missing newline

Arnd Bergmann (12):
      Merge tag 'renesas-fixes-for-v4.10' of https://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'qcom-fixes-for-4.10-rc1' of git://git.kernel.org/.../agross/linux into fixes
      Merge tag 'samsung-soc-4.10-2' of git://git.kernel.org/.../krzk/linux into fixes
      Merge tag 'omap-for-v4.10/fixes-rc1' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'qcom-arm-fixes-for-4.10-rc2' of git://git.kernel.org/.../agross/linux into fixes
      Merge tag 'imx-fixes-4.10' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'scpi-fixes-4.10' of git://git.kernel.org/.../sudeep.holla/linux into fixes
      Merge tag 'vexpress-fixes-4.10' of git://git.kernel.org/.../sudeep.holla/linux into fixes
      Merge tag 'juno-fixes-4.10' of git://git.kernel.org/.../sudeep.holla/linux into fixes
      Merge tag 'psci-fixes-4.10' of git://git.kernel.org/.../lpieralisi/linux into fixes
      Merge tag 'amlogic-fixes' of git://git.kernel.org/.../khilman/linux-amlogic into fixes
      Merge tag 'davinci-fixes-for-v4.10' of git://git.kernel.org/.../nsekhar/linux-davinci into fixes

Bartosz Golaszewski (2):
      ARM: davinci: da850: fix infinite loop in clk_set_rate()
      ARM: davinci: da850: don't add emac clock to lookup table twice

Bjorn Andersson (1):
      ARM: dts: qcom: apq8064: Add missing scm clock

Christoffer Dall (1):
      ARM: dts: vexpress: Support GICC_DIR operations

Fabio Estevam (1):
      ARM: dts: imx6: Disable "weim" node in the dtsi files

Gary Bisson (1):
      ARM: dts: imx6qdl-nitrogen6x: remove duplicate iomux entry

Grygorii Strashko (2):
      ARM: OMAP2+: Remove legacy gpio code
      ARM: omap2+: am437x: rollback to use omap3_gptimer_timer_init()

Javier Martinez Canillas (9):
      ARM: dts: omap2: Add an empty chosen node to top level DTSI
      ARM: dts: omap3: Add an empty chosen node to top level DTSI
      ARM: dts: omap4: Add an empty chosen node to top level DTSI
      ARM: dts: omap5: Add an empty chosen node to top level DTSI
      ARM: dts: am33xx: Add an empty chosen node to top level DTSI
      ARM: dts: am4372: Add an empty chosen node to top level DTSI
      ARM: dts: dm814x: Add an empty chosen node to top level DTSI
      ARM: dts: dm816x: Add an empty chosen node to top level DTSI
      ARM: dts: dra7: Add an empty chosen node to top level DTSI

Kevin Hilman (2):
      ARM64: dts: meson-gxl: fix GPIO include
      ARM64: defconfig: enable DRM_MESON as module

Kishon Vijay Abraham I (1):
      ARM: dts: am572x-idk: Add gpios property to control PCIE_RESETn

Krzysztof Kozlowski (1):
      ARM: Drop fixed 200 Hz timer requirement from Samsung platforms

Lokesh Vutla (1):
      ARM: dts: dra72-evm-tps65917: Add voltage supplies to usb_phy, mmc, dss

Maninder Singh (1):
      ARM: omap2+: fixing wrong strcat for Non-NULL terminated string

Markus Elfring (1):
      ARM: OMAP2+: PRM: Delete an error message for a failed memory allocation

Martin Blumenstingl (1):
      firmware: arm_scpi: fix reading sensor values on pre-1.0 SCPI firmwares

Milo Kim (4):
      ARM: dts: am335x: Fix the interrupt name of TPS65217
      dt-bindings: mfd: Remove TPS65217 interrupts
      dt-bindings: power/supply: Update TPS65217 properties
      dt-bindings: input: Specify the interrupt number of TPS65217 power button

Neil Armstrong (1):
      ARM64: dts: meson-gx: Add Graphic Controller nodes

Pali Roh?r (1):
      ARM: dts: n900: Mark eMMC slot with no-sdio and no-sd flags

Pankaj Dubey (1):
      ARM: EXYNOS: Remove smp_init_cpus hook from platsmp.c

Roger Quadros (2):
      ARM: dts: am57xx-idk: Support VBUS detection on USB2 port
      ARM: dts: am57xx-idk: Put USB2 port in peripheral mode

Simon Horman (1):
      arm64: dts: h3ulcb: Provide sd0_uhs node

Stephen Boyd (1):
      arm64: dts: msm8996: Add required memory carveouts

Sudeep Holla (3):
      arm64: dts: vexpress: Support GICC_DIR operations
      drivers: psci: annotate timer on stack to silence odebug messages
      MAINTAINERS: extend PSCI entry to cover the newly add PSCI checker code

Sylwester Nawrocki (1):
      ARM: S3C24XX: Add DMA slave maps for remaining s3c24xx SoCs

Tony Lindgren (1):
      Merge branch 'omap-for-v4.10/legacy' into omap-for-v4.10/fixes

Vladimir Murzin (1):
      ARM: i.MX: remove map_io callback

Vladimir Zapolskiy (1):
      ARM: dts: imx31: fix AVIC base address

 .../bindings/input/tps65218-pwrbutton.txt          |   4 +-
 .../bindings/power/supply/tps65217_charger.txt     |   7 +-
 MAINTAINERS                                        |   2 +-
 arch/arm/Kconfig                                   |   3 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-bone-common.dtsi          |   8 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   1 +
 arch/arm/boot/dts/am4372.dtsi                      |   1 +
 arch/arm/boot/dts/am571x-idk.dts                   |  10 +-
 arch/arm/boot/dts/am572x-idk.dts                   |  14 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi           |   9 +-
 arch/arm/boot/dts/dm814x.dtsi                      |   1 +
 arch/arm/boot/dts/dm816x.dtsi                      |   1 +
 arch/arm/boot/dts/dra7.dtsi                        |   1 +
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi          |  16 +++
 arch/arm/boot/dts/imx31.dtsi                       |   4 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |   1 -
 arch/arm/boot/dts/imx6qdl.dtsi                     |   1 +
 arch/arm/boot/dts/imx6sl.dtsi                      |   1 +
 arch/arm/boot/dts/imx6sx.dtsi                      |   1 +
 arch/arm/boot/dts/omap2.dtsi                       |   1 +
 arch/arm/boot/dts/omap3-n900.dts                   |   2 +
 arch/arm/boot/dts/omap3.dtsi                       |   1 +
 arch/arm/boot/dts/omap4.dtsi                       |   1 +
 arch/arm/boot/dts/omap5.dtsi                       |   1 +
 arch/arm/boot/dts/qcom-apq8064.dtsi                |   4 +
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |   2 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |   2 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts          |   3 +-
 arch/arm/mach-davinci/clock.c                      |  12 +-
 arch/arm/mach-davinci/clock.h                      |   2 +
 arch/arm/mach-davinci/da850.c                      |  32 ++++-
 arch/arm/mach-davinci/usb-da8xx.c                  |  34 ++---
 arch/arm/mach-exynos/platsmp.c                     |  31 ----
 arch/arm/mach-imx/mach-imx1.c                      |   1 -
 arch/arm/mach-omap2/Makefile                       |   2 +-
 arch/arm/mach-omap2/board-generic.c                |   2 +-
 arch/arm/mach-omap2/gpio.c                         | 160 ---------------------
 arch/arm/mach-omap2/omap_hwmod.c                   |   8 +-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   4 -
 arch/arm/mach-omap2/prm_common.c                   |   4 +-
 arch/arm/mach-omap2/timer.c                        |   9 +-
 arch/arm/mach-s3c24xx/common.c                     |  76 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |  16 +++
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  16 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |  16 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   4 +
 .../boot/dts/amlogic/meson-gxl-nexbox-a95x.dts     |  16 +++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |   6 +-
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  16 +++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |   4 +
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  10 ++
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |   2 +-
 arch/arm64/configs/defconfig                       |   1 +
 drivers/firmware/arm_scpi.c                        |  10 +-
 drivers/firmware/psci_checker.c                    |   4 +-
 include/dt-bindings/mfd/tps65217.h                 |  26 ----
 58 files changed, 334 insertions(+), 296 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/gpio.c
 delete mode 100644 include/dt-bindings/mfd/tps65217.h
