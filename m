From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2016 02:37:41 +0200
Subject: [GIT PULL 7/8] ARM: 64-bit DT updates for v4.8
In-Reply-To: <3637015.LRn5VyhPVM@wuerfel>
References: <3637015.LRn5VyhPVM@wuerfel>
Message-ID: <4260701.jSIFYMFKfT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f2a89d3b2b85b90b05453872aaabfdb412a21a03:

  arm64: dts: Fix broken architected timer interrupt trigger (2016-09-14 22:47:22 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt64

for you to fetch changes up to c1fd2794a4111501027dc60b3fd9d2a29789ea47:

  Merge tag 'berlin64-dt-for-v4.9-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/dt64 (2016-10-02 22:21:33 -0700)

----------------------------------------------------------------
ARM: 64-bit DT updates for v4.8

The 64-bit DT changes are surprisingly small this time, we only add two
SoC platforms: the ZTE ZX296718 Set-top-box SoC and the SocioNext
UniPhier LD11 TV SoC, each with their reference boards.

There are three new machines added for existing SoC platforms:

- The Marvell Armada 8040 development board is an impressive quad-core
  Cortex-A72 machine with three 10gbit ethernet interfaces

- Qualcomms DragonBoard 820c single-board computer is their current
  high-end phone platform in the 96boards form factor

- Rockchip: Tronsmart Orion r86 set-top-box is a popular mid-range
  Android box based on the 8-core rk3368 SoC.

----------------------------------------------------------------
Alexander Graf (1):
      ARM64: zynqmp: Align gic ranges for 64k in device tree

Andy Yan (2):
      soc: rockchip: add reboot-mode header
      arm64: dts: rockchip: add syscon-reboot-mode DT node

Archit Taneja (2):
      arm64: dts: msm8916: Add display support
      arm64: dts: apq8016-sbc: Add HDMI display support

Arnd Bergmann (15):
      Merge tag 'uniphier-dt64-v4.9' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt64
      Merge tag 'samsung-dt64-4.9' of git://git.kernel.org/.../krzk/linux into next/dt64
      Merge tag 'hisi-soc-dt-for-4.9' of git://github.com/hisilicon/linux-hisi into next/dt64
      Merge tag 'qcom-arm64-for-4.9' of git://git.kernel.org/.../agross/linux into next/dt64
      Merge tag 'mvebu-dt64-4.9-1' of git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'arm-soc/for-4.9/devicetree-arm64' of http://github.com/Broadcom/stblinux into next/dt64
      Merge tag 'v4.9-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64
      Merge tag 'tegra-for-4.9-arm64-dt' of git://git.kernel.org/.../tegra/linux into next/dt64
      Merge tag 'imx-dt64-4.9' of git://git.kernel.org/.../shawnguo/linux into next/dt64
      Merge tag 'v4.8-next-dts64' of https://github.com/mbgg/linux-mediatek into next/dt64
      Merge tag 'zynqmp-dt-for-4.9' of https://github.com/Xilinx/linux-xlnx into next/dt64
      Merge branch 'dt/irq-fix' into next/dt64
      Merge tag 'mvebu-dt64-4.9-2' of git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'xgene-dts-for-v4.9' of https://github.com/AppliedMicro/xgene-next into next/dt64
      Merge tag 'zte-dt64-4.9' of git://git.kernel.org/.../shawnguo/linux into next/dt64

Bjorn Andersson (4):
      arm64: dts: qcom: msm8916: Add smsm and smp2p nodes
      arm64: dts: qcom: msm8916: Add mba memory reserve
      arm64: dts: qcom: msm8916: Make scm a reset-controller
      arm64: dts: qcom: msm8916: Add tcsr syscon

CK Hu (1):
      arm64: dts: mt8173: Add HDMI related nodes

Caesar Wang (5):
      arm64: dts: rockchip: add the saradc for rk3399
      arm64: dts: rockchip: add the gmac power domain on rk3399
      arm64: dts: rockchip: add the tcpc for rk3399 power domain
      arm64: dts: rockchip: change all interrupts cells to 4 on rk3399 SoCs
      arm64: dts: rockchip: support the pmu node for rk3399

Chris Zhong (1):
      arm64: dts: rockchip: add Type-C phy for RK3399

Douglas Anderson (1):
      arm64: dts: rockchip: Add pinctrl entry for 32k clock on rk3399

Duc Dang (2):
      arm64: dts: apm: Add APM X-Gene v2 SoC PMU DTS entries
      arm64: dts: apm: Fix interrupt polarity for X-Gene PCIe legacy interrupts

Elaine Zhang (1):
      arm64: dts: rockchip: add the power domain node for rk3399

Finley Xiao (1):
      arm64: dts: rockchip: add efuse0 device node for rk3399

Frank Wang (2):
      arm64: dts: rockchip: add usb2-phy support for rk3399
      arm64: dts: rockchip: configure usb2-phy support for rk3399-evb

Guodong Xu (3):
      arm64: dts: hikey: extend default cma size to 128MB
      arm64: dts: hi6220: add resets property into dwmmc nodes
      arm64: dts: hi6220: add sd-uhs- properties into dwmmc_1

Heiko Stuebner (1):
      Merge branch 'v4.9-shared/soc-hdr' into v4.9-armsoc/dts64

Jisheng Zhang (3):
      arm64: dts: berlin4ct: switch to Cortex-A53 specific pmu nodes
      arm64: dts: berlin4ct: enable all wdt nodes unconditionally
      arm64: dts: berlin4ct: Add L2 cache topology

John Stultz (2):
      arm64: dts: hikey: Add hikey support for syscon-reboot-mode
      arm64: dts: hikey: Add pstore support for HiKey

Jon Hunter (9):
      arm64: tegra: Drop clock and reset names for XUSB powergates
      arm64: tegra: Add AGIC node for Tegra210
      arm64: tegra: Add ADMA node for Tegra210
      arm64: tegra: Add SOR power-domain for Tegra210
      arm64: tegra: Add ACONNECT, ADMA and AGIC nodes Tegra210 Smaug
      arm64: tegra: Enable DPAUX for Tegra210 Smaug
      arm64: tegra: Add the various audio devices for Tegra210 Smaug
      arm64: tegra: Enable XUSB controller on Tegra210 Smaug
      arm64: tegra: Select PM_GENERIC_DOMAINS

Jorge Ramirez-Ortiz (1):
      arm64: dts: set UART1 clock frequency to 150MHz

Jun Nie (1):
      arm64: dts: Add ZTE ZX296718 SoC dts and Makefile

Kefeng Wang (4):
      arm64: dts: hip05: kill hip05_hns.dtsi
      dt-bindings: hisilicon: Add Hip05 and Hip06 system controller support
      arm64: dts: hip06: Append hns node
      arm64: dts: hip06: Append sas node

Krzysztof Kozlowski (1):
      arm64: dts: exynos: Use human-friendly symbols for timer interrupt flags

Liu Gang (1):
      arm64: dts: ls2080a: Add 'dma-coherent' for ls2080a PCI nodes

Marc Zyngier (1):
      arm64: dts: qcom: Fix broken interrupt trigger settings

Masahiro Yamada (5):
      arm64: dts: uniphier: match DT names to other projects and documents
      arm64: dts: uniphier: add pinctrl property to System Bus node
      arm64: dts: uniphier: use clock/reset controllers
      arm64: dts: uniphier: add specific compatible to SoC-Glue node
      arm64: dts: uniphier: add LD11 SoC/Board support

Matthias Brugger (1):
      arm64: dts: rockchip: Add basic support for orion-r68

Michal Simek (3):
      ARM64: zynqmp: Use 64bit size cell format
      ARM64: zynqmp: Add PCIe node
      ARM64: zynqmp: Add missing interrupt-parent to PMU node

Olof Johansson (1):
      Merge tag 'berlin64-dt-for-v4.9-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/dt64

Philipp Zabel (1):
      arm64: dts: mt8173-evb: enable HDMI output

Punnaiah Choudary Kalluri (1):
      ARM64: zynqmp: Correct the watchdog timer interrupt number

Rajendra Nayak (2):
      arm64: dts: msm8916: Add thermal zones, tsens and qfprom nodes
      arm64: dts: msm8996: Add thermal zones, tsens and qfprom nodes

Roger Chen (2):
      arm64: dts: rockchip: add the gmac needed node for rk3399
      arm64: dts: rockchip: enable the gmac for rk3399 evb board

Shawn Lin (4):
      arm64: dts: rockchip: remove broken-cd from sdio0
      arm64: dts: rockchip: add the PCIe PHY for RK3399
      arm64: dts: rockchip: add the PCIe controller support for RK3399
      arm64: dts: rockchip: configure PCIe support for rk3399-evb

Shunqian Zheng (1):
      arm64: dts: rockchip: set to CCI clock of RK3399 to 600M

Srinivas Kandagatla (8):
      arm64: dts: db820c: add basic board support
      arm64: dts: db820c: add support to LS-UART0
      arm64: dts: db820c: add support to LS-I2C0
      arm64: dts: db820c: add support to LS-I2C1
      arm64: dts: db820c: add support to I2C on HS
      arm64: dts: db820c: add support to LS-SPI0
      arm64: dts: db820c: add support to SPI on HS
      arm64: dts: db820c: add support to external sd card.

Stephen Warren (1):
      arm64: tegra: Simplify Tegra210 GPIO compatible value

Stuart Yoder (2):
      arm64: dts: updates serial aliases for ls1043a rdb and qds boards
      arm64: dts: add stdout-path to chosen node for ls2080a/ls1043a boards

Tai Nguyen (1):
      arm64: dts: apm: Add APM X-Gene SoC PMU DTS entries

Thomas Petazzoni (4):
      arm64: dts: marvell: add description for the slave CP110 in Armada 8K
      arm64: dts: marvell: add description for the Armada 8040 dev board
      arm64: dts: marvell: describe the PIC and PMU on Armada 7K/8K
      arm64: dts: marvell: enable MSI for PCIe on Armada 7K/8K

Xing Zheng (1):
      arm64: dts: rockchip: fix the address map for WDT0 and WDT1

Xinliang Liu (2):
      arm64: dts: Add display subsystem DT nodes for hi6220-hikey
      arm64: dts: Add HDMI node for hi6220-hikey

Yendapally Reddy Dhananjaya Reddy (1):
      arm64: dts: Add PWM DT node for NS2

York Sun (1):
      arm64: dts: Add DDR memory controller for Layerscape SoCs

hotran (2):
      arm64: dts: apm: Add X-Gene SoC hwmon to device tree
      arm64: dts: apm: Add DT node for APM X-Gene 2 CPU clocks


 .../bindings/arm/hisilicon/hisilicon.txt           |  39 +-
 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 Documentation/devicetree/bindings/arm/zte.txt      |  24 +
 arch/arm64/Kconfig.platforms                       |   2 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   8 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   8 +-
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         | 135 ++++-
 arch/arm64/boot/dts/apm/apm-storm.dtsi             | 111 +++-
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  16 +-
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi       |   8 +-
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |  13 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |  14 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |   8 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  15 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  |   3 +
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts  |   4 +
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  26 +-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |  86 ++-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  61 +++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi           |   5 -
 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi       | 180 ------
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts        |  28 +
 arch/arm64/boot/dts/hisilicon/hip06.dtsi           | 365 +++++++++++++
 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 150 +++++
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  22 +-
 .../boot/dts/marvell/armada-cp110-master.dtsi      |   3 +
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 249 +++++++++
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi         |  12 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  38 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  77 +++
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      | 120 ++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  79 ++-
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi |  48 ++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  82 +++
 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi  |  39 ++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts        |  21 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |  88 +++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              | 286 +++++++++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  94 +++-
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    | 382 +++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |   1 -
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  10 +
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        |  87 +++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 607 +++++++++++++++++++--
 arch/arm64/boot/dts/socionext/Makefile             |   4 +-
 .../arm64/boot/dts/socionext/uniphier-ld11-ref.dts | 100 ++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 338 ++++++++++++
 ...hier-ph1-ld20-ref.dts => uniphier-ld20-ref.dts} |  11 +-
 .../{uniphier-ph1-ld20.dtsi => uniphier-ld20.dtsi} | 102 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts        |   2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             | 108 ++--
 arch/arm64/boot/dts/zte/Makefile                   |   5 +
 arch/arm64/boot/dts/zte/zx296718-evb.dts           |  64 +++
 arch/arm64/boot/dts/zte/zx296718.dtsi              | 292 ++++++++++
 include/dt-bindings/soc/rockchip,boot-mode.h       |  15 +
 61 files changed, 4294 insertions(+), 411 deletions(-)
