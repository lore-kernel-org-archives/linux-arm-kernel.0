From: olof@lixom.net (Olof Johansson)
Date: Thu, 19 Jan 2017 16:35:53 -0800
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20170120003553.GA7800@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 1b9ec81258827001c869f003e0b8dd2ddc104717:

  Merge tag 'davinci-fixes-for-v4.10' of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci into fixes (2017-01-04 16:43:00 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 43849785e1079f6606a31cb7fda92d1200849728:

  ARM: dts: da850-evm: fix read access to SPI flash (2017-01-19 16:23:19 -0800)

----------------------------------------------------------------
ARM: SoC fixes

We've been sitting on fixes for a while, and they keep trickling in at a low
rate. Nothing in here comes across as particularly scary or noteworthy, for
the most part it's a large collection of small DT tweaks.

----------------------------------------------------------------
Adam Ford (2):
      ARM: OMAP2+: Fix WL1283 Bluetooth Baud Rate
      ARM: dts: omap3: Fix Card Detect and Write Protect on Logic PD SOM-LV

Arnd Bergmann (1):
      ARM: ux500: fix prcmu_is_cpu_in_wfi() calculation

Chen-Yu Tsai (2):
      ARM: dts: sun6i: Disable display pipeline by default
      ARM: dts: sun6i: hummingbird: Enable display engine again

Emmanuel Vadot (1):
      ARM: dts: sunxi: Change node name for pwrseq pin on Olinuxino-lime2-emmc

Fabien Parent (1):
      ARM: dts: da850-evm: fix read access to SPI flash

Gary Bisson (2):
      ARM: dts: imx6qdl-nitrogen6_max: fix sgtl5000 pinctrl init
      ARM: dts: imx6qdl-nitrogen6_som2: fix sgtl5000 pinctrl init

Jean-Jacques Hiblot (1):
      ARM: dts: OMAP5 / DRA7: indicate that SATA port 0 is available.

Jon Mason (1):
      ARM: dts: NSP: Fix DT ranges error

Krzysztof Kozlowski (2):
      MAINTAINERS: Add Patchwork URL to Samsung Exynos entry
      ARM: s3c2410_defconfig: Fix invalid values for NF_CT_PROTO_*

Lokesh Vutla (1):
      ARM: dts: am335x-icev2: Remove the duplicated pinmux setting

Masahiro Yamada (1):
      ARM, ARM64: dts: drop "arm,amba-bus" in favor of "simple-bus" part 3

Michal Simek (1):
      ARM64: zynqmp: Fix W=1 dtc 1.4 warnings

Milo Kim (1):
      ARM: dts: sun8i: Support DTB build for NanoPi M1

Moritz Fischer (1):
      ARM64: zynqmp: Fix i2c node's compatible string

Neil Armstrong (1):
      ARM64: dts: meson-gxbb-odroidc2: Disable SCPI DVFS

Olof Johansson (8):
      Merge tag 'zynmp-dt-fixes-for-4.10' of https://github.com/Xilinx/linux-xlnx into fixes
      Merge tag 'imx-fixes-4.10-2' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'sunxi-fixes-for-4.10' of https://git.kernel.org/.../mripard/linux into fixes
      Merge tag 'samsung-fixes-4.10' of git://git.kernel.org/.../krzk/linux into fixes
      Merge tag 'arm-soc/for-4.10/defconfig-fixes' of http://github.com/Broadcom/stblinux into fixes
      Merge tag 'arm-soc/for-4.10/devicetree-fixes' of http://github.com/Broadcom/stblinux into fixes
      Merge tag 'ux500-fix-for-armsoc' of git://git.kernel.org/.../linusw/linux-stericsson into fixes
      Merge tag 'omap-for-v4.10/fixes-rc4' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Peter Ujfalusi (1):
      ARM: OMAP1: DMA: Correct the number of logical channels

Sekhar Nori (1):
      ARM: dts: dra72-evm-revc: fix typo in ethernet-phy node

Valentin Rothberg (2):
      ARM: multi_v7_defconfig: fix config typo
      ARM: multi_v7_defconfig: set bcm47xx watchdog

Wei Yongjun (1):
      soc: ti: wkup_m3_ipc: Fix error return code in wkup_m3_ipc_probe()

 MAINTAINERS                                          |  1 +
 arch/arm/boot/dts/Makefile                           |  1 +
 arch/arm/boot/dts/am335x-icev2.dts                   |  1 -
 arch/arm/boot/dts/bcm-nsp.dtsi                       |  2 +-
 arch/arm/boot/dts/da850-evm.dts                      |  1 +
 arch/arm/boot/dts/dra7.dtsi                          |  1 +
 arch/arm/boot/dts/dra72-evm-revc.dts                 |  2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi         |  4 ++--
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi        |  4 ++--
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts     | 11 +++--------
 arch/arm/boot/dts/omap5.dtsi                         |  1 +
 arch/arm/boot/dts/qcom-mdm9615.dtsi                  |  2 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts          |  4 ++++
 arch/arm/boot/dts/sun6i-a31.dtsi                     |  1 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts |  2 +-
 arch/arm/configs/multi_v7_defconfig                  |  4 ++--
 arch/arm/configs/s3c2410_defconfig                   |  6 +++---
 arch/arm/mach-omap1/dma.c                            | 16 +++++++---------
 arch/arm/mach-omap2/pdata-quirks.c                   |  2 +-
 arch/arm/mach-ux500/pm.c                             |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts  |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          |  2 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi           |  2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts          |  2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi               |  6 +++---
 drivers/soc/ti/wkup_m3_ipc.c                         |  1 +
 26 files changed, 47 insertions(+), 40 deletions(-)
