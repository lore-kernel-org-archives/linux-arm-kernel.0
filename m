From: olof@lixom.net (Olof Johansson)
Date: Mon, 31 Aug 2015 17:07:10 -0700
Subject: [GIT PULL 7/7] ARM: SoC 64-bit changes for v4.3
In-Reply-To: <1441066030-23225-1-git-send-email-olof@lixom.net>
References: <1441066030-23225-1-git-send-email-olof@lixom.net>
Message-ID: <1441066030-23225-8-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's our branch of ARM64 contents for this merge window.

Most of this is DT contents for new SoCs (or those who have seen new
device support added). Maybe we should stop separating out the arm64
contents here to avoid the kind of internal conflicts as we got this
time around, where 32- and 64-bit contents conflicted.

Anyhow, on the actual contents:

New SoCs:

- Broadcom North Star 2 (ns2)
- Marvell Berlin4CT
- Mediatek MT6795
- Rockchip RK3368

In addition, there are enhancements for the following platforms:

- Mediatek MT8173: cpuidle-dt updates, misc other additions
- ZyncMP: A bunch of devices added to the existing DTSI
- Qualcomm MSM8916 and APQ8016 updates for USB, etc.

+ A handful of other updates for various platforms


Conflicts:

Documentation/devicetree/bindings/serial/mtk-uart.txt:

Add/add conflict with 32-bit DT additions of MT6795 and 64-bit addition
of MT8173.
Keep both sides, which means rewrapping the last line. Entries are
sorted in decreasing order, which is a bit unusual.

----------------------------------------------------------------

The following changes since commit c055798226422b953ee59e68ba33f4a9bfc894bb:

  Merge branch 'next/defconfig' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-arm64

for you to fetch changes up to 341a670abd1c086d44e09901f0ebee3dd86a60ba:

  ARM64: dts: vexpress: Use assigned-clock-parents for sp810

----------------------------------------------------------------

Chunyan Zhang (1):
      arm64: dts: sprd: adding ETM entries to Spreadtrum SC9836

Eddie Huang (4):
      arm64: dts: mt8173: Add watchdog device node
      arm64: dts: mt8173: Add I2C device node
      arm64: dts: mt8173-evb: Add PMIC support
      arm64: dts: mediatek: Add MT8173 MMC dts

Heiko Stuebner (11):
      clk: rockchip: rk3288: add CLK_SET_RATE_PARENT to sclk_mac
      clk: rockchip: fix faulty vip parent name on rk3288
      clk: rockchip: protect register macros against multipart values
      clk: rockchip: add COMPOSITE_NOGATE_DIVTBL variant
      clk: rockchip: add support for phase inverters
      clk: rockchip: fix issues in the mmc-phase clock
      clk: rockchip: define the inverters of rk3066/rk3188 and rk3288
      dt-bindings: add documentation of rk3668 clock controller
      clk: rockchip: add dt-binding header for rk3368
      clk: rockchip: add missing include guards
      clk: rockchip: add rk3368 clock controller

Heiko St?bner (3):
      arm64: add Rockchip architecture entry
      arm64: defconfig: enable ARCH_ROCKCHIP
      arm64: dts: add Rockchip rk3368 core dtsi and board dts for the r88 board

Henry Chen (1):
      dts: mt8173-evb: Add da9211 to i2c1

Howard Chen (1):
      ARM: dts: mt8173: support arm64 cpuidle-dt

Ivan T. Ivanov (6):
      arm64: dts: qcom: Extend msm8916 pinctrl device coverage
      arm64: dts: qcom: Add msm8916 BLSP device nodes
      arm64: dts: qcom: Add msm8916 USB configuration nodes
      arm64: dts: qcom: apq8016-sbc: Don't hog client driver pins
      arm64: dts: qcom: Fix apq8016-sbc board USB related pin definitions
      arm64: dts: qcom: Add apq8016-sbc board LED's related device nodes

Jisheng Zhang (3):
      arm64: dts: Add dts files for Marvell Berlin4CT SoC
      arm64: Enable Marvell Berlin SoC family in Kconfig
      arm64: Enable Marvell Berlin SoC family in defconfig

Koro Chen (1):
      arm64: dts: mt8173: Add afe device node

Mars Cheng (2):
      Document: DT: Add bindings for mediatek MT6795 SoC Platform
      arm64: dts: mediatek: add mt6795 support

Michal Simek (10):
      ARM64: zynqmp: Use zynqmp specific compatible string for gpio
      ARM64: zynqmp: Add CANs node for platform
      ARM64: zynqmp: Add SMMU support
      ARM64: zynqmp: Add DWC3 usb support
      ARM64: zynqmp: Enable watchdog on ep108
      ARM64: zynqmp: Enable sdhci on ep108
      ARM64: zynqmp: Add eeprom memories on i2c bus
      ARM64: zynqmp: Enable spi flashes on ep108
      ARM64: zynqmp: Move uart and ttcs to the right location
      ARM64: zynqmp: Move SPI nodes to the right location

Olof Johansson (8):
      arm64: Split out platform options to separate Kconfig
      Merge branch 'depends/clk-rk3368' into next/arm64
      arm64: fix Kconfig include path
      Merge tag 'v4.2-next-arm64' of https://github.com/mbgg/linux-mediatek into next/arm64
      Merge tag 'qcom-arm64-for-4.3' of git://codeaurora.org/quic/kernel/agross-msm into next/arm64
      Merge tag 'zynqmp-dt-for-4.3' of https://github.com/Xilinx/linux-xlnx into next/arm64
      Merge tag 'v4.2-next-arm64-2' of https://github.com/mbgg/linux-mediatek into next/arm64
      Merge tag 'berlin64-for-v4.3-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/arm64

Ray Jui (5):
      PCI: iproc: enable arm64 support for iProc PCIe
      PCI: iproc: Fix ARM64 dependency in Kconfig
      arm64: Add Broadcom iProc family support
      arm64: dts: Add Broadcom North Star 2 support
      PCI: iproc: Fix BCMA dependency in Kconfig

Sascha Hauer (4):
      arm64: dts: mt8173: Add clock controller device nodes
      arm64: dts: mt8173: Use real clock for UARTs
      arm64: dts: mt8173: Add PMIC wrapper device node
      ARM64: MediaTek MT8173: Add SCPSYS device node

Scott Shu (1):
      ARM64: dts: mt6795: enable basic SMP bringup for MT6795

Srinivas Kandagatla (1):
      arm64: dts: qcom: Add msm8916 sdhci configuration nodes

Stephen Boyd (1):
      ARM64: dts: vexpress: Use assigned-clock-parents for sp810

Suneel Garapati (1):
      devicetree: xilinx: zynqmp: add sata node


 .../devicetree/bindings/arm/bcm/ns2.txt         |   9 +
 .../devicetree/bindings/arm/mediatek.txt        |   9 +-
 .../bindings/arm/mediatek/mediatek,sysirq.txt   |   3 +-
 .../bindings/clock/rockchip,rk3368-cru.txt      |  61 ++
 .../devicetree/bindings/serial/mtk-uart.txt     |   5 +-
 arch/arm64/Kconfig                              | 105 +--
 arch/arm64/Kconfig.platforms                    | 125 +++
 arch/arm64/boot/dts/Makefile                    |   3 +
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi   |   2 +
 .../arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi |   2 +
 arch/arm64/boot/dts/broadcom/Makefile           |   5 +
 arch/arm64/boot/dts/broadcom/ns2-svk.dts        |  59 ++
 arch/arm64/boot/dts/broadcom/ns2.dtsi           | 118 +++
 arch/arm64/boot/dts/marvell/Makefile            |   5 +
 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts   |  66 ++
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi      | 164 ++++
 arch/arm64/boot/dts/mediatek/Makefile           |   1 +
 arch/arm64/boot/dts/mediatek/mt6795-evb.dts     |  41 +
 arch/arm64/boot/dts/mediatek/mt6795.dtsi        | 175 ++++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts     | 353 ++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        | 327 ++++++-
 .../boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi    |  34 +-
 .../boot/dts/qcom/apq8016-sbc-soc-pins.dtsi     |  14 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi       |  51 ++
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi      | 430 +++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi           | 227 ++++-
 arch/arm64/boot/dts/rockchip/Makefile           |   5 +
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts     | 354 ++++++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi        | 900 +++++++++++++++++++
 arch/arm64/boot/dts/sprd/sc9836.dtsi            |  99 +-
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts     |  89 ++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi          | 233 +++--
 arch/arm64/configs/defconfig                    |   4 +
 drivers/clk/rockchip/Makefile                   |   2 +
 drivers/clk/rockchip/clk-inverter.c             | 116 +++
 drivers/clk/rockchip/clk-mmc-phase.c            |   6 +-
 drivers/clk/rockchip/clk-rk3188.c               |   9 +-
 drivers/clk/rockchip/clk-rk3288.c               |  13 +-
 drivers/clk/rockchip/clk-rk3368.c               | 881 ++++++++++++++++++
 drivers/clk/rockchip/clk.c                      |   7 +
 drivers/clk/rockchip/clk.h                      |  72 +-
 drivers/pci/host/Kconfig                        |   4 +-
 drivers/pci/host/pcie-iproc.c                   |  27 +-
 drivers/pci/host/pcie-iproc.h                   |   4 +-
 include/dt-bindings/clock/rk3066a-cru.h         |   5 +
 include/dt-bindings/clock/rk3188-cru-common.h   |   5 +
 include/dt-bindings/clock/rk3188-cru.h          |   5 +
 include/dt-bindings/clock/rk3288-cru.h          |   5 +
 include/dt-bindings/clock/rk3368-cru.h          | 384 ++++++++
 49 files changed, 5341 insertions(+), 282 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/ns2.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.txt
 create mode 100644 arch/arm64/Kconfig.platforms
 create mode 100644 arch/arm64/boot/dts/broadcom/Makefile
 create mode 100644 arch/arm64/boot/dts/broadcom/ns2-svk.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/ns2.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/Makefile
 create mode 100644 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
 create mode 100644 arch/arm64/boot/dts/marvell/berlin4ct.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6795-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6795.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/Makefile
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-r88.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368.dtsi
 create mode 100644 drivers/clk/rockchip/clk-inverter.c
 create mode 100644 drivers/clk/rockchip/clk-rk3368.c
 create mode 100644 include/dt-bindings/clock/rk3368-cru.h
