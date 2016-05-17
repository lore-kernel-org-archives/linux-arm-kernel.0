From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 00:24:13 +0200
Subject: [GIT PULL 5/7] ARM: 64-bit DT updates for v4.7
In-Reply-To: <8749147.ztcb6kVhye@wuerfel>
References: <8749147.ztcb6kVhye@wuerfel>
Message-ID: <2552078.Axrq2ryspa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt64

for you to fetch changes up to 9910f5b199621aecfbdb0b63feb31ddd41fd63e2:

  Merge tag 'imx-dt64-4.7' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into next/dt64 (2016-05-10 22:19:36 +0200)

----------------------------------------------------------------
ARM: 64-bit DT updates for v4.7

We continue ramping up platform support for 64-bit ARM machines,
with 111 individual non-merge changesets touching 21 platforms.

The LG1312 platform is completely new and is the first ARM
platform by LG that we support in the mainline kernel. Two other
SoCs got added that are updated versions of existing SoC
families, so the port mainly consists of new dts files:
- The Hisilicon Hip06/D03 is the latest server platform
  from Huawei/Hisilicon, and follows the Hip05/D02 platform.
- Rockchip RK3399 follows the 32-bit RK3288 that is popular
  in low-end Chromebooks and the 64-bit RK3368 that is mainly
  found in chinese Android TV boxes.

The 96Boards HiKey based on the Hisilicon Hi6220 (Kirin 620)
gets a long-awaited overhaul with a lot of devices enabled in
the DT, so it should be much more usable with a mainline kernel
now. See also
https://plus.google.com/111524780435806926688/posts/PeGb2VsNhJd

A lot of work went into enabling new device drivers on existing
machines, but we also have a couple of new commercially
available machines:

- Google Pixel C laptop based on Tegra210
- Hardkernel Odroid C2 Based on Amlogic Meson GXBB (S905)
- Geekbuying GeekBox based on Rockchip RK3368

And finally, a couple of reference or development platforms
that are not end-user platforms but are used for trying out
the respective SoC platforms:

- Amlogic Meson GXBB P200 and P201 development systems
- NXP Layerscape 1043A QDS development board
- Hisilicon Hip06 D03 server board, as mentioned above
- LG1312 Reference Design
- RK3399 Evaluation Board

----------------------------------------------------------------
Alexandre Courbot (5):
      dt-bindings: gk20a: Fix typo in compatible name
      dt-bindings: gk20a: Document iommus property
      dt-bindings: Add documentation for GM20B GPU
      arm64: tegra: Add reference clock to GM20B on Tegra210
      arm64: tegra: Add IOMMU node to GM20B on Tegra210

Alim Akhtar (2):
      arm64: dts: exynos: Add TMU node for exynos7
      arm64: dts: Add nodes for pdma0 and pdma1 for exynos7

Andreas F?rber (9):
      dt-bindings: Add vendor prefix for GeekBuying.com
      arm64: dts: rockchip: Clean up gpio-keys nodes
      ARM64: dts: amlogic: Clean up Vega S95 /memory nodes
      arm64: dts: rockchip: Add rk3368 GeekBox dts
      Documentation: devicetree: rockchip: Document rk3368-GeekBox
      arm64: dts: marvell: clean up armada-7040-db
      arm64: dts: marvell: rename armada-ap806 XOR nodes
      arm64: dts: marvell: Clean up armada-3720-db
      arm64: dts: marvell: Rename armada-37xx USB node

Anup Patel (4):
      arm64: dts: Add ARM PL330 DMA DT node for NS2
      arm64: dts: Add maintenance interrupt for GIC in NS2 DT
      arm64: dts: Move NS2 clock DT nodes to separate DT file
      arm64: dts: Add ARM PL022 SPI DT nodes for NS2

Arnd Bergmann (15):
      Merge tag 'samsung-dt64-4.7' of git://git.kernel.org/.../krzk/linux into next/dt64
      Merge tag 'tegra-for-4.7-arm64' of git://git.kernel.org/.../tegra/linux into next/dt64
      Merge tag 'juno-for-v4.7/dt-updates' of git://git.kernel.org/.../sudeep.holla/linux into next/dt64
      Merge tag 'hi6220-dt-for-4.7' of git://github.com/hisilicon/linux-hisi into next/dt64
      Merge tag 'xgene-dts-for-v4.7-part1' of https://github.com/AppliedMicro/xgene-next into next/dt64
      Merge tag 'arm-soc/for-4.7/devicetree-arm64' of http://github.com/Broadcom/stblinux into next/dt64
      Merge tag 'renesas-arm64-dt2-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'hip0x-dt-for-4.7' of git://github.com/hisilicon/linux-hisi into next/dt64
      Merge branch 'renesas/fixes-2' into next/dt64
      Merge tag 'v4.7-rockchip-dts64-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64
      Merge tag 'mvebu-dt64-4.7-1' of git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'tegra-for-4.7-gpio' of git://git.kernel.org/.../tegra/linux into next/dt64
      Merge tag 'tegra-for-4.7-gm20b' of git://git.kernel.org/.../tegra/linux into next/dt64
      Merge tag 'v4.6-next-dts64' of https://github.com/mbgg/linux-mediatek into next/dt64
      Merge tag 'imx-dt64-4.7' of git://git.kernel.org/.../shawnguo/linux into next/dt64

Brian Starkey (1):
      arm64: dts: juno: Add external expansion bus to DT

Caesar Wang (3):
      arm64: dts: rockchip: fix the incorrect otp-out pin on rk3368
      arm64: dts: rockchip: Add rk3368 mailbox device nodes
      arm64: dts: rockchip: move the rk3368 thermal data into rk3368.dtsi

Chanho Min (1):
      arm64: dts: Add dts files for LG Electronics's lg1312 SoC

Chen Feng (1):
      arm64: dts: hikey: Add hi655x pmic dts node

Geert Uytterhoeven (3):
      ARM: shmobile: timer: Fix preset_lpj leading to too short delays
      arm64: dts: r8a7795: Don't disable referenced optional scif clock
      arm64: dts: r8a7795: Don't disable referenced optional clocks

Gregory CLEMENT (2):
      arm64: dts: marvell: Use a SoC-specific compatible for xHCI on Armada37xx
      arm64: dts: marvell: add XOR node for Armada 3700 SoC

Guodong Xu (4):
      arm64: dts: hikey: enable i2c0 and i2c1 for working with mezzanine boards
      arm64: dts: hi6220: add pinctrl for uarts and enable them
      arm64: dts: add LED nodes for hi6220-hikey
      arm64: dts: add wifi nodes support for hi6220-hikey

Heiko Stuebner (2):
      clk: rockchip: fix checkpatch errors in rk3399 dt-binding header
      Merge branch 'v4.7-shared/clkids' into v4.7-armsoc/dts64

Hou Zhiqiang (1):
      Documentation: DT: Add entry for Freescale LS1043a-QDS board

Jianqun Xu (3):
      arm64: dts: rockchip: add core dtsi file for RK3399 SoCs
      arm64: dts: rockchip: add dts file for RK3399 evaluation board
      dt-bindings: document rockchip rk3399-evb board

Jon Hunter (3):
      arm64: tegra: Add support for Google Pixel C
      arm64: tegra: Remove unused #power-domain-cells property
      arm64: tegra: Add stdout-path for various boards

Kefeng Wang (4):
      arm64: dts: hip05: fix its node without msi-cells
      arm64: dts: hip05: Add nor flash support
      arm64: dts: Add initial dts for Hisilicon Hip06 D03 board
      Documentation: arm64: Add Hisilicon Hip06 D03 dts binding

Kevin Hilman (4):
      ARM64: dts: amlogic: update serial aliases
      Documentation: devicetree: amlogic: Document P20x and ODROID-C2 boards
      ARM64: dts: amlogic: add Hardkernel ODROID-C2
      ARM64: dts: amlogic: Add P200/P201 boards

Laxman Dewangan (1):
      arm64: tegra: Enable power and volume keys on Jetson TX1

Leo Yan (8):
      arm64: dts: Reserve memory regions for hi6220
      arm64: dts: add sp804 timer node for Hi6220
      arm64: dts: enable idle states for Hi6220
      arm64: dts: add mailbox node for Hi6220
      arm64: dts: add Hi6220's stub clock node
      arm64: dts: register Hi6220's thermal sensor
      arm64: dts: register Hi6220's thermal zone for power allocator
      arm64: dts: Add L2 cache topology to Hi6220

Liu Gang (2):
      arm64: dts: ls1043a: Add compatible "fsl,qoriq-gpio" for ls1043a gpio nodes
      arm64: dts: ls2080a: Add compatible "fsl,ls2080a-gpio" for ls2080a gpio nodes

Luke Starrett (1):
      arm64: dts: NS2 secondary core enablement via PSCI

Masahiro Yamada (2):
      arm64: dts: uniphier: use Daughter board on PH1-LD20 reference board
      arm64: dts: uniphier: add reference clock node for PH1-LD20

Olof Johansson (3):
      Merge tag 'gxbb-dt64' of https://github.com/carlocaione/linux-meson into next/dt64
      Merge tag 'renesas-arm64-cleanup-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'v4.7-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64

Phil Edworthy (2):
      arm64: dts: r8a7795: Add PCIe nodes
      arm64: dts: r8a7795: enable PCIe on Salvator-X

Ramesh Shanmugasundaram (2):
      arm64: dts: r8a7795: Add CAN external clock support
      arm64: dts: r8a7795: Add CAN support

Rameshwar Prasad Sahu (1):
      arm64: dts: apm: Fix compatible string for X-Gene 2 SATA controller DTS node

Rhyland Klein (3):
      arm64: tegra: Add gpio-keys nodes for Smaug
      arm64: tegra: Add pinmux for Smaug board
      arm64: tegra: Enable cros-ec and charger on Smaug

Sascha Hauer (1):
      ARM64: dts: mt8173: Add thermal/auxadc device nodes

Shaohui Xie (1):
      arm64: dts: add LS1043a-QDS board support

Shawn Lin (2):
      arm64: dts: rockchip: remove broken-cd from emmc and sdio
      dt-bindings: rockchip-dw-mshc: add description for rk3399

Simon Horman (2):
      arm64: dts: salvator-x: use generic pinctrl properties
      arm64: dts: r8a7795: Use USB3.0 fallback compatibility string

Sjoerd Simons (2):
      ARM: dts: r8a7791: Don't disable referenced optional clocks
      Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins"

Stephen Warren (2):
      ARM: tegra: Fix naming in GPIO DT binding header
      ARM: tegra: Add DT binding for Tegra186 GPIO controllers

Stuart Yoder (2):
      Documentation: fsl-mc: binding updates for MSIs, ranges, PHYs
      arm64: dts: ls2080a: fsl-mc dt node updates

Sudeep Holla (1):
      arm64: tegra: Replace legacy *,wakeup property with wakeup-source

Thierry Reding (2):
      arm64: tegra: Remove 0, prefix from unit-addresses
      arm64: tegra: Fix copy/paste typo in several DTS includes

Thomas Petazzoni (6):
      arm64: dts: marvell: add UART aliases and define stdout-path
      arm64: dts: marvell: use new clock binding on Armada AP806
      arm64: dts: marvell: improve SPI flash description on Armada 7040-DB
      arm64: dts: marvell: use the proper I2C controller compatible string for 7K/8K
      arm64: dts: marvell: initial DT description of Armada 7K/8K CP110 master
      arm64: dts: marvell: enable several CP interfaces on Armada 7040-DB

Wolfram Sang (1):
      arm64: dts: salvator-x: populate EXTALR

Xing Zheng (4):
      clk: rockchip: add dt-binding header for rk3399
      clk: rockchip: add general gpu soft-reset on rk3399
      clk: rockchip: rename rga clock-id on rk3399
      clk: rockchip: export some necessary rk3399 clock ids

Xinwei Kong (2):
      arm64: dts: add all hi6220 i2c nodes
      arm64: dts: add dwmmc nodes for hi6220

Yuan Yao (4):
      Documentation: fsl: dspi: Add fsl,ls2080a-dspi compatible string
      arm64: dts: ls2080a: update the DTS for QSPI and DSPI support
      Documentation: fsl-quadspi: Add fsl,ls1043a-qspi compatible string
      arm64: dts: ls1043a: add the DTS node for QSPI support

Yunhui Cui (1):
      arm64: dts: ls1043a-rdb: add the DTS for DSPI support

Zhangfei Gao (1):
      arm64: dts: Add hi6220 usb node

Zhong Kaihua (3):
      arm64: dts: Add Hi6220 gpio configuration nodes
      arm64: dts: add Hi6220 pinctrl configuration nodes
      arm64: dts: add Hi6220 spi configuration nodes

dawei.chien at mediatek.com (1):
      arm64: dts: mt8173: Add thermal zone node.

 Documentation/devicetree/bindings/arm/amlogic.txt  |    3 +
 Documentation/devicetree/bindings/arm/fsl.txt      |    4 +
 .../bindings/arm/hisilicon/hisilicon.txt           |   20 +-
 Documentation/devicetree/bindings/arm/rockchip.txt |   10 +-
 .../bindings/gpio/nvidia,tegra186-gpio.txt         |  161 +++
 .../devicetree/bindings/gpu/nvidia,gk20a.txt       |   37 +-
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |   81 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |    1 +
 .../devicetree/bindings/mtd/fsl-quadspi.txt        |    3 +-
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |    5 +-
 Documentation/devicetree/bindings/usb/usb-xhci.txt |    1 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/boot/dts/r8a7791-koelsch.dts              |    1 +
 arch/arm/boot/dts/r8a7791-porter.dts               |   14 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |    5 +-
 arch/arm/mach-shmobile/timer.c                     |   28 +-
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/amlogic/Makefile               |    3 +
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |   69 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts    |   52 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts    |   52 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |   65 +
 .../boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts  |    2 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts   |    2 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts |    2 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |    4 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |    5 -
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         |    6 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi             |   10 +
 arch/arm64/boot/dts/broadcom/ns2-clock.dtsi        |  105 ++
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |   45 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  155 +--
 .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi   |   25 +
 .../arm64/boot/dts/exynos/exynos7-trip-points.dtsi |   54 +
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |   49 +
 arch/arm64/boot/dts/freescale/Makefile             |    3 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |  181 +++
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |   13 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   22 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  |    9 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  110 +-
 arch/arm64/boot/dts/hisilicon/Makefile             |    4 +-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |  200 ++-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  623 +++++++++
 arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi   |  705 ++++++++++
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts        |   34 +
 arch/arm64/boot/dts/hisilicon/hip05.dtsi           |   10 +
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts        |   34 +
 arch/arm64/boot/dts/hisilicon/hip06.dtsi           |  307 +++++
 arch/arm64/boot/dts/lg/Makefile                    |    5 +
 arch/arm64/boot/dts/lg/lg1312-ref.dts              |   36 +
 arch/arm64/boot/dts/lg/lg1312.dtsi                 |  351 +++++
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |   32 +-
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |    1 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   20 +-
 arch/arm64/boot/dts/marvell/armada-7020.dtsi       |    1 +
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |  108 +-
 arch/arm64/boot/dts/marvell/armada-7040.dtsi       |    1 +
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |    1 +
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |    1 +
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |    1 -
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |    2 -
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   56 +-
 .../boot/dts/marvell/armada-cp110-master.dtsi      |  228 ++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   60 +
 arch/arm64/boot/dts/nvidia/Makefile                |    1 +
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts     |   55 +-
 arch/arm64/boot/dts/nvidia/tegra132.dtsi           |  120 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |    8 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2530.dtsi     |   14 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2571.dts      |    2 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2595.dtsi     |    2 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   30 +-
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      | 1424 ++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  130 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   63 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   98 +-
 arch/arm64/boot/dts/rockchip/Makefile              |    2 +
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi       |    8 +-
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts    |  319 +++++
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |    8 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |   82 +-
 .../{rk3368-thermal.dtsi => rk3399-evb.dts}        |  124 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 1013 ++++++++++++++
 .../boot/dts/socionext/uniphier-ph1-ld20-ref.dts   |    1 +
 .../boot/dts/socionext/uniphier-ph1-ld20.dtsi      |    6 +
 .../boot/dts/socionext/uniphier-ref-daughter.dtsi  |    1 +
 include/dt-bindings/clock/rk3399-cru.h             |  755 +++++++++++
 include/dt-bindings/gpio/tegra-gpio.h              |   68 +-
 include/dt-bindings/gpio/tegra186-gpio.h           |   56 +
 include/dt-bindings/pinctrl/hisi.h                 |   59 +
 91 files changed, 8132 insertions(+), 557 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/ns2-clock.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip06-d03.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip06.dtsi
 create mode 100644 arch/arm64/boot/dts/lg/Makefile
 create mode 100644 arch/arm64/boot/dts/lg/lg1312-ref.dts
 create mode 100644 arch/arm64/boot/dts/lg/lg1312.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
 rename arch/arm64/boot/dts/rockchip/{rk3368-thermal.dtsi => rk3399-evb.dts} (55%)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi
 create mode 120000 arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi
 create mode 100644 include/dt-bindings/clock/rk3399-cru.h
 create mode 100644 include/dt-bindings/gpio/tegra186-gpio.h
 create mode 100644 include/dt-bindings/pinctrl/hisi.h
