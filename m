From: olof@lixom.net (Olof Johansson)
Date: Mon,  8 May 2017 23:52:53 -0700
Subject: [GIT PULL 7/7] ARM: 64-bit DT updates
In-Reply-To: <1494312773-9790-1-git-send-email-olof@lixom.net>
References: <1494312773-9790-1-git-send-email-olof@lixom.net>
Message-ID: <1494312773-9790-8-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device-tree updates for arm64 platforms. Just as with 32-bit, a bunch of smaller
changes, but also some new platforms that are worth mentioning:

* Rockchip RK3399 platforms for Chromebooks, including Samsung Chromebook
Plus (Kevin)
* Orange Pi PC2 (Allwinner H5)
* Freescale LS2088A and LS1088A SoCs
* Expanded support for Nvidia Tegra186 (and Jetson TX2)

Conflicts:

arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi:
Add/add. Keep both hwrng and hdmi_tx nodes.

----------------------------------------------------------------

The following changes since commit 9f955a4249a816047b5f8074cb33d9af38278ec6:

  Merge tag 'armsoc-arm64' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt64

for you to fetch changes up to 3c0e3abd5ee59acbcbd5d8fc624eaf63f6e7b53c:

  arm64: dts: Add basic DT to support Spreadtrum's SP9860G

----------------------------------------------------------------

Abhimanyu Saini (3):
      dt-bindings: Add compatible for LS2088A QDS and RDB board
      arm64: dts: freescale: ls2080a: Split devicetree for code resuability
      arm64: dts: freescale: ls2088a: Add DTS support for FSL's LS2088A SoC

Alexandre Courbot (1):
      arm64: tegra: Add GPU node for Tegra186

Andi Shyti (2):
      arm64: dts: exynos: Enable ir-spi in the TM2 and TM2E boards
      arm64: dts: exynos: Add stmfts touchscreen node for TM2 and TM2E

Andre Przywara (2):
      arm64: allwinner: h5: add Allwinner H5 .dtsi
      arm64: allwinner: h5: add support for the Orange Pi PC 2 board

Andy Yan (1):
      arm64: dts: rockchip: fix the memory size of PX5 Evaluation board

Antoine Tenart (3):
      arm64: marvell: dts: add crypto engine description for 7k/8k
      arm64: marvell: dts: enable the crypto engine on the Armada 7040 DB
      arm64: marvell: dts: enable the crypto engine on the Armada 8040 DB

Arnd Bergmann (7):
      Merge tag 'uniphier-dt64-v4.12' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt64
      Merge tag 'mvebu-dt64-4.12-1' of git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'arm-soc/for-4.12/devicetree-arm64' of http://github.com/Broadcom/stblinux into next/dt64
      Merge tag 'v4.12-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64
      Merge tag 'v4.12-rockchip-dts64-symlinks-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64
      Merge tag 'juno-fixes-4.12' of git://git.kernel.org/.../sudeep.holla/linux into next/dt64
      Merge tag 'samsung-dt64-4.12-3' of git://git.kernel.org/.../krzk/linux into next/dt64

Bjorn Andersson (4):
      arm64: dts: qcom: msm8996: Fixup smp2p node
      arm64: dts: qcom: msm8916: Update hexagon node
      arm64: dts: apq8016-sbc: Add ramoops
      arm64: dts: qcom: pm8994: Add rtc node

Brian Norris (6):
      arm64: dts: rockchip: sort rk3399-pcie by unit address
      arm64: dts: rockchip: support dwc3 USB for rk3399
      dt-bindings: Document rk3399 Gru/Kevin
      arm64: dts: rockchip: add Gru/Kevin DTS
      arm64: dts: rockchip: describe Gru/Kevin OPPs + CPU regulators
      arm64: dts: rockchip: add regulator info for Kevin digitizer

Carlo Caione (3):
      dt-bindings: Add vendor prefix for Hwacom Systems Inc.
      dt-bindings: amlogic: Add HwaCom board
      ARM64: dts: meson-gxl: Add support for HwaCom AmazeTV

Daniel Lezcano (1):
      arm64: dts: hi6220: Reset the mmc hosts

Dien Pham (2):
      arm64: dts: r8a7796: Add I2C for DVFS device node
      arm64: dts: r8a7796: salvator-x: Add I2C for DVFS device support

Geert Uytterhoeven (14):
      arm64: dts: r8a7795: Add Cortex-A53 CPU cores
      arm64: dts: r8a7795: Add Cortex-A53 PMU node
      arm64: dts: r8a7795: Remove unit-addresses and regs from integrated caches
      arm64: dts: r8a7796: Remove unit-address and reg from integrated cache
      arm64: dts: r8a7796: Add CA53 L2 cache-controller node
      arm64: dts: r8a7796: Add Cortex-A53 CPU cores
      arm64: dts: r8a7796: Add Cortex-A53 PMU node
      arm64: dts: h3ulcb: Drop superfluous status update for frequency override
      arm64: dts: r8a7795: salvator-x: Drop superfluous status updates for frequency overrides
      arm64: dts: m3ulcb: Drop superfluous status update for frequency override
      arm64: dts: r8a7796: salvator-x: Drop superfluous status update for frequency override
      arm64: dts: r8a7795: Add reset control properties
      arm64: dts: r8a7796: Add reset control properties
      arm64: dts: r8a7795: salvator-x: Drop _clk suffix from X12 clock node name

Gregory CLEMENT (9):
      arm64: dts: marvell: add RTC description for Armada 7K/8K
      ARM64: dts: marvell: armada37xx: add address and size property for i2c cells
      ARM64: dts: marvell: armada-3720-db: add gpio expander
      ARM64: dts: marvell: armada-37xx: Fix interrupt mapping for USB3
      ARM64: dts: marvell: armada-37xx: Add clock resource for USB3
      ARM64: dts: marvell: armada-3720-db: Add phy for USB3
      ARM64: dts: marvell: armada-3720 add RTC support
      arm64: dts: marvell: add eMMC support for Armada 37xx
      arm64: dts: marvell: add sdhci support for Armada 7K/8K

Harninder Rai (3):
      arm64: dts: Add support for FSL's LS1088A SoC
      dt-bindings: clockgen: Add compatible string for LS1088A
      dt-bindings: arm: Add entry for FSL LS1088A RDB, QDS boards

Heiko Stuebner (3):
      arm64: dts: rockchip: remove wrongly added idle states on rk3368
      arm64: dts: rockchip: add rk3368 dw-mmc resets
      arm64: dts: rockchip: add rk3399 dw-mmc resets

Heiner Kallweit (1):
      ARM64: dts: meson-gxbb-odroidc2: Enable SARADC node

Hoegeun Kwon (2):
      arm64: dts: exynos: Add the burst and esc clock frequency properties to DSI node
      arm64: dts: exynos: Add support for s6e3hf2 panel device on TM2e board

Horia Geant? (1):
      arm64: dts: ls1012a: add crypto node

Huibin Hong (1):
      arm64: dts: rockchip: add dmac nodes for rk3368 SoCs

Hyungwon Hwang (1):
      arm64: dts: exynos: Add support for S6E3HA2 panel device on TM2 board

Icenowy Zheng (4):
      arm64: allwinner: h5: enable USB OTG on Orange Pi PC 2 board
      arm64: allwinner: a64: add r_ccu node
      arm64: allwinner: a64: add R_PIO pinctrl node
      ARM: sunxi: h3/h5: switch apb0-related clocks to r_ccu

Jayachandran C (2):
      dt-bindings: Add arm64 ARCH_THUNDER2 platform documentation
      arm64: dts: move from ARCH_VULCAN to ARCH_THUNDER2

Jerome Brunet (1):
      dt-bindings: clk: gxbb: expose i2s output clock gates

Jiancheng Xue (2):
      dt-bindings: arm: hisilicon: add bindings for hi3798cv200 SoC and Poplar board
      arm64: dts: hisilicon: add dts files for hi3798cv200-poplar board

Jianqun Xu (2):
      arm64: dts: rockchip: add i2s nodes support for RK3368 SoCs
      arm64: dts: rockchip: disable mailbox of RK3368 SoCs per default

Jon Hunter (1):
      arm64: tegra: Update the Tegra132 flowctrl compatible string

Jon Mason (1):
      arm64: dts: NS2: convert "ok" to "okay"

Jun Nie (1):
      arm64: dts: zte: add mmc devices for zx296718

Kazuya Mizuguchi (4):
      arm64: dts: r8a7795: Use rgmii-txid phy-mode for EthernetAVB
      arm64: dts: r8a7795: salvator-x: Fix EthernetAVB PHY timing
      arm64: dts: r8a7796: Use rgmii-txid phy-mode for EthernetAVB
      arm64: dts: r8a7796: salvator-x: Fix EthernetAVB PHY timing

Keita Kobayashi (2):
      arm64: dts: r8a7795: Add I2C for DVFS core to dtsi
      arm64: dts: r8a7795: salvator-x: Enable I2C for DVFS device

Kevin Hilman (1):
      Merge tag 'amlogic-clk-headers' into v4.12/dt64

Khiem Nguyen (2):
      arm64: dts: r8a7795: Upgrade to PSCI v1.0 to support Suspend-to-RAM
      arm64: dts: r8a7796: Upgrade to PSCI v1.0 to support Suspend-to-RAM

Kuninori Morimoto (1):
      arm64: dts: r8a7795: Tidyup Audio-DMAC channel for DVC

Liang Chen (4):
      dt-bindings: add binding for rk3328-grf
      arm64: dts: rockchip: add core dtsi file for RK3328 SoCs
      dt-bindings: document rockchip rk3328-evb board
      arm64: dts: rockchip: add RK3328 eavluation board devicetree

Magnus Damm (1):
      arm64: dts: r8a7795: Correct SATA device size to 2MiB

Martin Blumenstingl (14):
      ARM64: dts: meson-gxbb-odroidc2: add the ethernet PHY's reset GPIO
      ARM64: dts: meson-gxbb-p200: add the ethernet PHY's reset GPIO
      ARM64: dts: meson-gxbb-vega-s95: add the ethernet PHY's reset GPIO
      ARM64: dts: meson-gxbb-nexbox-a95x: add the ethernet PHY's reset GPIO
      ARM64: dts: meson-gxbb-wetek-hub: add the ethernet PHY's reset GPIO
      ARM64: dts: meson-gxbb-wetek-play2: add the ethernet PHY's reset GPIO
      ARM64: dts: meson-gxbb-p201: fix ethernet support
      ARM64: dts: amlogic: add the ethernet TX delay configuration
      ARM64: dts: meson-gx: remove the phy-mode property from meson-gx
      ARM64: dts: meson-gxl: improve support for the P212 reference design
      ARM64: dts: amlogic: meson-gxl: add the missing PWM pins
      devicetree: add vendor prefix for Khadas
      dt-bindings: amlogic: add the Khadas VIM
      ARM64: dts: meson-gxl: add support for the Khadas VIM board

Masahiro Yamada (4):
      arm64: dts: uniphier: fix no unit name warnings
      arm64: dts: uniphier: move memory node below aliases node
      arm64: dts: uniphier: add pinctrl property to eMMC node for LD11/LD20
      arm64: dts: uniphier: re-order reset deassertion of USB of LD11

Mikko Perttunen (2):
      arm64: tegra: Enable VIC on Tegra210
      arm64: tegra: Enable IOMMU for host1x on Tegra210

Neil Armstrong (18):
      ARM64: dts: meson-gx: Add Buttons to Q200 and P230 boards
      ARM64: dts: meson-gxbb-odroidc2: Add GPIO lines names
      ARM64: dts: meson-gxbb-odroidc2: Fix TFLASH VDD regulator GPIO line
      ARM64: dts: meson-gx: Finally move common nodes to GX dtsi
      ARM64: dts: meson-gx: empty line cleanup
      ARM64: dts: meson-gx: Prepend GX generic compatible like other nodes
      ARM64: dts: meson-gxl: Add missing pinctrl pins groups
      ARM64: dts: meson-gx: Add Mali nodes for GXBB and GXL
      ARM64: dts: meson-gxbb: Add gpio-ranges properties
      ARM64: dts: meson-gxl: Add gpio-ranges properties
      ARM: dts: meson8: Add gpio-ranges properties
      ARM: dts: meson8b: Add gpio-ranges properties
      ARM64: dts: meson-gxbb: Add USB Hub GPIO hog
      clk: meson-gxbb: Add MALI clock IDS
      clk: meson-gxbb: Expose GP0 dt-bindings clock id
      dt-bindings: clock: gxbb-clkc: Add GXL compatible variant
      ARM64: dts: meson-gx: Add shared CMA dma memory pool
      ARM64: dts: meson-gx: Add support for HDMI output

Niklas S?derlund (1):
      arm64: dts: r8a7795: salvator-x: Set drive-strength for ravb pins

Olof Johansson (14):
      Merge branch 'shared/dt-symlinks' into next/dt64
      Merge tag 'renesas-arm64-dt-for-v4.12' of https://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'amlogic-dt64-redo' of git://git.kernel.org/.../khilman/linux-amlogic into next/dt64
      Merge tag 'sunxi-dt64-for-4.12' of https://git.kernel.org/.../sunxi/linux into next/dt64
      Merge tag 'sunxi-dt-h5-for-4.12' of https://git.kernel.org/.../sunxi/linux into next/dt64
      Merge tag 'tegra-for-4.12-arm64-dt' of git://git.kernel.org/.../tegra/linux into next/dt64
      Merge tag 'qcom-arm64-for-4.12' of git://git.kernel.org/.../agross/linux into next/dt64
      Merge tag 'renesas-arm64-dt2-for-v4.12' of https://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'samsung-dt64-4.12' of git://git.kernel.org/.../krzk/linux into next/dt64
      Merge tag 'v4.12-rockchip-dts64-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64
      Merge tag 'imx-dt64-4.12' of git://git.kernel.org/.../shawnguo/linux into next/dt64
      Merge tag 'zte-dt64-4.12' of git://git.kernel.org/.../shawnguo/linux into next/dt64
      Merge tag 'hisi-arm64-dt-for-4.12' of git://github.com/hisilicon/linux-hisi into next/dt64
      Merge tag 'mvebu-dt64-4.12-2' of git://git.infradead.org/linux-mvebu into next/dt64

Orson Zhai (1):
      arm64: dts: Add basic DT to support Spreadtrum's SP9860G

Rob Herring (1):
      arm64: dts: juno: fix PCI bus dtc warnings

Rob Rice (1):
      arm64: dts: NS2: Add Broadcom SPU driver DT entry

Sarangdhar Joshi (1):
      arm64: dts: msm8996: Add ADSP PIL node

Shawn Guo (3):
      arm64: dts: zte: remove zx296718 pll_vga clock
      arm64: dts: zte: add vou and hdmi devices for zx296718
      arm64: dts: zte: add tvenc device for zx296718

Shawn Lin (1):
      arm64: dts: rockchip: fix PCIe domain number for rk3399

Stephen Boyd (1):
      arm64: dts: qcom: Replace PMU compatible with a53 specific one

Sudeep Holla (2):
      arm64: dts: juno: fix few unit address format warnings
      arm64: dts: juno: add information about L1 and L2 caches

Takeshi Kihara (2):
      arm64: dts: r8a7796: Add Cortex-A57 CPU cores
      arm64: dts: r8a7796: Add Cortex-A57 PMU node

Tang Yuantian (2):
      arm64: dts: added ecc register address to sata node on ls1043a
      arm64: dts: added ecc register address to sata node on ls1046a

Thierry Reding (12):
      arm64: tegra: Add PMC controller on Tegra186
      arm64: tegra: Add ethernet support for Tegra186
      arm64: tegra: Invert the PMC interrupt on P3310
      arm64: tegra: Enable I2C controllers on P3310
      arm64: tegra: Enable ethernet on P3310
      arm64: tegra: Add initial power tree for P3310
      arm64: tegra: Enable SDHCI controllers on P3110
      arm64: tegra: Enable SD/MMC slot on P2771
      arm64: tegra: Enable current monitors on P3310
      arm64: tegra: Add GPIO keys on P2771
      arm64: tegra: Add power monitors on P2771
      arm64: tegra: Add GPIO expanders on P2771

Thomas Petazzoni (1):
      arm64: marvell: dts: add PPv2.2 description to Armada 7K/8K

Ulrich Hecht (5):
      arm64: dts: r8a7796 dtsi: Add all HSCIF nodes
      arm64: dts: r8a7796: Add all SCIF nodes
      arm64: dts: r8a7796: Enable SCIF DMA
      arm64: dts: r8a7796: salvator-x: add SCIF1 (DEBUG1)
      arm64: dts: r8a7796: Enable HSCIF DMA

Viresh Kumar (1):
      arm64: dts: exynos: Use - instead of @ for DT OPP entries

Vladimir Barinov (2):
      arm64: dts: h3ulcb: Update memory node to 4 GiB map
      arm64: dts: h3ulcb: Fix EthernetAVB PHY timing

Wang Xiaoyin (2):
      arm64: dts: hisi: add drive strength levels of the pins for Hi3660 SoC
      arm64: dts: hisi: add pinctrl dtsi file for HiKey960 development board

Wei Xu (5):
      arm64: dts: hisi: add mbigen nodes for the hip07 SoC
      arm64: dts: hisi: add network related nodes for the hip07 SoC
      arm64: dts: hisi: add RoCE nodes for the hip07 SoC
      arm64: dts: hisi: add SAS nodes for the hip07 SoC
      arm64: dts: hisi: enable the NIC and SAS for the hip07-d05 board

Yuantian Tang (2):
      arm64: dts: updated sata node on ls1012a platform
      arm64: dts: ls1012a: add thermal monitor node

avaneesh dwivedi (1):
      arm64: dts: msm8996: Add SLPI SMP2P dt node.

jbrunet (4):
      ARM64: dts: meson-gxbb: add i2s output pins
      ARM64: dts: meson-gxbb: add spdif output pins
      ARM64: dts: meson-gxl: add i2s output pins
      ARM64: dts: meson-gxl: add spdif output pins


 .../devicetree/bindings/arm/amlogic.txt         |    3 +
 .../devicetree/bindings/arm/cavium-thunder2.txt |    8 +
 Documentation/devicetree/bindings/arm/cpus.txt  |    1 +
 Documentation/devicetree/bindings/arm/fsl.txt   |   23 +
 .../bindings/arm/hisilicon/hisilicon.txt        |    8 +
 .../devicetree/bindings/arm/rockchip.txt        |   24 +
 .../bindings/clock/amlogic,gxbb-clkc.txt        |    3 +-
 .../devicetree/bindings/clock/qoriq-clock.txt   |    1 +
 .../devicetree/bindings/soc/rockchip/grf.txt    |    1 +
 .../devicetree/bindings/vendor-prefixes.txt     |    2 +
 arch/arm/boot/dts/meson8.dtsi                   |    2 +
 arch/arm/boot/dts/meson8b.dtsi                  |    2 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi              |   45 +-
 arch/arm64/boot/dts/allwinner/Makefile          |    1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi   |   29 +
 .../dts/allwinner/sun50i-h5-orangepi-pc2.dts    |  188 +++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi    |  124 ++
 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi  |    1 +
 arch/arm64/boot/dts/amlogic/Makefile            |    2 +
 .../boot/dts/amlogic/meson-gx-p23x-q20x.dtsi    |   39 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi       |   80 +-
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts |   40 +
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts    |   80 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts |   25 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts |   11 +
 .../arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi |   29 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi   |   21 +-
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts   |   26 +
 .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts |   26 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi     |  172 ++-
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi |   43 +
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts   |   42 +
 .../arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi |    1 +
 .../amlogic/meson-gxl-s905x-hwacom-amazetv.dts  |  164 +++
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts  |  114 ++
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts |   23 +
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts   |   21 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi  |  173 +++
 .../arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi |    1 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi      |  194 +++
 .../boot/dts/amlogic/meson-gxm-nexbox-a1.dts    |   25 +
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts  |   42 +
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi      |    3 +
 arch/arm64/boot/dts/arm/juno-base.dtsi          |    4 +-
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi   |   12 +-
 arch/arm64/boot/dts/arm/juno-r1.dts             |   42 +
 arch/arm64/boot/dts/arm/juno-r2.dts             |   42 +
 arch/arm64/boot/dts/arm/juno.dts                |   42 +
 arch/arm64/boot/dts/broadcom/Makefile           |    1 -
 arch/arm64/boot/dts/broadcom/ns2-svk.dts        |   38 +-
 arch/arm64/boot/dts/broadcom/ns2-xmc.dts        |   20 +-
 arch/arm64/boot/dts/broadcom/ns2.dtsi           |   24 +
 arch/arm64/boot/dts/cavium/Makefile             |    1 +
 .../thunder2-99xx.dts}                          |    9 +-
 .../vulcan.dtsi => cavium/thunder2-99xx.dtsi}   |   15 +-
 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi  |   48 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi      |   50 +-
 arch/arm64/boot/dts/freescale/Makefile          |    4 +
 .../boot/dts/freescale/fsl-ls1012a-frdm.dts     |    4 +
 .../boot/dts/freescale/fsl-ls1012a-qds.dts      |    4 +
 .../boot/dts/freescale/fsl-ls1012a-rdb.dts      |    4 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi  |  182 ++-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi  |    4 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi  |    4 +-
 .../boot/dts/freescale/fsl-ls1088a-qds.dts      |  123 ++
 .../boot/dts/freescale/fsl-ls1088a-rdb.dts      |  107 ++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi  |  275 ++++
 .../boot/dts/freescale/fsl-ls2080a-qds.dts      |  155 +--
 .../boot/dts/freescale/fsl-ls2080a-rdb.dts      |  110 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi  |  863 ++----------
 .../boot/dts/freescale/fsl-ls2088a-qds.dts      |   64 +
 .../boot/dts/freescale/fsl-ls2088a-rdb.dts      |   64 +
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi  |  165 +++
 .../boot/dts/freescale/fsl-ls208xa-qds.dtsi     |  196 +++
 .../boot/dts/freescale/fsl-ls208xa-rdb.dtsi     |  151 +++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi  |  737 ++++++++++
 arch/arm64/boot/dts/hisilicon/Makefile          |    1 +
 .../boot/dts/hisilicon/hi3660-hikey960.dts      |    1 +
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts   |  162 +++
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi  |  411 ++++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi       |    3 +
 .../boot/dts/hisilicon/hikey960-pinctrl.dtsi    |  407 ++++++
 arch/arm64/boot/dts/hisilicon/hip07-d05.dts     |   20 +
 arch/arm64/boot/dts/hisilicon/hip07.dtsi        |  479 +++++++
 arch/arm64/boot/dts/marvell/armada-3720-db.dts  |   50 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi    |   18 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts  |   43 +
 arch/arm64/boot/dts/marvell/armada-8020.dtsi    |   10 +
 arch/arm64/boot/dts/marvell/armada-8040-db.dts  |   32 +
 arch/arm64/boot/dts/marvell/armada-8040.dtsi    |    9 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi   |   11 +
 .../boot/dts/marvell/armada-cp110-master.dtsi   |   70 +
 .../boot/dts/marvell/armada-cp110-slave.dtsi    |   60 +
 arch/arm64/boot/dts/nvidia/tegra132.dtsi        |    2 +-
 .../boot/dts/nvidia/tegra186-p2771-0000.dts     |   91 ++
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi  |  319 ++++-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi        |   59 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi        |   19 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi       |   11 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi           |   26 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi           |   46 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi            |    7 +
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts  |   29 +-
 .../boot/dts/renesas/r8a7795-salvator-x.dts     |   39 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi        |  181 ++-
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts  |    1 -
 .../boot/dts/renesas/r8a7796-salvator-x.dts     |   32 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi        |  311 ++++-
 arch/arm64/boot/dts/rockchip/Makefile           |    2 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts     |   57 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi        | 1264 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts |    2 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi        |   94 +-
 .../boot/dts/rockchip/rk3399-gru-kevin.dts      |  306 +++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi    | 1103 +++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi    |  145 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi        |  147 +-
 .../boot/dts/socionext/uniphier-ld11-ref.dts    |   10 +-
 .../arm64/boot/dts/socionext/uniphier-ld11.dtsi |   13 +-
 .../boot/dts/socionext/uniphier-ld20-ref.dts    |   10 +-
 .../arm64/boot/dts/socionext/uniphier-ld20.dtsi |    4 +-
 arch/arm64/boot/dts/sprd/Makefile               |    3 +-
 arch/arm64/boot/dts/sprd/sc9860.dtsi            |  569 ++++++++
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts       |   56 +
 arch/arm64/boot/dts/sprd/whale2.dtsi            |   71 +
 arch/arm64/boot/dts/zte/zx296718-evb.dts        |   28 +
 arch/arm64/boot/dts/zte/zx296718.dtsi           |  126 +-
 drivers/clk/meson/gxbb.h                        |   21 +-
 include/dt-bindings/clock/gxbb-clkc.h           |   11 +
 include/dt-bindings/pinctrl/hisi.h              |   15 +
 130 files changed, 11043 insertions(+), 1401 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder2.txt
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
 create mode 120000 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
 rename arch/arm64/boot/dts/{broadcom/vulcan-eval.dts => cavium/thunder2-99xx.dts} (72%)
 rename arch/arm64/boot/dts/{broadcom/vulcan.dtsi => cavium/thunder2-99xx.dtsi} (88%)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey960-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sc9860.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
 create mode 100644 arch/arm64/boot/dts/sprd/whale2.dtsi
