From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2016 00:09:10 +0100
Subject: [GIT PULL 6/7] ARM: 64-bit DT updates for v4.10
In-Reply-To: <2664636.Hf0nvRznEK@wuerfel>
References: <2664636.Hf0nvRznEK@wuerfel>
Message-ID: <2325085.ePh7TGiKpK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit aec89f78cf01647d8f60713ac1a324ab1a7e2e31:

  clk: qcom: Add support for msm8994 global clock controller (2016-11-10 15:45:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt64

for you to fetch changes up to 09a566514c49b730ac5099549c014180f00be250:

  Merge tag 'amlogic-dt64-2-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic into next/dt64 (2016-11-30 23:22:10 +0100)

----------------------------------------------------------------
ARM: 64-bit DT updates for v4.10

A couple of interesting new SoC platforms are now supported, these are
the respective DTS sources:

- Samsung Exynos5433 mobile phone platform, including an (almost) fully
  supported phone reference board.
- Hisilicon Hip07 server platform and D05 board, the latest iteration
  of their product line, now with 64 Cortex-A72 cores across two
  sockets.
- Allwinner A64 SoC, the first 64-bit chip from their "sunxi" product
  line, used in Android tablets and ultra-cheap development boards
- NXP LS1046A Communication processor, improving on the earlier LS1043A
  with faster CPU cores
- Qualcomm MSM8992 (Snapdragon 808) and MSM8994 (Snapdragon 810)
  mobile phone SoCs
- Early support for the Nvidia Tegra Tegra186 SoC
- Amlogic S905D is a minor variant of their existing Android consumer
  product line
- Rockchip PX5 automotive platform, a close relative of their popular
  rk3368 Android tablet chips

Aside from the respective evaluation platforms for the above
chips, there are only a few consumer devices and boards added
this time:

- Huawei Nexus 6P (Angler) mobile phone
- LG Nexus 5x (Bullhead) mobile phone
- Nexbox A1 and A95X Android TV boxes
- Pine64 development board based on Allwinner A64
- Globalscale Marvell ESPRESSOBin community board based on Armada 3700
- Renesas "R-Car Starter Kit Pro" (M3ULCB) low-cost automotive  board

For the existing platforms, we get bug fixes and new peripheral support
for Juno, Renesas, Uniphier, Amlogic, Samsung, Broadcom, Rockchip, Berlin,
and ZTE.

Conflicts:
- Documentation/devicetree/bindings/arm/shmobile.txt: a
  rename/add conflict, keep both modifications and maintain
  alphabetical ordering.
- arch/arm64/boot/dts/*/*.dtsi: nodes were added in netdev,
  mmc and clk, keep both sides in each case.

----------------------------------------------------------------
Alim Akhtar (1):
      arm64: dts: Add ARM PMU node for exynos7

Andre Przywara (3):
      arm64: dts: add Allwinner A64 SoC .dtsi
      Documentation: devicetree: add vendor prefix for Pine64
      arm64: dts: add Pine64 support

Andrea Merello (1):
      ARM64: dts: bcm2837-rpi-3-b: remove incorrect pwr LED

Andreas F?rber (2):
      ARM64: dts: bcm2835: Fix bcm2837 compatible string
      ARM64: dts: amlogic: Reorder copyrights for meson-gx

Andy Gross (1):
      Merge tag 'qcom-arm64-for-4.10' into arm64-for-4.10-2

Andy Yan (3):
      arm64: dts: rockchip: fix i2c resource error of rk3368
      arm64: dts: rockchip: Add PX5 Evaluation board
      dt-bindings: add rockchip RK1108 Evaluation board

Archit Taneja (1):
      arm64: dts: apq8016-sbc: Set up LDO2, LDO6 and LDO17 regulator voltage ranges

Arnd Bergmann (11):
      Merge tag 'mvebu-dt64-4.10-2' of git://git.infradead.org/linux-mvebu into next/dt64
      arm64: dts: fix build errors from missing dependencies
      Merge tag 'renesas-arm64-dt2-for-v4.10' of git://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'tegra-for-4.10-arm64-dt-numeric-ids' of git://git.kernel.org/.../tegra/linux into next/dt64
      Merge tag 'arm-soc/for-4.10/devicetree-arm64' of http://github.com/Broadcom/stblinux into next/dt64
      Merge tag 'samsung-dt64-4.10-2' of git://git.kernel.org/.../krzk/linux into next/dt64
      Merge tag 'qcom-arm64-for-4.10-2' of git://git.kernel.org/.../agross/linux into next/dt64
      Merge tag 'v4.10-rockchip-dts64-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64
      Merge tag 'berlin64-dt-for-v4.10-1' of git://git.kernel.org/.../jszhang/linux-berlin into next/dt64
      Merge tag 'zte-dt64-4.10' of git://git.kernel.org/.../shawnguo/linux into next/dt64
      Merge tag 'amlogic-dt64-2-v2' of git://git.kernel.org/.../khilman/linux-amlogic into next/dt64

Bastian K?cher (1):
      arm64: dts: msm8994 SoC and Huawei Angler (Nexus 6P) support

Bjorn Andersson (3):
      arm64: dts: qcom: msm8916: Add Hexagon SMD edge
      arm64: dts: qcom: msm8916: Add Hexagon PIL node
      arm64: dts: msm8996: Add SMEM DT nodes

Brian Kim (1):
      ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes

Carlo Caione (1):
      ARM64: dts: amlogic: Add basic support for Amlogic S905X

Chanwoo Choi (3):
      arm64: dts: exynos: Add dtsi files for Samsung Exynos5433 64bit SoC
      arm64: dts: exynos: Add dts file for Exynos5433-based TM2 board
      arm64: dts: exynos: Add dts file for Exynos5433-based TM2E board

Chris Zhong (1):
      arm64: dts: rockchip: add powerdomain for typec on rk3399

Elaine Zhang (2):
      arm64: dts: rockchip: add eMMC's power domain support for rk3399
      arm64: dts: rockchip: add pd_sd power-domain node for rk3399

Eric Anholt (2):
      ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.
      Merge branch 'bcm2835-dt-next' into bcm2835-dt-64-next

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-64-next-2016-11-18' into devicetree-arm64/next

Geert Uytterhoeven (3):
      arm64: dts: r8a7796: salvator-x: Populate EXTALR
      arm64: dts: r8a7795: Add device node for PRR
      arm64: dts: r8a7796: Add device node for PRR

Gerd Hoffmann (6):
      pinctrl: bcm2835: add pull defines to dt bindings
      ARM: dts: bcm283x: add pinctrl group to &pwm, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &i2c0, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &i2c1, drop pins from &gpio
      ARM: dts: bcm283x: add pinctrl group to &sdhci, drop pins from &gpio
      ARM: dts: bcm283x: drop alt3 from &gpio

Gregory CLEMENT (3):
      arm64: dts: marvell: Fixup internal-regs DT warning for Armada 37xx
      arm64: dts: marvell: Fixup config-space DT warning For Armada 7K/8K
      ARM64: dts: marvell: Fixup memory DT warning for Armada 37xx

Hongtao Jia (2):
      arm64: dts: ls1043a: Add TMU device tree support for LS1043A
      arm64: dts: ls2080a: Add TMU device tree support for LS2080A

Jaehoon Chung (3):
      arm64: dts: rockchip: replace to "max-frequency" instead of "clock-freq-min-max"
      arm64: dts: exynos: Add the mshc_2 node for supporting T-Flash
      arm64: dts: exynos: Enable HS400 mode for eMMC for TM2

Jeffy Chen (1):
      arm64: dts: rockchip: add gmac needed pclk for rk3399 pd

Jeremy McNicoll (2):
      arm64: dts: msm8992 SoC and LG Bullhead (Nexus 5X) support
      dt-bindings: qcom: Add msm899(2/4) bindings

Jisheng Zhang (3):
      arm64: dts: berlin4ct: add missing unit name to /soc node
      arm64: dts: berlin4ct-stb: add missing unit name to /memory node
      arm64: dts: berlin4ct-dmp: add missing unit name to /memory node

John Garry (3):
      arm64: dts: hisi: fix hip06 sas am-max-trans quirk
      arm64: dts: hisi: disable sas0 and sas2 for d03
      arm64: dts: hisi: add refclk node to hip06 dts files for SAS

Jon Mason (2):
      arm64: dts: NS2: enable sdio1
      arm64: dts: NS2: Add PCI PHYs

Joseph Lo (3):
      arm64: tegra: Add Tegra186 support
      arm64: tegra: Add NVIDIA P3310 processor module support
      arm64: tegra: Add NVIDIA P2771 board support

Jun Nie (1):
      arm64: dts: zx: Add clock controller nodes

Juri Lelli (3):
      arm64: dts: juno: add cpu capacity-dmips-mhz information to R0 boards
      arm64: dts: juno: add cpu capacity-dmips-mhz information to R1 boards
      arm64: dts: juno: add cpu capacity-dmips-mhz information to R2 boards

Kamal Dasu (1):
      ARM64: dts: Add QSPI Device Tree node for NS2

Kefeng Wang (4):
      arm64: dts: hip06: Correct hardware pin number of usb node
      Documentation: arm64: Add Hisilicon Hip07 D05 dts binding
      arm64: dts: hisilicon: Add initial dts for Hip07 D05 board
      arm64: dts: hip06: Fix no reg property warning

Kevin Hilman (2):
      ARM64: dts: meson-gxbb: add MMC support
      ARM64: dts: meson-gxbb: add SCPI pre-1.0 compatible

Krzysztof Kozlowski (2):
      arm64: dts: exynos: Fix invalid GIC interrupt flags in exynos7
      arm64: dts: exynos: Use human-friendly symbols for interrupt properties in exynos7

Laurent Pinchart (3):
      arm64: dts: r8a7795: salvator-x: Add DU LVDS output endpoint
      dt-bindings: media: renesas-fcp: Remove SoC-specific compatible strings
      arm64: dts: r8a7795: Remove FCP SoC-specific compatible strings

Linus Walleij (1):
      ARM: bcm2835: Add names for the Raspberry Pi GPIO lines

Marek Szyprowski (8):
      arm64: dts: exynos: Fix IRQ type flags for Exynos5433 SoC
      arm64: dts: exynos: Fix FSYS CMU parent clocks in Exynos5433 SoC
      arm64: dts: exynos: Add missing parent clocks to audio block in Exynos5433 SoC
      arm64: dts: exynos: Move FSYS CMU configuration from Exynos5433 dtsi to TM2 dts
      arm64: dts: exynos: TM2 - remove unused UART3 and set clocks directly on CMU
      arm64: dts: exynos: TM2 - add support for GScaler devices
      arm64: dts: exynos: TM2 - add support for JPEG codec device
      arm64: dts: exynos: TM2 - add support for MFC video codec device

Martin Blumenstingl (2):
      ARM64: dts: meson-gxbb-vega-s95: Add SD/SDIO/MMC and PWM nodes
      ARM64: dts: meson-gxbb: add the USB reset also to the second USB PHY

Martin Sperl (3):
      dt: bindings: add thermal device driver for bcm2835
      ARM: bcm2835: dts: add thermal node to device-tree of bcm283x
      ARM64: bcm2835: dts: add thermal node to device-tree of bcm2837

Masahiro Yamada (5):
      arm64: dts: uniphier: switch over to PSCI enable method
      arm64: dts: uniphier: increase register region size of sysctrl node
      arm64: dts: uniphier: add CPU clock and OPP table for LD11 SoC
      arm64: dts: uniphier: add CPU clocks and OPP tables for LD20 SoC
      arm64: dts: uniphier: make compatible of syscon nodes SoC-specific

Mingkai Hu (2):
      arm64: dts: add QorIQ LS1046A SoC support
      arm64: dts: add LS1046A-RDB board support

Neil Armstrong (25):
      ARM64: dts: amlogic: Add Meson GX dtsi from GXBB
      ARM64: dts: amlogic: Add basic support for Amlogic S905D
      devicetree: Add vendor prefix for Nexbox
      ARM64: dts: meson-gxbb: Add support for the Nexbox A95X Board
      ARM64: dts: meson-gx: Add missing L2 cache node
      ARM64: dts: meson-gxbb: Add rmii pinctrl node and rename rgmii node
      ARM64: dts: meson-gxbb: Add Wifi 32K clock for p20x boards
      ARM64: dts: meson-gxbb: Add P20x Wifi SDIO support
      ARM64: dts: meson-gxbb: Add MMC nodes to Nexbox A95x
      ARM64: dts: meson-gxbb: Add SRAM node
      ARM64: dts: meson-gxbb: Add SCPI with cpufreq & sensors Nodes
      ARM64: dts: meson-gxbb: Move common nodes to meson-gx
      ARM64: dts: meson-gxl: Add pinctrl nodes
      ARM64: dts: meson-gxl: Add clock nodes
      ARM64: dts: meson-gxl: Add i2c nodes
      ARM64: dts: meson-gxl: Add MMC/SD/SDIO nodes
      ARM64: dts: meson-gxl-p23x: Add uart pinctrl
      ARM64: dts: meson-gxl-p23x: Add SD/SDIO/MMC and PWM nodes
      ARM64: dts: meson-gxl-p23x: Enable IR receiver
      ARM64: dts: meson-gxl: Add ethernet nodes with internal PHY
      ARM64: dts: meson-gxl-p23x: Enable ethernet
      ARM64: dts: meson-gxl-s905x: Enable internal ethernet PHY
      ARM64: dts: Add support for Meson GXM
      ARM64: dts: meson-gxm: Add support for the Nexbox A1
      ARM64: dts: meson-gxl: Add support for Nexbox A95X

Niklas Cassel (1):
      ARM: dts: artpec: add pcie support

Olof Johansson (14):
      Merge tag 'juno-dt-4.10' of git://git.kernel.org/.../sudeep.holla/linux into next/dt64
      Merge tag 'renesas-arm64-dt-for-v4.10' of git://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'v4.9-rc3' into next/dt64
      Merge tag 'uniphier-dt64-v4.10' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt64
      Merge tag 'samsung-dt64-4.10' of git://git.kernel.org/.../krzk/linux into next/dt64
      Merge tag 'v4.10-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64
      Merge branch 'clk-qcom-8994' of git://git.kernel.org/.../clk/linux into next/dt64
      Merge tag 'qcom-arm64-for-4.10' of git://git.kernel.org/.../agross/linux into next/dt64
      Merge tag 'imx-dt64-4.10' of git://git.kernel.org/.../shawnguo/linux into next/dt64
      Merge tag 'hisi-arm64-dt-4.10' of git://github.com/hisilicon/linux-hisi into next/dt64
      Merge tag 'sunxi-dt64-for-4.10' of https://git.kernel.org/.../mripard/linux into next/dt64
      Merge tag 'amlogic-dt64' of git://git.kernel.org/.../khilman/linux-amlogic into next/dt64
      Merge tag 'mvebu-dt64-4.10-1' of git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'samsung-dt64-gic-flags-4.10' of git://git.kernel.org/.../krzk/linux into next/dt64

Rajendra Nayak (1):
      arm64: dts: qcom: Add missing interrupt entry for pm8994 gpios

Ray Jui (1):
      arm64: dts: Updated NAND DT properties for NS2 SVK

Ritesh Harjani (2):
      ARM: dts: Add xo to sdhc clock node on qcom platforms
      arm64: dts: qcom: msm8916: Add ddr support to sdhc1

Rob Rice (1):
      arm64: dts: Add Broadcom Northstar2 device tree entries for PDC driver.

Robin Murphy (2):
      arm64: dts: juno: Add SMMUs device nodes
      arm64: dts: Update Broadcom NS2 to generic IOMMU binding

Romain Perier (1):
      arm64: dts: marvell: Add definition for the Globalscale Marvell ESPRESSOBin Board

Scott Branden (1):
      arm64: dts: rename ns2.txt to brcm,ns2.txt

Shaohui Xie (8):
      dt-bindings: fsl: Add LS1043A/LS1046A/LS2080A SoC compatible strings
      dt-bindings: fsl: add LS1043A/LS1046A/LS2080A compatible for SCFG and DCFG
      dt-bindings: i2c: adds two more nxp devices
      dt-bindings: qoriq-clock: add LS1043A/LS1046A/LS2080A compatible for clockgen
      dt-bindings: ahci-fsl-qoriq: updated for SoC ls1046a
      Documentation: DT: Add entry for QorIQ LS1046A-RDB board
      Documentation: DT: Add entry for QorIQ LS1046A-QDS board
      arm64: dts: add LS1046A-QDS board support

Shawn Lin (2):
      arm64: dts: rockchip: Add more properties for emmc on px5-evb
      arm64: dts: rockchip: add sdmmc support for px5-evb

Simon Horman (3):
      arm64: dts: r8a7796: add SDHI nodes
      arm64: dts: r8a7796: salvator-x: enable SDHI0 & 3
      arm64: dts: r8a7796: salvator-x: enable UHS for SDHI 0 & 3

Srinivas Kandagatla (2):
      dts: arm64: db820c: add pmic pins specific dts file
      arm64: dts: apq8016-sbc: add analog audio support with multicodec

Stefan Wahren (3):
      ARM64: dts: bcm283x: Use dtsi for USB host mode
      DT: binding: bcm2835-mbox: fix address typo in example
      ARM: dts: bcm283x: fix typo in mailbox address

Sylwester Nawrocki (1):
      arm64: dts: exynos: Assign parent clock of the clkout clock for TM2 board

Thierry Reding (6):
      arm64: tegra: Add CPU nodes for Tegra186
      arm64: tegra: Add serial ports on Tegra186
      arm64: tegra: Add I2C controllers on Tegra186
      arm64: tegra: Add SDHCI controllers on Tegra186
      arm64: tegra: Add GPIO controllers on Tegra186
      arm64: tegra: Enable PSCI on P3310

Ulrich Hecht (4):
      arm64: renesas: r8a7796: add SYS-DMAC controller nodes
      arm64: dts: r8a7796: add I2C support
      arm64: dts: r8a7796: Enable I2C DMA
      arm64: dts: r8a7796: salvator-x: enable I2C

Vladimir Barinov (13):
      arm64: dts: h3ulcb: update documentation with official board name
      arm64: dts: h3ulcb: update header
      arm64: dts: m3ulcb: add M3ULCB board DT bindings
      arm64: dts: m3ulcb: initial device tree
      arm64: dts: m3ulcb: enable SCIF clk and pins
      arm64: dts: m3ulcb: enable GPIO leds
      arm64: dts: m3ulcb: enable GPIO keys
      arm64: dts: m3ulcb: enable EXTALR clk
      arm64: dts: m3ulcb: enable WDT
      arm64: dts: m3ulcb: enable SDHI0
      arm64: dts: m3ulcb: enable SDHI2
      arm64: dts: h3ulcb: enable SDHI2
      arm64: dts: h3ulcb: rename SDHI0 pins

William Wu (1):
      arm64: dts: rockchip: add usb2-phy otg-port support for rk3399

Wolfram Sang (3):
      arm64: dts: r8a7795: salvator-x: enable UHS for SDHI 0 & 3
      arm64: dts: r8a7795: salvator: enable on-board eMMC
      arm64: dts: r8a7796: salvator: enable on board eMMC

Yakir Yang (1):
      arm64: dts: rockchip: add backlight support for rk3399 evb board

Yoshihiro Shimoda (1):
      arm64: dts: r8a7795: salvator-x: add bias setting for usb1_pins

Ziyuan Xu (1):
      arm64: dts: rockchip: add cpu-id nvmem cell node for rk3399

spjoshi at codeaurora.org (3):
      arm64: dts: msm8996: Add SMEM reserve-memory node
      arm64: dts: msm8996: Add reserve-memory nodes
      arm64: dts: msm8996: Add SMP2P and APCS nodes


 Documentation/devicetree/bindings/arm/amlogic.txt  |   19 +
 .../bindings/arm/bcm/{ns2.txt => brcm,ns2.txt}     |    0
 Documentation/devicetree/bindings/arm/fsl.txt      |   34 +-
 .../bindings/arm/hisilicon/hisilicon.txt           |    4 +
 Documentation/devicetree/bindings/arm/qcom.txt     |    2 +
 Documentation/devicetree/bindings/arm/rockchip.txt |   12 +
 .../bindings/arm/samsung/samsung-boards.txt        |    2 +
 Documentation/devicetree/bindings/arm/shmobile.txt |    4 +-
 Documentation/devicetree/bindings/arm/sunxi.txt    |    1 +
 .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    2 +-
 .../devicetree/bindings/clock/qoriq-clock.txt      |    3 +
 .../devicetree/bindings/i2c/trivial-devices.txt    |    2 +
 .../devicetree/bindings/media/renesas,fcp.txt      |    8 +-
 .../devicetree/bindings/vendor-prefixes.txt        |    2 +
 MAINTAINERS                                        |    1 +
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/allwinner/Makefile             |    5 +
 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  |   50 +
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |   74 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  261 ++++
 arch/arm64/boot/dts/amlogic/Makefile               |    8 +
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  190 +++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |  360 +++++
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  231 ++++
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  119 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |  129 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  106 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  901 +++++-------
 .../boot/dts/amlogic/meson-gxl-nexbox-a95x.dts     |  205 +++
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts      |   77 ++
 .../boot/dts/amlogic/meson-gxl-s905d-p231.dts      |   58 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi   |   48 +
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      |   69 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi   |   54 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |  301 ++++
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  169 +++
 .../arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts |   77 ++
 .../arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts |   58 +
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |  114 ++
 arch/arm64/boot/dts/arm/juno-base.dtsi             |   80 ++
 arch/arm64/boot/dts/arm/juno-r1.dts                |    6 +
 arch/arm64/boot/dts/arm/juno-r2.dts                |    6 +
 arch/arm64/boot/dts/arm/juno.dts                   |    6 +
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   |    8 +-
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi          |    8 +-
 .../boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi    |    1 +
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |   38 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |   62 +-
 arch/arm64/boot/dts/exynos/Makefile                |    5 +-
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  804 +++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1049 ++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |   41 +
 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi |   23 +
 .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     |   22 +
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     |  296 ++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 1462 ++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    |   20 +-
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |   87 +-
 arch/arm64/boot/dts/freescale/Makefile             |    2 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   78 ++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  |  212 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  |  150 ++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  515 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts  |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  116 +-
 arch/arm64/boot/dts/hisilicon/Makefile             |    1 +
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts        |    8 -
 arch/arm64/boot/dts/hisilicon/hip06.dtsi           |   23 +-
 arch/arm64/boot/dts/hisilicon/hip07-d05.dts        |   66 +
 arch/arm64/boot/dts/hisilicon/hip07.dtsi           | 1059 ++++++++++++++
 arch/arm64/boot/dts/marvell/Makefile               |    1 +
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |    2 +-
 .../boot/dts/marvell/armada-3720-espressobin.dts   |   82 ++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |    2 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |    2 +-
 .../boot/dts/marvell/armada-cp110-master.dtsi      |    2 +-
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |    2 +-
 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts      |    2 +-
 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts      |    2 +-
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi         |    2 +-
 arch/arm64/boot/dts/nvidia/Makefile                |    1 +
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |    8 +
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |   64 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  398 ++++++
 arch/arm64/boot/dts/qcom/Makefile                  |    7 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |   73 +-
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    |   15 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |    2 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   73 +-
 .../boot/dts/qcom/msm8992-bullhead-rev-101.dts     |   41 +
 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi         |   38 +
 arch/arm64/boot/dts/qcom/msm8992.dtsi              |  184 +++
 .../arm64/boot/dts/qcom/msm8994-angler-rev-101.dts |   40 +
 arch/arm64/boot/dts/qcom/msm8994-pins.dtsi         |   38 +
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |  216 +++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   91 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi               |   45 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi               |    1 +
 arch/arm64/boot/dts/renesas/Makefile               |    2 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |   53 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   85 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   29 +-
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts     |  189 +++
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  160 +++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  255 ++++
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    |    2 +-
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts    |  314 +++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |   18 +-
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        |   40 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   55 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |   59 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |  111 +-
 arch/arm64/boot/dts/zte/zx296718.dtsi              |   24 +
 118 files changed, 12147 insertions(+), 709 deletions(-)
