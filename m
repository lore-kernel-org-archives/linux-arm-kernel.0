From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 20 Mar 2016 22:01:09 +0100
Subject: [GIT PULL 6/8] ARM: 64-bit DT updates for v4.6
In-Reply-To: <10465240.PKeEEAAbCF@wuerfel>
References: <10465240.PKeEEAAbCF@wuerfel>
Message-ID: <5028094.3vsUWGeG8d@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt64

for you to fetch changes up to 8061a17ee3fb3e183873c8be3cfaaa37c41ce679:

  Merge tag 'for-v4.6/gxbb-dt' of https://github.com/carlocaione/linux-meson into next/dt64 (2016-03-12 17:43:08 -0800)

----------------------------------------------------------------
ARM: 64-bit DT updates for v4.6

The arm64 device tree changes make up an increasing portion of
the overall changes, so they are kept separate from the 32-bit
devicetree changes and from the other arm64 updates.

Newly added SoCs and boards are:
 - 96Boards Husky board
 - AMD Overdrive board
 - Amlogic S905 SoC and related Tronsmart boxes
 - Annapurna Labs Alpine family and development board
 - Broadcom Vulcan servers
 - Broadcom Northstar 2 SoC
 - Marvell Armada 3700 family and development board
 - Qualcomm MSM8996 SoC

Additional devices are enabled for existing platforms from
Applied Micro, Hisilicon, Mediatek, Qualcomm, and Renesas and
there are a couple of other updates for Rockchip, Xilinx and
NXP/Freescale.

----------------------------------------------------------------
Ai Kyuse (2):
      arm64: dts: r8a7795: Add SDHI support to dtsi
      arm64: dts: r8a7795: salvator-x: enable SDHI0 & 3

Andreas F?rber (4):
      Documentation: devicetree: amlogic: Document Meson GXBaby
      ARM64: dts: Prepare configs for Amlogic Meson GXBaby
      Documentation: devicetree: amlogic: Document Tronsmart Vega S95 boards
      ARM64: dts: amlogic: Add Tronsmart Vega S95 configs

Antoine Tenart (2):
      arm64: dts: add the Alpine v2 EVP
      arm64: dts: alpine: add the MSIX node in the Alpine v2 dtsi

Anup Patel (4):
      arm64: dts: Add SDHCI DT node for NS2
      arm64: dts: Add ARM SP804 timer DT nodes for NS2
      dt-bindings: watchdog: Add ARM SP805 DT bindings
      arm64: dts: Add ARM SP805 watchdog DT node for NS2

Arnd Bergmann (9):
      Merge tag 'v4.5-next-dts64' of https://github.com/mbgg/linux-mediatek into next/dt64
      Merge tag 'zynqmp-dt-for-4.6' of https://github.com/Xilinx/linux-xlnx into next/dt64
      Merge tag 'arm-soc/for-4.6/devicetree-arm64' of http://github.com/Broadcom/stblinux into next/dt64
      Merge tag 'renesas-arm64-dt2-for-v4.6' of git://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'hip05-dt-for-4.6' of git://github.com/hisilicon/linux-hisi into next/dt64
      Merge tag 'xgene-dts-for-v4.6-part1' of https://github.com/AppliedMicro/xgene-next into next/dt64
      Merge tag 'xgene-dts-for-v4.6-part2' of https://github.com/AppliedMicro/xgene-next into next/dt64
      Merge tag 'qcom-arm64-for-4.6' of git://git.kernel.org/.../agross/linux into next/dt64
      Merge tag 'imx-dt64-4.6' of git://git.kernel.org/.../shawnguo/linux into next/dt64

Bayi Cheng (1):
      arm64: dts: mt8173: Add nor flash node

Brijesh Singh (2):
      dtb: amd: Fix GICv2 hypervisor and virtual interface sizes
      dtb: amd: Add KCS device tree node

Dirk Behme (2):
      arm64: dts: r8a7795: pmu: switch to Cortex specific device nodes
      arm64: dts: r8a7795: Add GIC-400 virtual interfaces

Duc Dang (7):
      arm64: dts: apm: Update GPIO to control power-off on X-Gene v1 platforms
      arm64: dts: apm: Update GPIO standby controller DT node for X-Gene v2 platforms
      arm64: dts: apm: Update GPIO to control power-off on X-Gene v2 platforms
      arm64: dts: apm: mailbox device tree node for APM X-Gene platform.
      arm64: dts: apm: Add DT node for X-Gene v1 SLIMpro Mailbox I2C Driver
      arm64: dts: apm: Mailbox device tree node for APM X-Gene v2 platform.
      arm64: dts: apm: Add DT node for X-Gene v2 SLIMpro Mailbox I2C Driver

Eddie Huang (1):
      ARM64: dts: Mediatek: mt8173-evb: fix access MMC fail issue

Geert Uytterhoeven (8):
      arm64: dts: r8a7795: Complete SYS-DMAC nodes
      arm64: dts: r8a7795: Add SCIF fallback compatibility strings
      arm64: dts: r8a7795: Rename the serial port clock to fck
      arm64: dts: r8a7795: Add BRG support for (H)SCIF
      arm64: dts: salvator-x: Enable SCIF_CLK frequency and pins
      arm64: dts: r8a7795: Add L2 cache-controller nodes
      arm64: dts: r8a7795: Add missing properties to CA57 L2 cache node
      arm64: dts: r8a7795: Add CA53 L2 cache-controller node

Georgi Djakov (1):
      arm64: dts: qcom: msm8916: Add RPMCC DT node

Gregory CLEMENT (4):
      Documentation: dt-bindings: Add a new compatible for the Armada 3700
      Documentation: dt: Tidy up the Marvell related files
      devicetree: bindings: add DT binding for the Marvell Armada 3700 SoC family
      arm64: dts: add the Marvell Armada 3700 family and a development board

Ivan T. Ivanov (1):
      arm64: dts: qcom: Fix MPP's function used for LED control

Jayachandran C (1):
      dt-bindings: Add documentation for Broadcom Vulcan

Kefeng Wang (5):
      arm64: dts: hip05: Add L2 cache topology
      arm64: dts: hip05: Use Cortex specific device node for pmu
      arm64: dts: hip05: Append all gicv3 ITS entries
      arm64: dts: hip05: Append gpio nodes
      arm64: dts: hip05: Append power button node for D02 board

Lijun Pan (1):
      arm64: dts: ls2080a: Add quirk for Erratum A009116

Loc Ho (1):
      arm64: dts: apm: Update Merlin DT PCP PLL clock node for v2 hardware

Magnus Damm (1):
      arm64: dts: r8a7795: Add INTC-EX device node

Matthias Brugger (1):
      devicetree: bindings: Add vendor prefix for Tronsmart

Michal Simek (2):
      ARM64: zynqmp: Keep gpio node alphabetically sorted
      ARM64: zynqmp: Extract clock information from EP108

Olof Johansson (5):
      Merge tag 'renesas-arm64-dt-for-v4.6' of git://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'v4.6-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64
      Merge tag 'mvebu-dt64-4.6-1' of git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'mvebu-dt64-4.6-2' of git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'for-v4.6/gxbb-dt' of https://github.com/carlocaione/linux-meson into next/dt64

Quan Nguyen (1):
      arm64: dts: apm: Update X-Gene standby GPIO controller DTS entries

Rajendra Nayak (1):
      arm64: dts: msm8996: Add #power-domain-cells property

Rajesh Bhagat (1):
      arm64: dts: ls1043a: Add quirk for Erratum A009116

Ray Jui (1):
      arm64: dts: Add PCIe0 and PCIe4 DT nodes for NS2

Shawn Lin (1):
      arm64: dts: rockchip: add rk3368 tuning clk for emmc and sdmmc

Simon Horman (2):
      arm64: dts: r8a7795: use GIC_* defines
      arm64: dts: r8a7795: use fallback etheravb compatibility string

Srinivas Kandagatla (15):
      arm64: dts: apq8016-sbc: Add aliases to spi device.
      arm64: dts: qcom: remove redundant spi cs pins from pinconf
      arm64: dts: qcom: add correct drive strenght on cs pins
      arm64: dts: remove s2 regulator from smd regulators.
      arm64: dts: qcom: add lable for smd rpm regulators
      arm64: dts: apq8016-sbc: add regulators support
      arm64: dts: apq8016-sbc: make 1.8v available on LS expansion
      arm64: dts: apq8016-sbc: move sdhci node under soc node
      arm64: dts: apq8016-sbc: Add real regulators and pinctrl for sdhc
      arm64: dts: qcom: add manual pullup setting to otg.
      arm64: dts: qcom: apq8016-sbc: add usb support
      arm64: dts: qcom: add audio pinctrls
      arm64: dts: qcom: add lpass node
      arm64: dts: qcom: apq8016-sbc: enable lpass on DB410c
      arm64: dts: qcom: fix usb digital voltage levels

Stephen Boyd (6):
      arm64: dts: Add msm8996 SoC and MTP board support
      arm64: dts: qcom: Add pm8994, pmi8994, pm8004 PMIC skeletons
      arm64: dts: qcom: Add pm8994 gpios and MPPs
      arm64: dts: Rename qcom,gcc node to clock-controller
      arm64: dts: Add L2 cache node to msm8916
      ARM64: dts: qcom: Remove size elements from pmic reg properties

Sudeep Holla (1):
      arm64: dts: rockchip: replace gpio-key,wakeup with wakeup-source property

Suravee Suthikulpanit (10):
      MAINTAINERS: Adding Maintainers for AMD Seattle Device Tree
      dtb: amd: Fix DMA ranges in device tree
      dtb: amd: Fix typo in SPI device nodes
      dtb: amd: Misc changes for I2C device nodes
      dtb: amd: Misc changes for SATA device tree nodes
      dtb: amd: Misc changes for GPIO devices
      dtb: amd: Add PERF CCN-504 device tree node
      dtb: amd: Add support for new AMD Overdrive boards
      dtb: amd: Add support for AMD/Linaro 96Boards Enterprise Edition Server board
      arm64: dts: amd: Fix-up for ccn504 and kcs nodes

Thomas Petazzoni (3):
      arm64: dts: marvell: add Device Tree files for Armada 7K/8K
      arm64: dts: marvell: update Armada AP806 clock description
      arm64: dts: marvell: re-order Device Tree nodes for Armada AP806

Tom Lendacky (1):
      dtb: amd: Add AMD XGBE device tree file

Yoshihiro Shimoda (7):
      arm64: dts: r8a7795: Add USB3.0 host device nodes
      arm64: dts: salvator-x: enable usb3.0 host channel 0
      arm64: dts: r8a7795: Add USB-DMAC device nodes
      arm64: dts: r8a7795: add usb2_phy device nodes
      arm64: dts: r8a7795: add USB2.0 Host (EHCI/OHCI) device nodes
      arm64: dts: salvator-x: enable usb2_phy of channel 1 and 2
      arm64: dts: salvator-x: enable USB 2.0 Host of channel 1 and 2

andrew-ct.chen at mediatek.com (1):
      dts: arm64: Add EFUSE device node

 Documentation/devicetree/bindings/arm/amlogic.txt  |   7 +
 .../bindings/arm/bcm/brcm,vulcan-soc.txt           |  10 +
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 .../arm/{ => marvell}/armada-370-xp-pmsu.txt       |   0
 .../bindings/arm/{ => marvell}/armada-370-xp.txt   |   0
 .../bindings/arm/{ => marvell}/armada-375.txt      |   0
 .../bindings/arm/marvell/armada-37xx.txt           |  16 +
 .../{ => marvell}/armada-380-mpcore-soc-ctrl.txt   |   0
 .../bindings/arm/{ => marvell}/armada-38x.txt      |   0
 .../bindings/arm/{ => marvell}/armada-39x.txt      |   0
 .../bindings/arm/marvell/armada-7k-8k.txt          |  24 +
 .../arm/{ => marvell}/armada-cpu-reset.txt         |   0
 .../arm/{ => marvell}/coherency-fabric.txt         |   0
 .../bindings/arm/{ => marvell}/kirkwood.txt        |   0
 .../bindings/arm/{ => marvell}/marvell,berlin.txt  |   0
 .../bindings/arm/{ => marvell}/marvell,dove.txt    |   0
 .../arm/{ => marvell}/marvell,kirkwood.txt         |   0
 .../arm/{ => marvell}/mvebu-cpu-config.txt         |   0
 .../arm/{ => marvell}/mvebu-system-controller.txt  |   0
 .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 .../devicetree/bindings/watchdog/arm,sp805.txt     |  17 +
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/Makefile                       |   2 +
 arch/arm64/boot/dts/al/Makefile                    |   5 +
 arch/arm64/boot/dts/al/alpine-v2-evp.dts           |  53 ++
 arch/arm64/boot/dts/al/alpine-v2.dtsi              | 236 +++++++++
 arch/arm64/boot/dts/amd/Makefile                   |   4 +-
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts   |  87 ++++
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts   |  91 ++++
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi       | 104 +++-
 arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi    | 117 +++++
 arch/arm64/boot/dts/amd/husky.dts                  |  83 ++++
 arch/arm64/boot/dts/amlogic/Makefile               |   7 +
 .../boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts  |  55 +++
 .../boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts   |  55 +++
 .../boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts |  55 +++
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  55 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 183 +++++++
 arch/arm64/boot/dts/apm/apm-merlin.dts             |   3 +-
 arch/arm64/boot/dts/apm/apm-mustang.dts            |   3 +-
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         |  27 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  22 +
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |  12 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi              | 140 ++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   3 +
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   2 +
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts        |  18 +
 arch/arm64/boot/dts/hisilicon/hip05.dtsi           |  92 +++-
 arch/arm64/boot/dts/marvell/Makefile               |   5 +
 arch/arm64/boot/dts/marvell/armada-371x.dtsi       |  53 ++
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |  86 ++++
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |  63 +++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       | 131 +++++
 arch/arm64/boot/dts/marvell/armada-7020.dtsi       |  54 +++
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |  92 ++++
 arch/arm64/boot/dts/marvell/armada-7040.dtsi       |  54 +++
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |  54 +++
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |  54 +++
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |  71 +++
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |  84 ++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 237 +++++++++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   3 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  16 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi |   2 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi |  14 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          | 170 ++++++-
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         | 238 ++++++++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  48 +-
 arch/arm64/boot/dts/qcom/msm8996-mtp.dts           |  21 +
 arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi          |  30 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 269 +++++++++++
 arch/arm64/boot/dts/qcom/pm8004.dtsi               |  19 +
 arch/arm64/boot/dts/qcom/pm8916.dtsi               |  10 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi               |  62 +++
 arch/arm64/boot/dts/qcom/pmi8994.dtsi              |  19 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 139 ++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 531 +++++++++++++++++----
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi       |   2 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |   2 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  10 +-
 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi   |  88 ++++
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts        |   1 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  61 +--
 85 files changed, 4200 insertions(+), 193 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp-pmsu.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-375.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-380-mpcore-soc-ctrl.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-38x.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-39x.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.txt
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-cpu-reset.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/coherency-fabric.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/kirkwood.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,berlin.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,dove.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,kirkwood.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-cpu-config.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-system-controller.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/watchdog/arm,sp805.txt
 create mode 100644 arch/arm64/boot/dts/al/Makefile
 create mode 100644 arch/arm64/boot/dts/al/alpine-v2-evp.dts
 create mode 100644 arch/arm64/boot/dts/al/alpine-v2.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
 create mode 100644 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
 create mode 100644 arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/husky.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/Makefile
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-371x.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-db.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-372x.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-37xx.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-7020.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-7040-db.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-7040.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8020.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap806.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8004.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8994.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmi8994.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
