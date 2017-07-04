From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Jul 2017 16:25:48 +0200
Subject: [GIT PULL 6/7] ARM: 64-bit DT updates
Message-ID: <CAK8P3a2rGP7nyP7uEavaUjkdpS2uCShsr21AoPYKYDvK1=YJ5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5ed02dbb497422bf225783f46e6eadd237d23d6b:

  Linux 4.12-rc3 (2017-05-28 17:20:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt64

for you to fetch changes up to ac548add22a7916b3f38bd46b73bccf0ba6ca4cf:

  Merge tag 'mvebu-dt64-4.13-3' of git://git.infradead.org/linux-mvebu
into next/dt64 (2017-07-03 16:44:57 +0200)

----------------------------------------------------------------
ARM: 64-bit DT updates

Device-tree updates for arm64 platforms. For the first time I can
remember, this is actually larger than the corresponding branch for
32-bit platforms overall, though that has more individual changes.

A significant portion this time is due to added machine support:

- Initial support for the Realtek RTD1295 SoC, along with the Zidoo
  X9S set-top-box

- Initial support for Actions Semi S900 and the Bubblegum-96
  single-board-computer.

- Rockchips support for the rk3399-Firefly single-board-computer
  gets added, this one stands out for being relatively fast,
  affordable and well?supported, compared to many boards that
  only fall into one or two of the above categories.

- Mediatek gains support for the mt6797 mobile-phone SoC platform
  and corresponding evaluation board.

- Amlogic board support gets added for the NanoPi K2 and S905x
  LibreTech CC single-board computers and the R-Box Pro set-top-box

- Allwinner board support gets added for the OrangePi Win,
  Orangepi Zero Plus 2, NanoPi NEO2 and Orange Pi Prime single
  board computers and the SoPine system-on-module.

- Renesas board support for Salvator-XS and H3ULCB
  automotive development systems.

- Socionext Uniphier board support for LD11-global and LD20-global,
  whatever those may be.

- Broadcom adds support for the new Stingray communication processor
  in its iProc family, along with two reference boards.

Other updates include:

- For the hisicon platform, support for Hi3660-Hikey960 gets
  extended significantly.

- Lots of smaller updates for Renesas, Amlogic, Rockchip, UniPhier,
  Broadcom, Allwinner, Hisilicon, Qualcomm, Marvell, and NXP.

----------------------------------------------------------------
Andreas F?rber (31):
      dt-bindings: arm: amlogic: Reorder boards
      arm64: dts: amlogic: Sort Makefile
      arm64: dts: meson-gxbb-vega-s95: Fix Wifi node name
      arm64: dts: meson-gxbb-p20x: Fix Wifi node name
      arm64: dts: meson-gx-p23x-q20x: Fix Wifi node name
      arm64: dts: meson-gxl-s905x-khadas-vim: Fix Wifi node name
      arm64: dts: meson-gxm-nexbox-a1: Drop UART comment
      arm64: dts: meson-gxl-s905x: Comment typo fix
      arm64: dts: meson-gxbb-wetek-hub: Reference CVBS node by label
      arm64: dts: meson-gxbb: Fix node order
      arm64: dts: meson-gxbb-odroidc2: Fix node order
      arm64: dts: meson-gxbb-vega-s95: Fix node order
      arm64: dts: meson-gxbb-nexbox-a95x: Fix node order
      arm64: dts: meson-gxbb-p20x: Fix node order
      arm64: dts: meson-gxl: Fix node order
      arm64: dts: meson-gxl-s905x-nexbox-a95x: Fix node order
      arm64: dts: meson-gxm-nexbox-a1: Fix node order
      arm64: dts: meson-gx-p23x-q20x: Fix node order
      dt-bindings: Add vendor prefix for Zidoo
      dt-bindings: arm: Add Realtek RTD1295 bindings
      ARM64: dts: Add Realtek RTD1295 and Zidoo X9S
      dt-bindings: Add Kingnovel vendor prefix
      dt-bindings: arm: amlogic: Add R-Box Pro
      arm64: dts: meson-gxm: Add R-Box Pro
      dt-bindings: arm: amlogic: Add NanoPi K2
      arm64: dts: amlogic: Add NanoPi K2
      arm64: dts: allwinner: a64: Add UART2 pin nodes
      arm64: dts: allwinner: pine64: Add remaining UART aliases
      arm64: dts: allwinner: pine64: Prepare optional UART nodes with pinctrl
      dt-bindings: Add vendor prefix for uCRobotics
      arm64: dts: Add Actions Semi S900 and Bubblegum-96

Antoine Tenart (9):
      arm64: dts: marvell: add dma-mask in crypto nodes for 7k/8k
      arm64: dts: marvell: explicitly enable the mdio nodes for 7k/8k DB
      arm64: dts: marvell: disable the mdio nodes by default
      arm64: dts: marvell: cp110: enable the crypto engine at the SoC level
      arm64: dts: marvell: remove cpm crypto nodes from dts files
      arm64: dts: marvell: add a comment on the cp110 slave node status
      arm64: dts: marvell: add xmdio nodes for 7k/8k
      arm64: dts: marvell: mcbin: enable the mdio node
      arm64: dts: marvell: use new bindings for xor clocks on ap806

Anup Patel (3):
      dt-bindings: bcm: Add Broadcom Stingray bindings document
      arm64: dts: Initial DTS files for Broadcom Stingray SOC
      arm64: dts: Add PL022, PL330 and SP805 DT nodes for Stingray

Arnd Bergmann (8):
      arm64: dts: mediatek: don't include missing file
      Merge tag 'zte-dt64-4.13' of
git://git.kernel.org/.../shawnguo/linux into next/dt64
      Merge tag 'mvebu-dt64-4.13-2' of
git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'mvebu-fixes-4.12-1' of
git://git.infradead.org/linux-mvebu into next/dt64
      Revert "arm64: dts: marvell: add dma-mask in crypto nodes for 7k/8k"
      Merge tag 'amlogic-dt64-2' of
git://git.kernel.org/.../khilman/linux-amlogic into next/dt64
      Merge tag 'actions-arm64-dt-for-4.13' of
git://git.kernel.org/.../afaerber/linux-actions into next/dt64
      Merge tag 'mvebu-dt64-4.13-3' of
git://git.infradead.org/linux-mvebu into next/dt64

Bjorn Andersson (1):
      arm64: dts: apq8016-sbc: Correct WLAN LED default-trigger

Carlo Caione (1):
      ARM64: dts: meson-gx: Fix sensors reporting from SCP

Chen Feng (2):
      arm64: dts: hi3660: Add uarts nodes
      arm64: dts: hi3660: Add pl031 rtc node

Chen Jun (1):
      arm64: dts: hi3660: add power key dts node

Chen-Yu Tsai (2):
      ARM: sunxi: h3-h5: Convert R_CCU raw numbers to macros
      arm64: allwinner: a64: Convert CCU raw number references to macros

Corentin Labbe (8):
      arm: sun8i: sunxi-h3-h5: Add dt node for the syscon control module
      arm: sun8i: sunxi-h3-h5: add dwmac-sun8i ethernet driver
      arm64: allwinner: orangepi-pc2: Enable dwmac-sun8i
      arm64: allwinner: sun50i-a64: Add dt node for the syscon control module
      arm64: allwinner: sun50i-a64: add dwmac-sun8i Ethernet driver
      arm64: allwinner: pine64: Enable dwmac-sun8i
      arm64: allwinner: pine64-plus: Enable dwmac-sun8i
      arm64: allwinner: bananapi-m64: Enable dwmac-sun8i

Daniel Kurtz (1):
      arm64: dts: mt8173: Fix mdp device tree

Eric Anholt (2):
      ARM: dts: Add devicetree for the Raspberry Pi 3, for arm32 (v6)
      Merge tag 'bcm2835-dt-next-2017-06-08' into bcm2835-dt-64-next

Florian Fainelli (2):
      Merge tag 'bcm2835-dt-next-2017-03-30' into devicetree/next
      Merge tag 'bcm2835-dt-64-next-2017-06-08' into devicetree-arm64/next

Geert Uytterhoeven (16):
      arm64: dts: r8a7796: salvator-x: Enable NFS root
      arm64: dts: r8a7796: salvator-x: Set drive-strength for ravb pins
      arm64: dts: r8a7796: Add external audio clocks
      arm64: dts: r8a7796: Add external PCIe bus clock
      arm64: dts: r8a7796: Add placeholders for various devices
      arm64: dts: renesas: Extract common Salvator-X board support
      arm64: dts: renesas: Extract common ULCB board support
      arm64: dts: r8a7795: Add support for R-Car H3 ES2.0
      arm64: dts: r8a7795: salvator-x: Add support for R-Car H3 ES2.0
      arm64: dts: r8a7795: h3ulcb: Add support for R-Car H3 ES2.0
      arm64: dts: salvator-x: Add missing index to PWM pinctrl subnode name
      arm64: dts: renesas: Extract common Salvator-X/XS board support
      arm64: dts: renesas: Add common Salvator-XS board support
      arm64: dts: renesas: Add support for Salvator-XS with R-Car H3 ES2.0
      arm64: dts: r8a7795: Add reset control properties for audio
      arm64: dts: r8a7796: Add reset control properties for audio

Gerd Hoffmann (2):
      arm64: dts: bcm2837: add &sdhci and &sdhost
      ARM: dts: bcm283x: switch from &sdhci to &sdhost

Gregory CLEMENT (11):
      arm64: dts: marvell: remove clock-output-names on ap806
      arm64: dts: marvell: use new binding for the system controller on ap806
      arm64: dts: marvell: armada-3720-db: Sort the dts node alphabetically
      arm64: dts: marvell: armada-3720-db: Add information about the V2 board
      arm64: dts: marvell: armada-37xx: Align the compatible string
      arm64: dts: marvell: armada-37xx: Use angle bracket for each register set
      arm64: dts: marvell: armada-3720-db: Add vqmmc regulator for SD slot
      arm64: dts: marvell: remove *-clock-output-names on cp110
      arm64: dts: marvell: use new binding for the system controller on cp110
      arm64: dts: marvell: add pinctrl support for Armada 7K/8K
      arm64: dts: marvell: add gpio support for Armada 7K/8K

Guodong Xu (7):
      dt-bindings: arm: hisilicon: add bindings for HiKey960 board
      arm64: dts: hisilicon: update compatible string for hikey960
      arm64: dts: hikey960: add WL1837 Bluetooth device node
      arm64: dts: hikey960: add LED nodes
      dt-bindings: mfd: hi6421: Add hi6421v530 compatible string
      dt-bindings: mmc: dw_mmc-k3: add document of hi3660 mmc
      arm64: dts: hi3660-hikey960: add nodes for WiFi

Heiko Stuebner (5):
      arm64: dts: rockchip: bring rk3399-firefly power-tree in line
      arm64: dts: rockchip: add ethernet0 alias on rk3399
      arm64: dts: rockchip: enable usb3 controllers on rk3399-firefly
      arm64: dts: rockchip: introduce rk3399-op1 operating points
      arm64: dts: rockchip: update common rk3399 operating points

Helmut Klein (1):
      clk: meson-gxbb: expose UART clocks

Hoegeun Kwon (1):
      arm64: dts: exynos: Remove the te-gpios property in the TM2 boards

Icenowy Zheng (10):
      arm64: allwinner: a64: add EHCI0/OHCI0 nodes to A64 DTSI
      arm64: allwinner: a64: enable EHCI0/OHCI0 for Pine64
      arm64: allwinner: h5: add support for Orange Pi Prime board
      arm64: allwinner: h5: add support for NanoPi NEO2 board
      arm64: allwinner: a64: enable RSB on A64
      arm64: allwinner: a64: add DTSI file for SoPine SoM
      arm64: allwinner: a64: add device tree for SoPine with baseboard
      arm64: allwinner: h5: sort the device nodes in / part for some boards
      arm64: allwinner: h5: enable dwmac-sun8i for Orange Pi Prime
      arm64: allwinner: h5: enable dwmac-sun8i for Nano Pi NEO2

Jacopo Mondi (1):
      arm64: dts: salvator-x: Add current sense amplifiers

Jagan Teki (2):
      arm64: allwinner: a64: Add initial Orangepi Win/WinPlus support
      arm64: allwinner: h5: Add initial Orangepi Zero Plus 2 support

Javier Martinez Canillas (1):
      arm64: dts: ls1043a: Add generic compatible string for I2C EEPROM

Jeremy McNicoll (2):
      arm64: dts: msm8992 add fixed regulator
      arm64: dts: smem enablement for msm8992

Jerome Brunet (6):
      clk: meson-gxbb: expose spdif clock gates
      clk: meson-gxbb: expose i2s master clock
      clk: meson-gxbb: expose spdif master clock
      dt-bindings: add Libre Technology vendor prefix
      dt-bindings: arm: amlogic: Add Libre Technology CC board
      ARM64: dts: meson-gxl: Add Libre Technology CC support

John Stultz (1):
      arm64: dts: hi6220: Add k3-dma and i2s/hdmi audio support

Jun Gao (1):
      dt-bindings: i2c: Add Mediatek MT2701 i2c binding

Kever Yang (4):
      dt-bindings: add firefly-rk3399 board support
      arm64: dts: rockchip: add support for firefly-rk3399 board
      arm64: dts: rockchip: add some missing qos nodes on rk3399
      arm64: dts: rockchip: add pinctrl settings for some rk3399 peripherals

Kevin Hilman (1):
      Merge tag 'meson-clk-headers-for-4.13' of
git://github.com/BayLibre/clk-meson into v4.13/dt64

Koji Matsuoka (1):
      arm64: dts: renesas: r8a7795-salvator-x: Enable HDMI outputs

Konstantin Porotchkin (1):
      arm64: dts: marvell: Enable second SDHCI controller in Armada 37xx

Kunihiko Hayashi (2):
      arm64: dts: uniphier: add support for LD11 Global board
      arm64: dts: uniphier: add support for LD20 Global board

Kuninori Morimoto (9):
      arm64: dts: r8a7796: add AUDIO_DMAC support
      arm64: dts: r8a7796: add Sound SSI PIO support
      arm64: dts: r8a7796: add Sound SSI DMA support
      arm64: dts: r8a7796: add Sound SRC support
      arm64: dts: r8a7796: add Sound DVC support
      arm64: dts: r8a7796: add Sound CTU support
      arm64: dts: r8a7796: add Sound MIX support
      arm64: dts: salvator-x: add 12288000 for sound ADG
      arm64: dts: ulcb: add 12288000 for sound ADG

Laurent Pinchart (4):
      arm64: dts: salvator-x: Add panel backlight support
      arm64: dts: renesas: salvator-x: Add DU external dot clock sources
      arm64: dts: renesas: salvator-x: Add HDMI output connectors
      arm64: dts: renesas: r8a7795-salvator-x: Add DU external dot clocks

Leo Yan (1):
      arm64: dts: hi3660: add sp804 timer node

Li Wei (1):
      arm64: dts: hi3660: add sd/sdio device nodes

Li Yang (1):
      arm64: dts: freescale: update the copyright claims

Madalin Bucur (6):
      arm64: dts: add DPAA QBMan portals
      arm64: dts: add LS1043A DPAA QBMan nodes
      arm64: dts: add LS1046A DPAA QBMan nodes
      arm64: dts: add DPAA FMan nodes
      arm64: dts: add LS1043A DPAA FMan support
      arm64: dts: add LS1046A DPAA FMan nodes

Marc Zyngier (2):
      arm64: dts: marvell: 8040-mcbin: Enable 1GB Ethernet
      ARM64: dts: marvell: armada37xx: Fix timer interrupt specifiers

Marcin Wojtas (1):
      arm64: dts: marvell: add second 1G port on the Armada 8040 DB

Mars Cheng (4):
      dt-bindings: mediatek: Add bindings for mediatek MT6797 Platform
      arm64: dts: mediatek: add mt6797 support
      dt-bindings: mediatek: add MT6797 power dt-bindings
      arm64: dts: mediatek: add clk and scp nodes for MT6797

Martin Blumenstingl (1):
      clk: meson-gxbb: un-export the CPU clock

Masahiro Yamada (5):
      arm64: dts: uniphier: add input-delay properties to Cadence eMMC node
      arm64: dts: uniphier: add cdns, phy-dll-delay-sdclk(-hsmmc) for eMMC
      arm64: dts: uniphier: fix simple-bus unit address format error
      arm64: dts: uniphier: reserve more memory for LD11/LD20
      arm64: dts: uniphier: use SPDX-License-Identifier

Matthias Brugger (4):
      dt-bindings: mtk-sysirq: Correct bindings for supported SoCs
      dt-bindings: i2c-mt6577: Rename file to reflect bindings
      dt-bindings: i2c-mtk: Delete bindings
      dt-bindings: i2c-mtk: Add mt7623 binding

Mikko Perttunen (1):
      arm64: tegra: Add CCPLEX_CLUSTER area in Tegra186

Neil Armstrong (14):
      clk: meson-gxbb: expose SPICC gate
      ARM64: dts: meson-gxl: Fix pinctrl periphs gpio-ranges
      ARM64: dts: Fix GXL periphs pinctrl pull-enable register base
      ARM64: dts: Fix GXBB periphs pinctrl pull-enable register base
      ARM64: dts: meson-gxbb: Add CEC pins nodes
      ARM64: dts: meson-gxl: Add CEC pins nodes
      ARM64: dts: meson-gxl: Add Ethernet PHY LEDS pins nodes
      ARM64: dts: meson-gxbb: Add SPI pinctrl nodes
      ARM64: dts: meson-gxl: Add SPI pinctrl nodes
      ARM64: dts: meson-gxbb-wetek-play2: Add HDMI and CVBS Nodes
      ARM64: dts: meson-gxl-s905d-p230: Add HDMI nodes
      ARM64: dts: meson-gxl-s905x-khadas-vim: Add HDMI nodes
      ARM64: dts: meson-gxl-s905x-p212: Add HDMI and CVBS nodes
      ARM64: dts: meson-gx: Add SPICC nodes

Olof Johansson (17):
      Merge tag 'renesas-arm64-dt-for-v4.13' of
https://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'realtek-arm64-dt-for-4.12' of
git://github.com/afaerber/linux into next/dt64
      Merge tag 'v4.13-rockchip-dts64-1' of
git://git.kernel.org/.../mmind/linux-rockchip into next/dt64
      Merge tag 'samsung-dt64-4.13' of
git://git.kernel.org/.../krzk/linux into next/dt64
      Merge tag 'v4.12-next-dts64' of
https://github.com/mbgg/linux-mediatek into next/dt64
      Merge tag 'uniphier-dt64-v4.13' of
git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt64
      Merge tag 'arm-soc/for-4.13/devicetree-arm64' of
http://github.com/Broadcom/stblinux into next/dt64
      Merge tag 'amlogic-dt64' of
git://git.kernel.org/.../khilman/linux-amlogic into next/dt64
      Merge tag 'sunxi-dt64-for-4.13' of
https://git.kernel.org/.../sunxi/linux into next/dt64
      Merge tag 'sunxi-dt-h5-for-4.13' of
https://git.kernel.org/.../sunxi/linux into next/dt64
      Merge tag 'juno-updates-4.13' of
git://git.kernel.org/.../sudeep.holla/linux into next/dt64
      Merge tag 'hisi-arm64-dt-for-4.13-v2' of
git://github.com/hisilicon/linux-hisi into next/dt64
      Merge tag 'tegra-for-4.13-arm64-dt' of
git://git.kernel.org/.../tegra/linux into next/dt64
      Merge tag 'qcom-arm64-for-4.13' of
git://git.kernel.org/.../agross/linux into next/dt64
      Merge tag 'renesas-arm64-dt2-for-v4.13' of
https://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'mvebu-dt64-4.13-1' of
git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'imx-dt64-4.13' of
git://git.kernel.org/.../shawnguo/linux into next/dt64

Oza Pawandeep (1):
      arm64: dts: Add I2C DT nodes for Stingray SoC

Prabhakar Kushwaha (2):
      arm64: dts: Define big endian of IFC for LS1043a/LS1046a
      arm64: dts: Add flash node for ls1088a qds and rdb

Pramod Kumar (3):
      arm64: dts: Add NAND DT nodes for Stingray SOC
      arm64: dts: Add pinctrl DT nodes for Stingray SOC
      arm64: dts: Add GPIO DT nodes for Stingray SOC

Rajendra Nayak (1):
      arm64: dts: msm8996: Add CPU clock controller node

Ran Wang (1):
      arm64: dts: ls1046a: Add dis_rxdet_inp3_quirk property to USB3 node

Raviteja Garimella (1):
      arm64: dts: NS2: Add USB DRD PHY device tree node

Rob Herring (1):
      arm64: dts: nvidia: fix PCI bus dtc warnings

Robin Murphy (1):
      arm64: dts: juno: enable some SMMUs

Russell King (2):
      arm64: dts: marvell: mcbin: add sdhci
      arm64: dts: marvell: cp110: add required clocks for mdio interface

Sandeep Tripathy (2):
      dt-bindings: clk: Extend binding doc for Stingray SOC
      arm64: dts: Add clock DT nodes for Stingray SOC

Scott Wood (1):
      arm64: dts: ls1012a: Add coreclk

Sean Wang (1):
      dt-bindings: mediatek: add bindings for MediaTek MT7622 SoC

Shawn Lin (3):
      arm64: dts: rockchip: extent bus-ranges of PCIe for rk3399
      arm64: dts: rockchip: extent IORESOURCE_MEM_64 of PCIe for rk3399
      arm64: dts: rockchip: add sdmmc/sdio/emmc nodes for RK3328 SoCs

Simon Horman (3):
      arm64: dts: m3ulcb: Fix EthernetAVB PHY timing
      arm64: dts: r8a7795: update PFC node name to pin-controller
      arm64: dts: ulcb: Set drive-strength for ravb pins

Srinath Mannam (1):
      arm64: dts: Add PWM and SDHCI DT nodes for Stingray SOC

Stefan Wahren (2):
      ARM: dts: bcm283x: Add CPU thermal zone with 1 trip point
      ARM64: dts: bcm2837: Define CPU thermal coefficients

Stephen Boyd (1):
      arm64: dts: qcom: Collapse usb support into one node

Suzuki K Poulose (1):
      arm64: dts: juno: add coresight CPU debug nodes

Takeshi Kihara (2):
      arm64: dts: r8a7795: salvator-x: Update memory node to 4 GiB map
      arm64: dts: r8a7796: Add PWM device nodes

Thomas Petazzoni (2):
      arm64: dts: marvell: add clocks for Armada AP806 XOR engines
      arm64: dts: marvell: enable GICP and ICU on Armada 7K/8K

Ulrich Hecht (1):
      arm64: dts: renesas: r8a7795: Add HDMI encoder support

Viresh Kumar (2):
      arm64: dts: uniphier: Use - instead of @ for DT OPP entries
      arm64: dts: zte: Use - instead of @ for DT OPP entries

Vladimir Barinov (5):
      arm64: dts: m3ulcb: enable I2C
      arm64: dts: m3ulcb: Update memory node to 2 GiB map
      arm64: dts: m3ulcb: enable EthernetAVB
      arm64: dts: m3ulcb: enable HS200 for eMMC
      arm64: dts: h3ulcb: enable HS200 for eMMC

Wang Xiaoyin (4):
      arm64: dts: hikey960: pinctrl: add more pinmux and pinconfig
      arm64: dts: hi3660: add gpio dtsi file for Hisilicon Hi3660 SOC
      arm64: dts: hi3660: add spi device nodes
      arm64: dts: hikey960: add device node for pmic and regulators

Wolfram Sang (4):
      arm64: dts: r8a7795: salvator-x: enable HS200 for eMMC
      arm64: dts: r8a7796: salvator-x: enable HS200 for eMMC
      arm64: dts: r8a7795: add DMA for IIC_DVFS
      arm64: dts: r8a7796: add DMA for IIC_DVFS

Xiaowei Song (2):
      dt-bindings: PCI: hisi: Add document for PCIe of Kirin SoCs
      arm64: dts: hisi: add kirin pcie node

Yangbo Lu (5):
      mmc: dt: add compatible into eSDHC required properties
      arm64: dts: ls1046a: support SD UHS-I and eMMC HS200 on RDB
      arm64: dts: ls208xa: support SD UHS-I on RDB and eMMC HS200 on QDS
      arm64: dts: ls1012a: add eSDHC nodes
      arm64: dts: ls1088a: add esdhc node

Yuantian Tang (4):
      arm64: dts: ls1088a: update the sata node
      arm64: dts: ls1088a: Add TMU device tree support
      dt-bindings: ahci-fsl-qoriq: add ls1088a chip name to the list
      arm64: dts: ls1088a: update sata node

Zhangfei Gao (2):
      arm64: dts: hi3660: add resources for clock and reset
      arm64: dts: Add I2C nodes for Hi3660

chunfeng.yun at mediatek.com (2):
      arm64: dts: mt8173: split usb SuperSpeed port into two ports
      arm64: dts: mt8173: move clock from phy node into port nodes

yinbo.zhu (1):
      arm64: dts: ls208xa: disable SD UHS-I modes by default on RDB

 Documentation/devicetree/bindings/arm/amlogic.txt  |  23 +-
 .../devicetree/bindings/arm/bcm/brcm,stingray.txt  |  12 +
 .../bindings/arm/hisilicon/hisilicon.txt           |   4 +
 Documentation/devicetree/bindings/arm/mediatek.txt |   8 +
 Documentation/devicetree/bindings/arm/realtek.txt  |  20 +
 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |   2 +-
 .../bindings/clock/brcm,iproc-clocks.txt           |  76 ++
 .../bindings/i2c/{i2c-mt6577.txt => i2c-mtk.txt}   |  10 +-
 .../interrupt-controller/mediatek,sysirq.txt       |  28 +-
 Documentation/devicetree/bindings/mfd/hi6421.txt   |   4 +-
 .../devicetree/bindings/mmc/fsl-esdhc.txt          |  14 +
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   1 +
 .../devicetree/bindings/pci/kirin-pcie.txt         |  50 ++
 .../devicetree/bindings/serial/mtk-uart.txt        |   2 +
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |   6 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   2 +-
 arch/arm/boot/dts/bcm2835.dtsi                     |   4 +
 arch/arm/boot/dts/bcm2836.dtsi                     |   4 +
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |   1 +
 arch/arm/boot/dts/bcm283x.dtsi                     |  21 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  48 +-
 arch/arm64/boot/dts/Makefile                       |   2 +
 arch/arm64/boot/dts/actions/Makefile               |   5 +
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  |  35 +
 arch/arm64/boot/dts/actions/s900.dtsi              | 164 +++++
 arch/arm64/boot/dts/allwinner/Makefile             |   5 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  15 +
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |  95 +++
 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  |  17 +-
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  57 ++
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  | 126 ++++
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi      |  65 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 137 +++-
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 161 +++++
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  |  27 +
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts     | 232 ++++++
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    |  92 +++
 arch/arm64/boot/dts/amlogic/Makefile               |   9 +-
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  60 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |  11 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      | 291 ++++++++
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  52 +-
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 108 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |  66 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  56 +-
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      |   6 +-
 .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts    |  40 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 220 +++---
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts      |  24 +
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     |  25 +-
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |  92 +++
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |  52 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      |  23 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi   |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 127 +++-
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  87 ++-
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts | 240 +++++++
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  58 +-
 arch/arm64/boot/dts/arm/juno-r1.dts                |  24 +
 arch/arm64/boot/dts/arm/juno-r2.dts                |  24 +
 arch/arm64/boot/dts/arm/juno.dts                   |  24 +
 arch/arm64/boot/dts/broadcom/Makefile              |   1 +
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   |  17 +
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi          |   4 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  14 +
 arch/arm64/boot/dts/broadcom/stingray/Makefile     |   6 +
 .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 131 ++++
 .../boot/dts/broadcom/stingray/bcm958742k.dts      |  78 +++
 .../boot/dts/broadcom/stingray/bcm958742t.dts      |  40 ++
 .../boot/dts/broadcom/stingray/stingray-clock.dtsi | 170 +++++
 .../dts/broadcom/stingray/stingray-pinctrl.dtsi    | 345 +++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 460 ++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |   1 -
 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  |  10 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  |  15 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  39 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi |  45 ++
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |   4 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |  79 ++-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  69 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi |  48 ++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  |   4 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  |  70 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  75 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts  |  28 +
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts  |  20 +
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     | 111 ++-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts  |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dts  |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts  |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi     |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi |   4 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   5 +-
 .../boot/dts/freescale/qoriq-bman-portals.dtsi     |  71 ++
 .../boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi    |  42 ++
 .../boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi    |  42 ++
 .../boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi     |  41 ++
 .../boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi     |  41 ++
 .../boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi     |  41 ++
 .../boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi     |  41 ++
 .../boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi     |  41 ++
 .../boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi     |  41 ++
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   |  81 +++
 .../boot/dts/freescale/qoriq-qman-portals.dtsi     |  80 +++
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  | 217 +++++-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          | 706 ++++++++++++++++++-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |  34 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  26 +
 .../arm64/boot/dts/hisilicon/hikey960-pinctrl.dtsi | 778 +++++++++++++++++++--
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     | 120 ++--
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  37 +-
 arch/arm64/boot/dts/marvell/armada-7020.dtsi       |   2 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |   6 +-
 arch/arm64/boot/dts/marvell/armada-7040.dtsi       |   2 +-
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi       |  68 ++
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |   3 +-
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     |  24 +-
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |  42 ++
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   3 +-
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi       |  76 ++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  48 +-
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 146 ++--
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 147 ++--
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 arch/arm64/boot/dts/mediatek/mt6797-evb.dts        |  36 +
 arch/arm64/boot/dts/mediatek/mt6797.dtsi           | 244 +++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           | 153 ++--
 arch/arm64/boot/dts/nvidia/tegra132.dtsi           |   4 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   7 +
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts |   2 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   4 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  36 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  62 +-
 arch/arm64/boot/dts/qcom/msm8992.dtsi              |  53 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   6 +
 arch/arm64/boot/dts/realtek/Makefile               |   5 +
 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts  |  42 ++
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           | 131 ++++
 arch/arm64/boot/dts/renesas/Makefile               |   2 +
 arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dts |  42 ++
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    | 115 +++
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       |  84 +++
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     | 342 +--------
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 565 ++-------------
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts | 109 +++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 133 ++--
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts     | 168 +----
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 244 +------
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 421 +++++++++++
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   | 629 +++++++++++++++++
 arch/arm64/boot/dts/renesas/salvator-x.dtsi        |  30 +
 arch/arm64/boot/dts/renesas/salvator-xs.dtsi       |  20 +
 arch/arm64/boot/dts/renesas/ulcb.dtsi              | 367 ++++++++++
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  33 +
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    | 718 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi   | 145 ++++
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi       |  18 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 165 ++++-
 arch/arm64/boot/dts/socionext/Makefile             |   2 +
 .../boot/dts/socionext/uniphier-ld11-global.dts    |  70 ++
 .../arm64/boot/dts/socionext/uniphier-ld11-ref.dts |  38 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |  61 +-
 .../boot/dts/socionext/uniphier-ld20-global.dts    |  52 ++
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |  38 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |  79 +--
 arch/arm64/boot/dts/zte/zx296718.dtsi              |  10 +-
 drivers/clk/meson/gxbb.h                           |  20 +-
 include/dt-bindings/clock/bcm-sr.h                 | 101 +++
 include/dt-bindings/clock/gxbb-clkc.h              |  10 +-
 .../dt-bindings/pinctrl/brcm,pinctrl-stingray.h    |  68 ++
 180 files changed, 11550 insertions(+), 2407 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
 create mode 100644 Documentation/devicetree/bindings/arm/realtek.txt
 rename Documentation/devicetree/bindings/i2c/{i2c-mt6577.txt =>
i2c-mtk.txt} (77%)
 create mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-b.dts
 create mode 100644 arch/arm64/boot/dts/actions/Makefile
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
 create mode 100644 arch/arm64/boot/dts/actions/s900.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
 create mode 100644
arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
 create mode 100644
arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/Makefile
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-clock.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-bman-portals.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-qman-portals.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-70x0.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-80x0.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6797.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/Makefile
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
 create mode 100644 arch/arm64/boot/dts/renesas/salvator-common.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/salvator-x.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/salvator-xs.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/ulcb.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
 create mode 100644 include/dt-bindings/clock/bcm-sr.h
 create mode 100644 include/dt-bindings/pinctrl/brcm,pinctrl-stingray.h
