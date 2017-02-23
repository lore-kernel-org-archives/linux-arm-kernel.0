From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2017 00:10:49 +0100
Subject: [GIT PULL 6/7] ARM: 64-bit DT updates for v4.11
In-Reply-To: <8729461.VkrRdW7LzJ@wuerfel>
References: <8729461.VkrRdW7LzJ@wuerfel>
Message-ID: <5992784.pTmbu8UWnt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt64

for you to fetch changes up to cbab31977008a9eb9eb241879befc2e20285740c:

  Merge tag 'mvebu-dt64-4.11-3' of git://git.infradead.org/linux-mvebu into next/dt64 (2017-02-09 16:20:23 +0100)

----------------------------------------------------------------
ARM: 64-bit DT updates for v4.11

ARM64 DT updates are fairly small this time, only two new SoCs and a handful
of new machines get added, all of them similar to other hardware we already
support.

New SoC:
  - HiSilicon Kirin960/Hi3660 and HiKey960 development board
  - NXP LS1012a with three reference boards
    http://www.nxp.com/products/microcontrollers-and-processors/arm-processors/qoriq-layerscape-arm-processors/qoriq-layerscape-1012a-low-power-communication-processor:LS1012A

New development board:
  - Banana Pi M64, based on Allwinner A64
    http://www.banana-pi.org/m64.html
  - SolidRun MACCHIATOBin based on Marvell Armada 8K
    https://www.solid-run.com/marvell-armada-family/armada-8040-community-board/
  - Broadcom BCM958712DxXMC NorthStar2 reference board (another one)

A lot of platforms improve support for existing machines by adding
extra devices for which a binding and driver is availabe:

Allwinner: MMC, USB
ARM Juno: Coresight, STM
Broadcom: NS2 GICv2m irqchip and PCIe
Marvell: Armada 3700 SPI, I2C, ethernet switch
Mediatek: MT8173 thermal
NXP i.MX: LS1046A thermal
Qualcomm: coresight on MSM8916, HDMI, WCNSS, SCM
Renesas: r8a779[56] thermal, powerdomain, ethernet, sound, pwm, can, can fd
Rockchip: thermal, eDP, pinctrl enhancements
Samsung: TM2 touchkey, Exynos5433 HDMI and power management improvements
UniPhier: SD reset, eMMC controller
ZTE: oppv2 cpufreq

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM64: dts: marvell: Correct license text

Andi Shyti (4):
      pinctrl: dt-bindings: samsung: add drive strength macros for Exynos5433
      arm64: dts: exynos: Use macros for pinctrl configuration on Exynos5433
      arm64: dts: exynos: Comply to the samsung pinctrl naming convention in TM2
      arm64: dts: exynos: Make TM2 and TM2E independent from each other

Andre Przywara (4):
      arm64: allwinner: a64: Add MMC nodes
      arm64: allwinner: pine64: add MMC support
      arm64: allwinner: a64: add UART1 pin nodes
      arm64: allwinner: add BananaPi-M64 support

Andrzej Hajda (6):
      arm64: dts: exynos: Fix addresses in node names on Exynos5433
      arm64: dts: exynos: Add DECON_TV node to Exynos5433
      arm64: dts: exynos: Add HDMI node to Exynos5433
      arm64: dts: exynos: Enable HDMI/TV path on Exynos5433-TM2
      arm64: dts: exynos: configure TV path clocks for Ultra HD modes
      arm64: dts: exynos: set LDO7 regulator as always on

Andy Yan (1):
      arm64: dts: rockchip: use pin constants to describe gpios

Arnd Bergmann (3):
      Merge tag 'sunxi-dt64-for-4.11' of https://git.kernel.org/.../mripard/linux into next/dt64
      Merge tag 'qcom-arm64-for-4.11-2' of git://git.kernel.org/.../agross/linux into next/dt64
      Merge tag 'mvebu-dt64-4.11-3' of git://git.infradead.org/linux-mvebu into next/dt64

Baoyou Xie (1):
      arm64: dts: zx: support cpu-freq for zx296718

Bibby Hsieh (1):
      arm64: dts: mt8173: add mmsel clocks for 4K support

Bjorn Andersson (1):
      ARM: dts: msm8916: Add and enable wcnss node

Brian Norris (2):
      arm64: dts: rockchip: add rk3399 thermal_zones phandle
      arm64: dts: rockchip: add rk3399 eDP HPD pinctrl

Chanwoo Choi (4):
      arm64: dts: exynos: Add PPMU node to Exynos5433
      arm64: dts: exynos: Add bus nodes using VDD_INT for Exynos5433
      arm64: dts: exynos: Add support of bus frequency using VDD_INT on Exynos5433 TM2
      arm64: dts: exynos: Fix wrong values for ldo23 and ldo25 on TM2/TM2E

Chen Feng (3):
      document: dt: add binding for Hi3660 SoC
      dt-bindings: Add a support cpu type for cortex-a73
      arm64: dts: Add dts files for Hisilicon Hi3660 SoC

Chen-Yu Tsai (1):
      arm64: dts: allwinner: Remove no longer used pinctrl/sun4i-a10.h header

Chris Paterson (3):
      arm64: dts: r8a7796: Add CAN external clock support
      arm64: dts: r8a7796: Add CAN support
      arm64: dts: r8a7796: Add CAN FD support

Daniel Kurtz (1):
      arm64: dts: mt8173: Fix cpu_thermal cooling-maps contributions

Geert Uytterhoeven (7):
      arm64: dts: r8a7796: Add all MSIOF nodes
      arm64: renesas: r8a7796/salvator-x: Add board part number to DT bindings
      arm64: dts: r8a7795: Add missing power-domains property for sata
      arm64: dts: r8a7795: Link ARM GIC to clock and clock domain
      arm64: dts: r8a7796: Link ARM GIC to clock and clock domain
      arm64: dts: r8a7795: Mark EthernetAVB device node disabled
      arm64: dts: r8a7796: Mark EthernetAVB device node disabled

Georgi Djakov (1):
      arm64: dts: qcom: msm8916: Use fixed factor xo clock

Harninder Rai (4):
      arm64: dts: Add support for FSL's LS1012A SoC
      Documentation: DT: Add entry for FSL LS1012A RDB, FRDM, QDS boards
      Documentation: DT: add LS1012A compatible for SCFG and DCFG
      dt-bindings: clockgen: Add compatible string for LS1012A

Icenowy Zheng (5):
      arm64: dts: allwinner: add USB1-related nodes of Allwinner A64
      arm64: dts: allwinner: sort the nodes in sun50i-a64-pine64.dts
      arm64: dts: allwinner: enable EHCI1, OHCI1 and USB PHY nodes in Pine64
      arm64: dts: add MUSB node to Allwinner A64 dtsi
      arm64: dts: enable the MUSB controller of Pine64 in host-only mode

Ivan T. Ivanov (3):
      arm64: dts: apq8016-sbc: Add Volume Up key device node
      arm64: dts: apq8016-sbc: Limit MPP4 high state to 1.8V
      arm64: dts: qcom: Add msm8916 CoreSight components

Jaechul Lee (1):
      arm64: dts: exynos: Add TM2 touchkey node

Javier Martinez Canillas (1):
      arm64: dts: exynos: Remove unneeded unit names in Exynos5433 nodes

Jia Hongtao (1):
      arm64: dts: ls1046a: Add TMU device tree support

Jon Mason (4):
      arm64: dts: NS2: enable GICv2m for PAXB/PAXC interfaces
      arm64: dts: NS2: enable PAXC on NS2 SVK
      arm64: dts: NS2: reserve memory for Nitro firmware
      arm64: dts: NS2: add support for XMC form factor

Krzysztof Kozlowski (2):
      Merge branch 'for-v4.11/pinctrl-macros' into next/dt64
      arm64: dts: exynos: Remove unsupported regulator-always-off property from TM2E

Kuninori Morimoto (4):
      arm64: dts: r8a7795: add sound CTU support
      arm64: dts: r8a7795: add sound MIX support
      arm64: dts: h3ulcb: follow sound CTU/MIX supports
      arm64: dts: r8a7795: tidyup audma definition order

Laurent Pinchart (3):
      arm64: dts: renesas: r8a7796: Add EthernetAVB instance
      arm64: dts: r8a7796: salvator-x: Enable EthernetAVB
      arm64: dts: r8a7795: Add PWM support

Marek Szyprowski (2):
      arm64: dts: exynos: Disable pull down for audio pins in Exynos5433 SoCs
      arm64: dts: exynos: Add clocks to Exynos5433 LPASS module

Masahiro Yamada (2):
      arm64: dts: uniphier: add SD-ctrl node for LD11 SoC
      arm64: dts: uniphier: add eMMC controller node for LD11/LD20

Maxime Ripard (2):
      arm64: allwinner: a64: Add MMC pinctrl nodes
      arm64: allwinner: a64: Increase the MMC max frequency

Meng Yi (1):
      arm64: dts: ls2080a-rdb: remove disable status of pca9547

Mike Leach (2):
      arm64: dts: juno: add CoreSight support for Juno r1/r2 variants
      arm64: dts: juno: add missing CoreSight STM component

Olof Johansson (16):
      Merge tag 'renesas-arm64-dt-for-v4.11' of https://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'samsung-dt64-4.11' of git://git.kernel.org/.../krzk/linux into next/dt64
      Merge tag 'mvebu-dt64-4.11-1' of git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'juno-updates-4.11' of git://git.kernel.org/.../sudeep.holla/linux into next/dt64
      Merge tag 'arm-soc/for-4.11/devicetree-arm64' of http://github.com/Broadcom/stblinux into next/dt64
      Merge tag 'v4.11-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64
      Merge tag 'uniphier-dt64-v4.11' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt64
      Merge tag 'qcom-arm64-for-4.11' of git://git.kernel.org/.../agross/linux into next/dt64
      Merge tag 'v4.10-next-dts' of https://github.com/mbgg/linux-mediatek into next/dt64
      Merge tag 'hisi-arm64-dt-for-4.11' of git://github.com/hisilicon/linux-hisi into next/dt64
      Merge tag 'renesas-arm64-dt2-for-v4.11' of https://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'tegra-for-4.11-arm64-dt' of git://git.kernel.org/.../tegra/linux into next/dt64
      Merge tag 'mvebu-dt64-4.11-2' of git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'imx-dt64-4.11' of git://git.kernel.org/.../shawnguo/linux into next/dt64
      Merge tag 'zte-dt64-4.11' of git://git.kernel.org/.../shawnguo/linux into next/dt64
      Merge tag 'samsung-dt64-4.11-2' of git://git.kernel.org/.../krzk/linux into next/dt64

Pankaj Dubey (1):
      arm64: dts: exynos: Fix drive strength of sd0_xxx pin definitions

Robin Murphy (3):
      arm64: dts: juno: add dma-ranges property
      arm64: dts: juno: add ETR SMMU power domain
      arm64: dts: juno: remove motherboard USB node

Romain Perier (4):
      arm64: dts: marvell: Add ethernet switch definition for the ESPRESSObin
      arm64: dts: marvell: Add definition of SPI controller for Armada 3700
      arm64: dts: marvell: Enable spi0 on the board Armada-3720-db
      arm64: dts: marvell: Add I2C definitions for the Armada 3700

Russell King (2):
      arm64: dts: marvell: Add DT for MACCHIATOBin board
      arm64: dts: marvell: add generic-ahci compatibles for CP110 ahci

Sarangdhar Joshi (1):
      arm64: dts: msm8996: Add SCM DT node

Shawn Lin (2):
      arm64: dts: rockchip: add max-link-speed for rk3399
      arm64: dts: rockchip: add aspm-no-l0s for rk3399

Simon Horman (5):
      arm64: dts: r8a7795: Use renesas,rcar-gen3-usb2-phy fallback binding
      arm64: dts: r8a7795: Use Gen 3 fallback compat string for PCIE
      arm64: dts: r8a7795: Use R-Car Gen 3 fallback binding for i2c nodes
      arm64: dts: r8a7796: Use R-Car Gen 3 fallback binding for i2c nodes
      arm64: dts: r8a7796: Use R-Car Gen 3 fallback binding for msiof nodes

Srinivas Kandagatla (3):
      arm64: dts: db820c: fix gpio pinctrl name correctly
      arm64: dts: apq8016-sbc: add support to hdmi audio via adv7533
      arm64: dts: db820c: add support to volume up key

Sudeep Holla (2):
      arm64: dts: juno: remove dtsi nesting inside tree structure
      arm64: dts: juno: refactor CoreSight support on Juno r0

Takeshi Kihara (1):
      arm64: dts: r8a7796: salvator-x: Update memory node to 4 GiB map

Thierry Reding (3):
      arm64: tegra: Use symbolic HSP identifiers
      arm64: tegra: Use symbolic clock identifiers
      arm64: tegra: Use symbolic reset identifiers

Thomas Petazzoni (1):
      arm64: dts: marvell: adjust name of sd-mmc-gop clock in syscon

William wu (1):
      arm64: dts: rockchip: add u2phy clock for ehci and ohci of rk3399

Wolfram Sang (2):
      arm64: dts: r8a7795: Add R-Car Gen3 thermal support
      arm64: dts: r8a7796: Add R-Car Gen3 thermal support

Xing Zheng (1):
      arm64: dts: rockchip: add rockchip,grf property for RK3399 PMUCRU/CRU

dawei.chien at mediatek.com (1):
      arm64: dts: mt8173: add node for thermal calibration

 Documentation/devicetree/bindings/arm/cpus.txt     |    1 +
 Documentation/devicetree/bindings/arm/fsl.txt      |   20 +-
 .../bindings/arm/hisilicon/hisilicon.txt           |    4 +
 Documentation/devicetree/bindings/arm/shmobile.txt |    2 +-
 .../devicetree/bindings/clock/qoriq-clock.txt      |    1 +
 arch/arm64/boot/dts/allwinner/Makefile             |    1 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  120 ++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |   43 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  137 ++-
 arch/arm64/boot/dts/arm/juno-base.dtsi             |   43 +-
 arch/arm64/boot/dts/arm/juno-clocks.dtsi           |    3 +-
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi          |  100 ++
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi      |    7 -
 arch/arm64/boot/dts/arm/juno-r1.dts                |   16 +-
 arch/arm64/boot/dts/arm/juno-r2.dts                |   16 +-
 arch/arm64/boot/dts/arm/juno.dts                   |   27 +-
 arch/arm64/boot/dts/broadcom/Makefile              |    2 +-
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |    4 +
 arch/arm64/boot/dts/broadcom/ns2-xmc.dts           |  191 ++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  123 +-
 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     |  197 ++++
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  373 +++---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1203 ++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1039 +----------------
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |   12 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  123 +-
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    |   14 +-
 arch/arm64/boot/dts/freescale/Makefile             |    3 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts |  115 ++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  |  128 +++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  |   59 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  247 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |   80 ++
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts  |    1 -
 arch/arm64/boot/dts/hisilicon/Makefile             |    1 +
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |   33 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  160 +++
 arch/arm64/boot/dts/marvell/Makefile               |    1 +
 arch/arm64/boot/dts/marvell/armada-371x.dtsi       |   10 +-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |   44 +-
 .../boot/dts/marvell/armada-3720-espressobin.dts   |   76 +-
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |   10 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   39 +-
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |  138 +++
 .../boot/dts/marvell/armada-cp110-master.dtsi      |    5 +-
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |    5 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   13 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   86 +-
 .../arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi |   13 +
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi |   13 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |   32 +
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    |   14 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |   19 +
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         |   13 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  315 ++++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |    6 +
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |    2 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |    2 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  314 +++--
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |   37 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  245 +++-
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi       |   10 +-
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts    |   10 +-
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    |   14 +-
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts    |   10 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |   16 +-
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        |    8 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   41 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |   21 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |   10 +
 arch/arm64/boot/dts/zte/zx296718.dtsi              |   39 +
 include/dt-bindings/pinctrl/samsung.h              |   14 +
 72 files changed, 4788 insertions(+), 1506 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
 create mode 100644 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/ns2-xmc.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
