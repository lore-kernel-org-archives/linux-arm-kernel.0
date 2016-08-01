From: olof@lixom.net (Olof Johansson)
Date: Mon,  1 Aug 2016 14:39:28 -0700
Subject: [GIT PULL 7/7] ARM: 64-bit DT updates for v4.8
In-Reply-To: <1470087568-4222-1-git-send-email-olof@lixom.net>
References: <1470087568-4222-1-git-send-email-olof@lixom.net>
Message-ID: <1470087568-4222-8-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just as the 32-bit contents, the 64-bit device tree branch also contains
a number of additions this release cycle.

New platforms:
- LG LG1313
- Mediatek MT6755
- Renesas r8a7796
- Broadcom 2837

Other platforms with larger updates are:
- Nvidia X1 platforms (USB 3.0, regulators, display subsystem)
- Mediatek MT8173 (display subsystem added)
- Rockchip RK3399 (a lot of new peripherals)
- ARM Juno reference implementation (SCPI power domains, coresight, thermal)



Conflicts:

arch/arm64/boot/dts/apm/apm-shadowcat.dtsi:
Conflict between change of one register window and 0X->0x cleanup. Keep the
0x side but reduce the window (0x10000 -> 0xd100).

arch/arm64/boot/dts/broadcom/ns2-svk.dts:
Add/add conflict. Keep both sides and fixup closing braces to match.

arch/arm64/boot/dts/broadcom/ns2.dtsi:
Add/add conflict. Keep both sides and fixup braces to match. Sort by @<reg>
address, so cci above the mdio-mux node.

----------------------------------------------------------------

The following changes since commit e16a40d3468d05ee6a9516503dca513e5126261d:

  Merge branch 'next/dt' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt64

for you to fetch changes up to 943283ee6b40b74a9d30ced8f23e90119e21dbb3:

  Merge tag 'tegra-for-4.8-arm64-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into next/late

----------------------------------------------------------------

Abhilash Kesavan (1):
      arm64: dts: exynos: Modify the voltage range for BUCK2 for exynos7

Alison Wang (1):
      arm64: dts: fsl: Update address-cells and reg properties of cpu nodes

Andy Gross (1):
      arm64: dts: msm8916: Add SCM firmware node

Anup Patel (2):
      dt-bindings: ata: add compatible string for iProc AHCI controller
      arm64: dts: Add SATA3 AHCI and SATA3 PHY DT nodes for NS2

Arnd Bergmann (13):
      Merge tag 'v4.7-next-dts' of https://github.com/mbgg/linux-mediatek into next/dt64
      Merge tag 'mvebu-dt64-4.8-1' of git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'amlogic-dt64-2' of git://git.kernel.org/.../khilman/linux-amlogic into next/dt64
      Merge tag 'arm-soc/for-4.8/devicetree-arm64-part2' of http://github.com/Broadcom/stblinux into next/dt64
      Revert "ARM64: DTS: meson-gxbb: switch ethernet to real clock"
      Merge tag 'renesas-arm64-dt2-for-v4.8' of git://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'juno-dt-4.8' of git://git.kernel.org/.../sudeep.holla/linux into next/dt64
      Merge tag 'samsung-dt64-4.8-2' of git://git.kernel.org/.../krzk/linux into next/dt64
      Merge branch 'reset/for-4.8-2' into next/dt64
      Merge branch 'renesas/rcar-sysc' into next/dt64
      Merge Tegra clk changes into next/dt64
      Merge tag 'hi6220-dt-for-4.8-2' of git://github.com/hisilicon/linux-hisi into next/late
      Merge tag 'tegra-for-4.8-arm64-dt' of git://git.kernel.org/.../tegra/linux into next/late

Bjorn Andersson (1):
      ARM: dts: msm8916: Update reserved-memory

Bjorn Helgaas (2):
      arm64: dts: apm: Use lowercase consistently for hex constants
      arm64: dts: apm: Remove leading '0x' from unit addresses

Brian Norris (3):
      arm64: dts: rockchip: make rk3399's grf a "simple-mfd"
      arm64: dts: rockchip: add sdhci/emmc for rk3399
      arm64: dts: rockchip: enable eMMC for rk3399 EVB

CK Hu (1):
      arm64: dts: mt8173: Add display subsystem related nodes

Caesar Wang (2):
      arm64: dts: rockchip: add thermal nodes for rk3399 SoCs
      arm64: dts: rockchip: fixes the gic400 2nd region size for rk3368

Carlo Caione (3):
      ARM64: dts: amlogic: Add hiu and periphs buses
      documentation: Add compatibles for Amlogic Meson GXBB pin controllers
      ARM64: dts: amlogic: Enable pin controller on GXBB-based platforms

Chanho Min (1):
      arm64: dts: Add dts files for LG Electronics's lg1313 SoC

David Wu (1):
      arm64: dts: rockchip: add i2c nodes for rk3399

Douglas Anderson (3):
      arm64: dts: rockchip: Add soc-ctl-syscon to sdhci for rk3399
      arm64: dts: rockchip: Provide emmcclk to PHY for rk3399
      arm64: dts: rockchip: add ap_pwroff and ddrio_pwroff pins for rk3399

Duc Dang (2):
      arm64: dts: apm: Fix timer interrupt polarity for X-Gene 2 SoC
      arm64: dts: apm: Remove unused qmlclk node on X-Gene 1

Eric Anholt (3):
      dt-bindings: Add root properties for Raspberry Pi 3
      ARM: bcm2835: Add devicetree for the Raspberry Pi 3.
      Merge tag 'bcm2835-dt-ethernet' into HEAD

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-64-next-2016-07-03' into devicetree-arm64/next

Geert Uytterhoeven (9):
      arm64: dts: salvator-x: SCIF1 supports RTS/CTS hardware flow control
      arm64: dts: r8a7795: Use SYSC "always-on" PM Domain for RWDT node
      arm64: dts: r8a7795: Fix W=1 dtc warnings
      arm64: dts: salvator-x: Fix W=1 dtc warnings
      arm64: dts: r8a7795: Add missing blank lines between cpu nodes
      arm64: dts: r8a7796: Add SYSC PM Domains
      arm64: dts: r8a7796: Use SYSC "always-on" PM Domain
      arm64: dts: r8a7796: Add RWDT node
      arm64: dts: r8a7796/salvator-x: Enable watchdog timer

Georgi Djakov (1):
      arm64: dts: apq8016-sbc: Add DT node for the uSD SDHC interface

Gerd Hoffmann (1):
      ARM: bcm2837: dt: Add the ethernet to the device trees

Gregory CLEMENT (3):
      arm64: dts: marvell: Add xtal clock support for Armada 3700
      arm64: dts: marvell: add tbg clocks for Armada 37xx
      arm64: dts: marvell: add peripherals clocks for Armada 37xx

Heiko Stuebner (4):
      arm64: dts: rockchip: make rk3368 grf syscons simple-mfds
      arm64: dts: rockchip: add rk3368 io-domain core nodes
      arm64: dts: rockchip: add rk3368-r88 iodomains
      arm64: dts: rockchip: add rk3399 io-domain core nodes

Javi Merino (1):
      arm64: dts: juno: add thermal zones for scpi sensors

Jon Hunter (5):
      arm64: tegra: Correct Tegra210 XUSB mailbox interrupt
      arm64: tegra: Add audio powergate node for Tegra210
      arm64: tegra: Add ACONNECT bus node for Tegra210
      arm64: tegra: Add DPAUX pinctrl bindings
      arm64: tegra: Add XUSB powergates on Tegra210

Jon Mason (2):
      arm64: dts: NS2: Add all of the UARTs
      arm64: dts: NS2: Add CCI-400 PMU support

Kevin Hilman (4):
      ARM64: dts: amlogic: add pins for EMMC, SD
      ARM64: dts: amlogic: gxbb: pinctrl: add/update UART
      ARM64: dts: amlogic: gxbb: add ethernet
      ARM64: DTS: meson-gxbb: switch ethernet to real clock

Li Yang (2):
      arm64: dts: ls1043a: Add cache nodes for cacheinfo support
      arm64: dts: ls2080a: Add cache nodes for cacheinfo support

Lina Iyer (1):
      ARM64: dts: Add PSCI cpuidle support for MSM8916

Linus Walleij (1):
      arm64: dts: hikey: name the GPIO lines

Liu Gang (2):
      bindings: PCI: layerscape: Add 'dma-coherent' property
      arm64: dts: ls1043a: Add 'dma-coherent' for ls1043a PCI nodes

Mars Cheng (2):
      Document: DT: Add bindings for mediatek MT6755 SoC Platform
      arm64: dts: mediatek: add mt6755 support

Masahiro Yamada (3):
      arm64: dts: uniphier: add SoC-Glue node to UniPhier 64bit SoCs
      arm64: dts: uniphier: change cpu-release-address
      arm64: dts: uniphier: add /memreserve/ for spin-table release address

Michael Turquette (1):
      arm64: dts: gxbb clock controller

Neil Armstrong (3):
      ARM64: dts: amlogic: Enable Reset Controller on GXBB-based platforms
      dt-bindings: hwrng: Add Amlogic Meson Hardware Random Generator bindings
      ARM64: dts: meson-gxbb: Add Hardware Random Generator node

Niklas S?derlund (1):
      arm64: dts: r8a7795: enable DMA for I2C

Olof Johansson (8):
      Merge tag 'renesas-arm64-dt-for-v4.8' of git://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'amlogic-dt64' of git://git.kernel.org/.../khilman/linux-amlogic into next/dt64
      Merge tag 'arm-soc/for-4.8/devicetree-arm64' of http://github.com/Broadcom/stblinux into next/dt64
      Merge tag 'xgene-dts-for-v4.8-part1' of https://github.com/AppliedMicro/xgene-next into next/dt64
      Merge tag 'qcom-arm64-for-4.8' of git://git.kernel.org/.../agross/linux into next/dt64
      Merge tag 'imx-dt64-4.8' of git://git.kernel.org/.../shawnguo/linux into next/dt64
      Merge tag 'hi6220-dt-for-4.8' of git://github.com/hisilicon/linux-hisi into next/dt64
      Merge tag 'v4.8-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64

Pooya Keshavarzi (1):
      arm64: dts: r8a7795: Increase the size of GIC-400 mapped registers

Rajesh Bhagat (2):
      arm64: dts: ls2080a: Add dis_rxdet_inp3_quirk property to USB3 node
      arm64: dts: ls1043a: Add dis_rxdet_inp3_quirk property to USB3 node

Ramesh Shanmugasundaram (1):
      arm64: dts: r8a7795: Add CAN FD support

Rhyland Klein (1):
      arm64: tegra: Add regulators for Tegra210 Smaug

Simon Horman (3):
      arm64: dts: r8a7795: Drop 0x from unit address of gic
      Merge tag 'clk-renesas-for-v4.8-tag2' into HEAD
      arm64: dts: r8a7796: Add Renesas R8A7796 SoC support

Srinivas Kandagatla (17):
      arm64: dts: qcom: apq8016-sbc: enable bam dma node.
      arm64: dts: msm8996: add msmgpio label
      arm64: dts: msm8996: add blsp2_uart1 pinctrl
      arm64: dts: msm8996: add blsp2_uart2 pinctrl nodes.
      arm64: dts: msm8996: add support blsp2_uart2
      arm64: dts: msm8996: add blsp1_i2c2 pinctrl nodes.
      arm64: dts: msm8996: add support to blsp1_i2c2 device
      arm64: dts: msm8996: add blsp2_i2c1 pinctrl
      arm64: dts: msm8996: add support to blsp2_i2c1
      arm64: dts: msm8996: add support to blsp2_i2c0 pinctrl
      arm64: dts: msm8996: add support to blsp2_i2c0
      arm64: dts: msm8996: add support to blsp1_spi0 pinctrl
      arm64: dts: msm8996: add support to blsp1_spi0
      arm64: dts: msm8996: add support to blsp2_spi5 pinctrl
      arm64: dts: msm8996: add support to blsp2_spi5
      arm64: dts: msm8996: add sdc2 pinctrl
      arm64: dts: msm8996: add sdc2 support

Stephen Boyd (1):
      arm64: dts: qcom: Add msm8916 PMU node

Sudeep Holla (2):
      arm64: dts: juno: add coresight support
      arm64: dts: juno: add SCPI power domains for device power management

Takeshi Kihara (1):
      arm64: dts: salvator-x: add Salvator-X board on R8A7796 SoC

Thierry Reding (9):
      arm64: tegra: Add PMIC support on Jetson TX1
      arm64: tegra: p2597: Add SDMMC power supplies
      arm64: tegra: Add DSI panel on Jetson TX1
      arm64: tegra: Add Tegra210 XUSB pad controller
      arm64: tegra: Add Tegra210 XUSB controller
      arm64: tegra: Enable debug serial on Jetson TX1
      arm64: tegra: Enable XUSB controller on Jetson TX1
      arm64: tegra: Add sor1_src clock
      arm64: tegra: Enable HDMI on Jetson TX1

Thomas Petazzoni (2):
      arm64: dts: marvell: adjust to the latest mv-xor-v2 DT binding
      arm64: dts: marvell: add XOR engine description for Armada 7K/8K CP

Wolfram Sang (2):
      arm64: dts: r8a7795: Add RWDT node
      arm64: dts: salvator-x: Enable watchdog timer

Xing Zheng (1):
      arm64: dts: rockchip: assign default rates for core rk3399 clocks

Yendapally Reddy Dhananjaya Reddy (2):
      arm64: dts: enable pinctrl for Broadcom NS2 SoC
      arm64: dts: Enable GPIO for Broadcom NS2 SoC

Zhangfei Gao (1):
      arm64: dts: hi6220: Add pl031 RTC support


 .../bindings/arm/bcm/brcm,bcm2835.txt           |   4 +
 .../devicetree/bindings/arm/mediatek.txt        |   4 +
 .../devicetree/bindings/arm/shmobile.txt        |   4 +
 .../devicetree/bindings/ata/ahci-platform.txt   |   1 +
 .../interrupt-controller/mediatek,sysirq.txt    |   1 +
 .../devicetree/bindings/net/apm-xgene-enet.txt  |   4 +-
 .../devicetree/bindings/pci/layerscape-pci.txt  |   4 +
 .../bindings/pinctrl/meson,pinctrl.txt          |   2 +
 .../bindings/rng/amlogic,meson-rng.txt          |  14 +
 .../devicetree/bindings/serial/mtk-uart.txt     |   1 +
 arch/arm64/Kconfig.platforms                    |   6 +
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts    |  20 ++
 .../arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi |   9 +
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi   |   3 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi     | 170 ++++++++-
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi      |  68 ++--
 arch/arm64/boot/dts/apm/apm-storm.dtsi          |  44 +--
 arch/arm64/boot/dts/arm/juno-base.dtsi          | 357 +++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r1.dts             |  40 +++
 arch/arm64/boot/dts/arm/juno-r2.dts             |  40 +++
 arch/arm64/boot/dts/arm/juno.dts                |  24 ++
 arch/arm64/boot/dts/broadcom/Makefile           |   1 +
 .../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts |  30 ++
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi       |  76 ++++
 arch/arm64/boot/dts/broadcom/ns2-svk.dts        |  37 ++
 arch/arm64/boot/dts/broadcom/ns2.dtsi           | 119 +++++++
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi  |  24 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi  |  44 ++-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts  | 143 ++++++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi       |  16 +
 arch/arm64/boot/dts/lg/Makefile                 |   1 +
 arch/arm64/boot/dts/lg/lg1313-ref.dts           |  36 ++
 arch/arm64/boot/dts/lg/lg1313.dtsi              | 351 ++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi    |  35 ++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi   |   8 +-
 .../boot/dts/marvell/armada-cp110-master.dtsi   |  18 +
 arch/arm64/boot/dts/mediatek/Makefile           |   1 +
 arch/arm64/boot/dts/mediatek/mt6755-evb.dts     |  38 ++
 arch/arm64/boot/dts/mediatek/mt6755.dtsi        | 145 ++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        | 223 ++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi  | 249 +++++++++++++
 .../boot/dts/nvidia/tegra210-p2371-2180.dts     |  45 +++
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi  | 319 +++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts   | 314 ++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi        | 292 ++++++++++++++-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi       |  16 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi           |  78 +++-
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi      | 303 ++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi           | 103 +++++-
 arch/arm64/boot/dts/renesas/Makefile            |   1 +
 .../boot/dts/renesas/r8a7795-salvator-x.dts     |  14 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi        | 124 +++++--
 .../boot/dts/renesas/r8a7796-salvator-x.dts     |  50 +++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi        | 138 +++++++
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts     |  16 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi        |  16 +-
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts     |  12 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi        | 313 +++++++++++++++-
 .../boot/dts/socionext/uniphier-ph1-ld20.dtsi   |  20 +-
 60 files changed, 4450 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/amlogic,meson-rng.txt
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837.dtsi
 create mode 100644 arch/arm64/boot/dts/lg/lg1313-ref.dts
 create mode 100644 arch/arm64/boot/dts/lg/lg1313.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6755-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6755.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7796.dtsi
