From: olof@lixom.net (Olof Johansson)
Date: Wed, 20 Jan 2016 17:14:39 -0800
Subject: [GIT PULL 6/9] ARM: 64-bit DT updates for v4.5
In-Reply-To: <1453338882-31300-1-git-send-email-olof@lixom.net>
References: <1453338882-31300-1-git-send-email-olof@lixom.net>
Message-ID: <1453338882-31300-7-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the first release where we split up the 64-bit contributions a
bit more, and in particular we are having a separate DT branch for them.

Contents:

- New devices added to Broadcom NorthStar2
- Misc fixes for Exynos7 boards
- QCOM updates for MSM8916
- Rockchip tweaks for rk3368 SoC and eval board
- A series of fixes for APM X-Gene v1 and v2
- Renesas R8A7795 CPU/PSCI additions
- Marvell Berlin4CT PSCI, cpuidle, watchdog portions
- Freescale LS1043a SoC and dev board support

+ some treewide or other misc changes

----------------------------------------------------------------

The following changes since commit 2791864e462f528861b27d69f2e8a5ff1c6b6ef4:

  Merge branch 'next/dt' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt64

for you to fetch changes up to d07822a7ed2484908fb0d86f5f1dec27db0da439:

  Merge tag 'xgene-dts-fixes-for-v4.5' of https://github.com/AppliedMicro/xgene-next into next/dt64

----------------------------------------------------------------

Alim Akhtar (3):
      arm64: dts: Add S2MPS15 PMIC node on exynos7-espresso
      arm64: dts: Enable HS200 mode operation on exynos7-espresso
      arm64: dts: Add reboot node for exynos7

Andy Gross (3):
      arm64: dts: qcom: Add MSM8916 SMEM nodes
      arm64: dts: qcom: Add RPM/SMD support on MSM8916
      arm64: dts: Add PM8916 support on MSM8916

Anup Patel (6):
      arm64: dts: Add L2-cache DT node for NS2
      arm64: dts: Add SMMU DT node for NS2
      arm64: dts: Add syscon based reboot in DT for NS2
      arm64: dts: Add ARM PMUv3 DT node in NS2 DT
      arm64: dts: Add IPROC RNG200 DT node for NS2
      arm64: dts: Add BRCM IPROC NAND DT node for NS2

Arnd Bergmann (7):
      Merge tag 'renesas-arm64-dt-for-v4.5' of git://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'renesas-arm64-dt2-for-v4.5' of git://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'xgene-dts-for-v4.5-v1' of https://github.com/AppliedMicro/xgene-next into next/dt64
      Merge tag 'v4.5-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64
      Merge tag 'berlin64-dt-for-4.5-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/dt64
      Merge tag 'arm-soc/for-4.5/devicetree-arm64' of http://github.com/Broadcom/stblinux into next/dt64
      Merge tag 'xgene-dts-fixes-for-v4.5' of https://github.com/AppliedMicro/xgene-next into next/dt64

Bhupesh Sharma (2):
      Documentation: DT: Add entry for ARM SP805-WDT
      dts/ls2080a: Update DTSI to add support of SP805 WDT

Caesar Wang (7):
      arm64: dts: rockchip: Add the thermal data found on RK3368
      arm64: dts: rockchip: Add main thermal info to rk3368.dtsi
      arm64: dts: rockchip: Enable the Thermal on R88 board
      arm64: dts: rockchip: add the pwm node info for RK3368 SoCs
      arm64: dts: rockchip: add rk3368 evaluation board
      arm64: dts: rockchip: correct voltage range for rk3368-evb-act8846 board
      arm64: dts: rockchip: Add the broadcast-timer for RK3368 SoC

Daniel Kurtz (1):
      arm64: dts: mt8173: add timer node

Duc Dang (19):
      arm64: dts: Add the arasan mmc DTS entries for APm X-Gene v2 SoC
      arm64: dts: X-Gene: Do not reset or enable/disable clock for AHB block
      arm64: dts: Add RNG device tree nodes for APM X-Gene v2 platform
      arm64: dts: Add v2m MSI frame nodes for APM X-Gene v2 platforms
      arm64: dts: Add PCIe node for APM X-Gene v2 platforms
      arm64: dts: Add USB nodes for APM X-Gene v1 platforms
      arm64: dts: Add USB nodes for APM X-Gene v2 platforms
      arm64: dts: Add APM X-Gene v1 SoC GFC GPIO controller DTS entries
      arm64: dts: Add APM X-Gene v2 SoC GFC GPIO controller DTS entry
      arm64: dts: Add Designware GPIO dts binding for APM X-Gene v1 platform
      arm64: dts: Add APM X-Gene v2 SoC Designware GPIO controller DTS entry
      arm64: dts: Add APM X-Gene v2 SoC EDAC DTS entries
      arm64: dts: Add Designware I2C controller DTS entries for X-Gene v1 SoC
      arm64: dts: Add Designware I2C controller DTS entries for X-Gene v2 SoC platform
      arm64: dts: Add RTC DTS entry for X-Gene v2 SoC platform
      arm64: dts: Add L2 cache topology for APM X-Gene SoC
      arm64: dts: Fix to use standard DT node names for X-Gene 1 and X-Gene 2 platforms
      arm64: dts: X-Gene v1: I2C0 clock is always on
      arm64: dts: X-Gene v2: I2C1 clock is always on

Fan Chen (1):
      arm64: dts: mediatek: mt8173 PSCI-1.0 support

Gaku Inami (2):
      arm64: dts: r8a7795: Add PSCI node
      arm64: dts: r8a7795: Add Cortex-A57 CPU cores

Geert Uytterhoeven (5):
      arm64: renesas: r8a7795: Add dummy dma-controller nodes
      arm64: renesas: r8a7795: Add all SCIF nodes
      arm64: renesas: salvator-x: Setup ethernet0 alias for U-Boot
      arm64: renesas: r8a7795 dtsi: Add all HSCIF nodes
      arm64: renesas: salvator-x: Add board part number to DT bindings

Georgi Djakov (1):
      arm64: dts: qcom: msm8916: Add fixed rate on-board oscillators

Heiko Stuebner (1):
      arm64: dts: rockchip: Setup rk3368 ethernet0 alias for u-boot

Ivan T. Ivanov (2):
      arm64: dts: qcom: 8x16: UART1 add CTS_N, RTS_N pin configurations
      arm64: dts: qcom: 8x16: UART1 and UART2 use DMA for RX and TX

J. German Rivera (1):
      arm64: dts: Added syscon-reboot node for FSL's LS2080A SoC

Jisheng Zhang (5):
      arm64: dts: berlin4ct: add the pinctrl node
      arm64: dts: berlin4ct: add default pinmux for uart0
      arm64: dts: berlin4ct: add watchdog nodes
      arm64: dts: berlin: PSCI-1.0 support
      arm64: dts: berlin4ct: support cpuidle-dt

Jon Mason (1):
      ARM64: dts: enable clock support for Broadcom NS2

Jon Medhurst (Tixy) (1):
      arm64: dts: juno: Add idle-states to device tree

Kazuya Mizuguchi (2):
      arm64: dts: r8a7795: add EthernetAVB device node
      arm64: dts: r8a7795: enable EthernetAVB on Salvator-X

Kouei Abe (2):
      arm64: dts: r8a7795: Add SATA controller node
      arm64: dts: salvator-x: Enable SATA controller

Kuninori Morimoto (16):
      arm64: renesas: r8a7795: enable PFC
      arm64: renesas: add Salvator-X board support
      arm64: renesas: r8a7795: add I2C support
      arm64: renesas: salvator-x: enable I2C
      arm64: renesas: r8a7795: add AUDIO_DMAC support
      arm64: renesas: r8a7795: Sound SSI PIO support
      arm64: renesas: r8a7795: Sound SSI DMA support
      arm64: renesas: r8a7795: Sound SRC support
      arm64: renesas: r8a7795: Sound DVC support
      arm64: renesas: salvator-x: Sound SSI PIO support
      arm64: renesas: salvator-x: Sound SSI DMA support
      arm64: renesas: salvator-x: Sound SSI DMA support via BUSIF
      arm64: renesas: salvator-x: Sound SRC support
      arm64: renesas: salvator-x: Sound DVC support
      arm64: renesas: salvator-x: set ak4613 In/Out pin as single-end
      arm64: renesas: salvator-x: use CS2000 as AUDIO_CLK_B

Masahiro Yamada (1):
      arm64: dts: uniphier: add PH1-LD10 SoC/board support

Matthias Brugger (1):
      arm64: dts: rockchip: Fix typo in rk3368 sdmmc card detect pin name

Mingkai Hu (2):
      Documentation: DT: Add entry for Freescale LS1043a-RDB board
      arm64: dts: add Freescale LS1043a SoC support

Olof Johansson (6):
      Merge tag 'samsung-dt64-4.5' of https://git.kernel.org/.../krzk/linux into next/dt64
      Merge tag 'zynqmp-dt-for-4.5' of https://github.com/Xilinx/linux-xlnx into next/dt64
      Merge tag 'qcom-arm64-for-4.5' of git://git.kernel.org/.../agross/linux into next/dt64
      Merge tag 'renesas-arm64-dt3-for-v4.5' of git://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'v4.4-next-arm64' of https://github.com/mbgg/linux-mediatek into next/dt64
      Merge tag 'v4.5-rockchip-dts64-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64

Ray Jui (1):
      arm64: dts: Add I2C nodes for NS2

Rob Herring (3):
      arm64: dts: apq8016-sbc: enable UART0 on LS connector
      arm64: dts: apq8016-sbc: add label properties for UART, I2C, and SPI
      arm64: dts: hikey: add label properties to UARTs

Shaohui Xie (1):
      arm64: dts: add LS1043a-RDB board support

Simon Horman (3):
      arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
      MAINTAINERS: Add entry for Renesas arm64 architecture
      arm64: dts: r8a7795: enable nfs root on Salvator-X board

Soren Brinkmann (1):
      ARM64: zynqmp: DT: Add interrupt-controller property to GPIO

Srinivas Kandagatla (2):
      arm64: dts: fix the i2c aliasing to match to schematics.
      arm64: dts: set the default i2c pin drive strength to 16mA

Stephen Boyd (2):
      arm64: dts: qcom: Make msm8916-mtp compatible string compliant
      arm64: dts: qcom: Alias pm8916 on msm8916 devices

Suman Tripathi (1):
      arm64: dts: Add the arasan mmc DTS entries for APM X-Gene v1 SoC

Takeshi Kihara (1):
      arm64: dts: r8a7795: add GPIO nodes

Ulrich Hecht (1):
      arm64: renesas: r8a7795: fix SATA clock assignment

Wolfram Sang (1):
      arm64: renesas: r8a7795: add internal delay for i2c IPs

YH Huang (1):
      arm64: dts: mt8173: add MT8173 display PWM driver support node

Yoshifumi Hosoya (1):
      arm64: dts: r8a7795: Add pmu device nodes


 Documentation/devicetree/bindings/arm/fsl.txt   |   4 +
 .../devicetree/bindings/arm/rockchip.txt        |   4 +
 .../devicetree/bindings/arm/shmobile.txt        |   4 +
 .../devicetree/bindings/watchdog/sp805-wdt.txt  |  31 +
 MAINTAINERS                                     |  10 +
 arch/arm64/Kconfig.platforms                    |  17 +
 arch/arm64/boot/dts/Makefile                    |   2 +
 arch/arm64/boot/dts/apm/apm-merlin.dts          |  12 +
 arch/arm64/boot/dts/apm/apm-mustang.dts         |   4 +
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi      | 391 +++++++++-
 arch/arm64/boot/dts/apm/apm-storm.dtsi          | 114 ++-
 arch/arm64/boot/dts/arm/juno-r1.dts             |  28 +
 arch/arm64/boot/dts/arm/juno.dts                |  28 +
 arch/arm64/boot/dts/broadcom/ns2-svk.dts        |  26 +-
 arch/arm64/boot/dts/broadcom/ns2.dtsi           | 200 ++++-
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 282 ++++++-
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |   7 +
 arch/arm64/boot/dts/freescale/Makefile          |   1 +
 .../boot/dts/freescale/fsl-ls1043a-rdb.dts      | 116 +++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi  | 527 +++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi  |  68 ++
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts  |   7 +
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi      |  63 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts     |  13 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        |  33 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi       |  18 +
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts        |   2 +-
 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi       |   1 +
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi      |  19 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi           | 107 +++
 arch/arm64/boot/dts/qcom/pm8916.dtsi            |   6 +-
 arch/arm64/boot/dts/renesas/Makefile            |   4 +
 .../boot/dts/renesas/r8a7795-salvator-x.dts     | 251 ++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi        | 779 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/Makefile           |   1 +
 .../boot/dts/rockchip/rk3368-evb-act8846.dts    | 176 +++++
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi    | 281 +++++++
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts     |   6 +
 .../arm64/boot/dts/rockchip/rk3368-thermal.dtsi | 112 +++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi        | 105 ++-
 arch/arm64/boot/dts/socionext/Makefile          |   4 +
 .../dts/socionext/uniphier-ph1-ld10-ref.dts     |  95 +++
 .../boot/dts/socionext/uniphier-ph1-ld10.dtsi   | 280 +++++++
 .../boot/dts/socionext/uniphier-pinctrl.dtsi    |   1 +
 .../dts/socionext/uniphier-support-card.dtsi    |   1 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi          |   2 +
 46 files changed, 4217 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/Makefile
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-evb-act8846.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/socionext/Makefile
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ph1-ld10-ref.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ph1-ld10.dtsi
 create mode 120000 arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi
 create mode 120000 arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi
